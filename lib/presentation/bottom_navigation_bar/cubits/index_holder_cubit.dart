import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class PageIndexHolderCubit extends Cubit<int> {
  PageIndexHolderCubit() : super(0);

//***** UPDATE PAGE INDEX */
  Future<void> updatePageIndex(int index) async {
    debugPrint('Page Index in Cubit $index');
    emit(index);
  }
}
