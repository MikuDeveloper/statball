import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:statball/app/config/routes/routes.dart';
import 'package:statball/app/config/themes/app_colors.dart';
import 'package:statball/app/providers/global/school_principals_provider.dart';
import 'package:statball/domain/index.dart' show SchoolPrincipal;

import 'widgets/school_principal_list_tile.dart';

// ════════════════════════════════════════════════════════════════════════════
//  SCHOOL PRINCIPALS SCREEN — catálogo de directores (super_scout).
//  Mismo patrón que /schools: lista responsive, búsqueda, CRUD via form.
// ════════════════════════════════════════════════════════════════════════════
class SchoolPrincipalsScreen extends ConsumerStatefulWidget {
  const SchoolPrincipalsScreen({super.key});

  @override
  ConsumerState<SchoolPrincipalsScreen> createState() =>
      _SchoolPrincipalsScreenState();
}

class _SchoolPrincipalsScreenState
    extends ConsumerState<SchoolPrincipalsScreen> {
  final _searchCtrl = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final async = ref.watch(schoolPrincipalsProvider);

    return Scaffold(
      backgroundColor: AppColors.bgLight,
      appBar: AppBar(
        backgroundColor: AppColors.bgLight,
        surfaceTintColor: AppColors.bgLight,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        title: const Text(
          'Directores',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Recargar',
            icon: const Icon(Icons.refresh_rounded),
            onPressed: async.isLoading
                ? null
                : () => ref.read(schoolPrincipalsProvider.notifier).refresh(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => const SchoolPrincipalFormRoute().push<void>(context),
        backgroundColor: AppColors.accentDark,
        foregroundColor: AppColors.onAccent,
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Nuevo director',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            _SearchBar(
              controller: _searchCtrl,
              onChanged: (v) => setState(() => _query = v.trim().toLowerCase()),
            ),
            Expanded(
              child: async.when(
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.accentDark),
                ),
                error: (e, _) => _ErrorView(
                  message: e.toString(),
                  onRetry: () =>
                      ref.read(schoolPrincipalsProvider.notifier).refresh(),
                ),
                data: (principals) {
                  final filtered = _filter(principals);
                  if (principals.isEmpty) return const _EmptyView();
                  if (filtered.isEmpty) return const _NoMatchView();
                  return _PrincipalsList(principals: filtered);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<SchoolPrincipal> _filter(List<SchoolPrincipal> all) {
    if (_query.isEmpty) return all;
    return all.where((p) {
      final hay = [p.name, p.lastname, p.email ?? ''].join(' ').toLowerCase();
      return hay.contains(_query);
    }).toList();
  }
}

class _PrincipalsList extends ConsumerWidget {
  final List<SchoolPrincipal> principals;
  const _PrincipalsList({required this.principals});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width >= 720;
    final bottomGap = MediaQuery.of(context).padding.bottom + 96;

    return RefreshIndicator(
      color: AppColors.accentDark,
      onRefresh: () => ref.read(schoolPrincipalsProvider.notifier).refresh(),
      child: isWide
          ? GridView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(20, 12, 20, bottomGap),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 420,
                mainAxisExtent: 96,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: principals.length,
              itemBuilder: (_, i) =>
                  SchoolPrincipalListTile(principal: principals[i]),
            )
          : ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 12, 16, bottomGap),
              itemCount: principals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 8),
              itemBuilder: (_, i) =>
                  SchoolPrincipalListTile(principal: principals[i]),
            ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: 'Buscar por nombre o correo...',
          hintStyle: const TextStyle(color: AppColors.textMuted),
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.textMuted,
          ),
          filled: true,
          fillColor: AppColors.card,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.cardBorder),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: AppColors.cardBorder),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(
              color: AppColors.accentDark,
              width: 1.4,
            ),
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: const BoxDecoration(
                color: AppColors.accentAltSurface,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.badge_rounded,
                color: AppColors.accentAlt,
                size: 48,
              ),
            ),
            const SizedBox(height: 18),
            const Text(
              'Aún no hay directores',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Crea el primero con el botón “Nuevo director”.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13.5, color: AppColors.textMuted),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoMatchView extends StatelessWidget {
  const _NoMatchView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 42,
              color: AppColors.textMuted,
            ),
            SizedBox(height: 12),
            Text(
              'Sin resultados para tu búsqueda',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13.5),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: AppColors.error,
              size: 44,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.accentDark,
                foregroundColor: AppColors.onAccent,
              ),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
