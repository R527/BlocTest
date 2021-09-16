import 'package:flutter/material.dart';
import 'blocs/calc_provider.dart';
import 'screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //CalcBlocProviderクラスを経由する？
      home: CalcBlocProvider(
        //CalcScreenを表示するだけ
        child: CalcScreen(),
      ),
    );
  }
}