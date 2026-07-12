import 'package:flutter_bloc/flutter_bloc.dart';

class NavIndexCubit extends Cubit<int> {
  NavIndexCubit() : super(0);

  void navigateTo(int newIndex) => emit(newIndex);
}
