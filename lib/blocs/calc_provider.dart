import 'package:flutter/material.dart';
import 'calc_bloc.dart';


class CalcBlocProvider extends InheritedWidget {
  const CalcBlocProvider({Key? key,required Widget child}) : super(key: key, child: child);

  //CalcBlocクラスをインスタンス
  CalcBloc get bloc => CalcBloc();

  @override
  //Widgetの変更を監視するためのフラグ？
  bool updateShouldNotify(_) => false;
//直下にあるWidgetのインスタンスを得られるようにする
  static CalcBlocProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CalcBlocProvider>();
  }
}