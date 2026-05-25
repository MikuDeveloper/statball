# Statball — Guía para Claude Code

App Flutter de scouting deportivo. Backend: Supabase. Equipo: Grupo Tasha.

## Stack

- Flutter SDK `^3.11.5` (Dart 3 con dot-shorthand syntax habilitado)
- `flutter_riverpod` 3.x con `riverpod_generator` + `riverpod_lint`
- `reactive_forms` 18 para formularios
- `freezed` 3 + `json_serializable` (snake_case via `FieldRename.snake`)
- `go_router` 17 + `go_router_builder` (typed routes)
- `supabase_flutter` 2.12
- `flutter_dotenv` (carga `.env` desde assets)
- `logging` para logs estructurados

Targets de build: android, ios, web, windows.

## Arquitectura — Clean Architecture en `lib/`

```
lib/
├── main.dart                      # entrypoint: dotenv, Supabase.initialize, runApp
├── app/
│   ├── app.dart                   # MaterialApp.router con themes
│   ├── config/
│   │   ├── logger/                # setupLogging()
│   │   ├── routes/                # routerConfig + typed GoRoutes + redirect auth
│   │   └── themes/                # AppColors + AppTheme (light/dark)
│   ├── global/                    # constants, enums (SlideFrom, DataStatus), utils
│   └── providers/
│       ├── app_provider.dart      # ProviderContainer raíz (AppProvider.container)
│       ├── cubits/                # state holders (sb_user_cubit)
│       ├── forms/                 # reactive_forms providers por feature
│       ├── global/                # isLoading, sbUserData, etc.
│       ├── repositories/          # use-case providers (sbUserUseCaseProvider)
│       └── utils/                 # DataEventState
├── domain/
│   ├── index.dart                 # barrel
│   ├── models/<entity>/           # freezed model + repository abstracto
│   └── use_cases/                 # casos de uso (orquestan repos)
├── infrastructure/
│   ├── index.dart                 # barrel
│   ├── driven_adapter/<entity>/   # implementación del repository (API Supabase)
│   └── helpers/exceptions/        # excepciones tipadas por feature
└── ui/
    ├── common/                    # animations, figures, forms, painters, widgets
    └── screens/<feature>/         # screen + widgets internos
```

### Convenciones obligatorias

- Cualquier modelo nuevo va en `lib/domain/models/<name>/` con su `.freezed.dart` y `.g.dart`. Después correr `dart run build_runner build`.
- Cualquier API nueva en `lib/infrastructure/driven_adapter/<name>/`, implementando el `Repository` abstracto de domain.
- Excepciones tipadas en `lib/infrastructure/helpers/exceptions/` (ver `SbUserApiException` como ejemplo: códigos string como `'auth_error'`, `'database_error'`, `'network_error'`, `'unknow_error'`).
- Providers de Riverpod usan codegen (`@riverpod`); regenerar con build_runner tras crearlos.
- Forms reactivos en `lib/app/providers/forms/<feature>_form_provider.dart`.
- Screens en `lib/ui/screens/<feature>/<feature>_screen.dart` + carpeta `widgets/`.
- Rutas tipadas en `lib/app/config/routes/routes.dart` con anotaciones `@TypedGoRoute`. Regenerar `routes.g.dart` con build_runner.
- `lib/ui/common/` para widgets reusables (botones, controls de form, painters, snackbars mixin, etc.).
- Lints estrictos: `strict-casts`, `strict-inference`, `strict-raw-types`, `prefer_single_quotes`, `prefer_const_constructors`, `always_declare_return_types`, `avoid_print`. Usa `Logger` (de `package:logging`), nunca `print`.

## Comandos

```bash
flutter pub get                       # instalar deps
dart run build_runner build           # regenerar *.g.dart, *.freezed.dart
dart run build_runner build --delete-conflicting-outputs   # si hay conflictos
flutter analyze                       # lint
flutter test                          # unit tests (en test/)
flutter run -d chrome                 # web
flutter run -d windows                # windows
```

## Configuración (.env)

Variables requeridas en `.env` (raíz del repo, no se commitea):

```
SUPABASE_URL=https://wsxsmospaoqqkmnnzmrd.supabase.co
SUPABASE_KEY=<anon JWT del proyecto Statball>
```

El `.env` está declarado como asset en `pubspec.yaml` y se carga vía `flutter_dotenv` en `main.dart` antes de `Supabase.initialize`.

## Supabase — proyecto Statball (org Grupo Tasha)

- Project ref: `wsxsmospaoqqkmnnzmrd`
- URL: `https://wsxsmospaoqqkmnnzmrd.supabase.co`
- Postgres 17

### Tablas `public`

| Tabla              | Notas                                                         |
|--------------------|---------------------------------------------------------------|
| `profiles`         | FK a `auth.users.id`. Trigger `on_auth_user_created` rellena. Roles: `scout`, `super_scout` (enum `scout_role_enum`). |
| `schools`          | Catálogo. Bigint id (serial).                                 |
| `school_principals`| Catálogo. FK desde `schools.principal_id`.                    |
| `teams`            | UUID id. FK a `schools`. Enum `team_gender_enum` (Masculino/Femenino/Mixto). |
| `players`          | UUID id. FK a `teams`. Enum `foot_enum` (Izquierda/Derecha/Ambidiestro). |
| `scouts`           | UUID id. Catálogo de scouts.                                  |
| `matches`          | Bigint id. FK a `teams` (local/visitor).                      |
| `matches_players`  | Bigint id. Stats en jsonb: `stats_physics`, `stats_qual`, `stats_tech`. |
| `matches_events`   | Bigint id. Eventos por partido. `details` en jsonb.           |
| `scouts_matches`   | Bigint id. Asignación scout↔match.                            |

### RLS

Habilitado en todas las tablas `public`. Políticas aplicadas:

- **Catálogos** (`schools`, `school_principals`, `teams`, `players`, `scouts`): SELECT abierto a `authenticated`. INSERT/UPDATE/DELETE solo `super_scout`.
- **Operación** (`matches`, `matches_players`, `matches_events`, `scouts_matches`): SELECT/INSERT/UPDATE abiertos a `authenticated`. DELETE solo `super_scout`.
- **`profiles`**: cada usuario ve/edita el suyo; `super_scout` ve/edita todos.

Para verificar rol del usuario actual en SQL: `SELECT public.get_user_role();`.

### Auth

Provider activo: email/password. Trigger `on_auth_user_created` (AFTER INSERT en `auth.users`) llama `public.handle_new_user()` que crea el row en `public.profiles` con email y rol default `scout`.

## Login (ya implementado)

- Pantalla: `lib/ui/screens/login/login_screen.dart`
- Form: `lib/app/providers/forms/login_form_provider.dart` (reactive_forms)
- Reset pass: `/login/forgot-password` → `lib/ui/screens/forgot_password/`
- API: `lib/infrastructure/driven_adapter/sb_user/sb_user_api.dart`
- Use case: `lib/domain/use_cases/sb_user_use_case.dart`
- Redirect logic: `lib/app/config/routes/router.dart` (si no logueado → `/login`; si logueado → `/home`).

NO romper el contrato existente de `SbUser` (`id`, `email`, `role`, `createdAt`) al añadir features.

## Próximas features esperadas

UI/forms para gestionar `schools`, `school_principals`, `teams`, `players`, `scouts`, programación de `matches`, captura de `matches_players` con sus stats jsonb y `matches_events` durante el partido.

Patrón a seguir por feature nueva (ej. "players"):

1. `lib/domain/models/player/player.dart` (freezed + json_serializable)
2. `lib/domain/models/player/repository/player_repository.dart` (abstract)
3. `lib/domain/use_cases/player_use_case.dart`
4. `lib/infrastructure/driven_adapter/player/player_api.dart`
5. `lib/infrastructure/helpers/exceptions/player_api_exception.dart`
6. `lib/app/providers/repositories/player_use_case_provider.dart` (@riverpod)
7. `lib/app/providers/forms/player_form_provider.dart` si hay form
8. `lib/ui/screens/players/players_screen.dart` + widgets
9. Ruta tipada en `lib/app/config/routes/routes.dart`
10. `dart run build_runner build`
