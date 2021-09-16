import 'package:flutter/material.dart';
import 'blocs/calc_bloc.dart';
import 'blocs/calc_provider.dart';

class CalcScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = CalcBlocProvider.of(context)!.bloc;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _text(bloc),
            _button(bloc),
          ],
        ),
      ),
    );
  }

  Widget _text(CalcBloc bloc) {
    return StreamBuilder<String>(
      stream: bloc.onAdd,
      //snapshotとはStreamで指定した値を代入している？
      builder: (context, snapshot) {
        return Text(
          snapshot.hasData ? snapshot.data.toString() : '',
          style: TextStyle(fontSize: 38.0),
        );
      },
    );
  }

  Widget _button(CalcBloc bloc) {
    return StreamBuilder<bool>(
      //トグル状態を受け取る
      stream: bloc.onToggle,
      //snapshotとはStreamで指定した値を代入している？
      builder: (context, snapshot) {
        return Opacity(
          //スナップショットの状態をみて透明化の決定
          opacity: snapshot.hasData && snapshot.data! ? 1.0 : 0.0,
          child: ElevatedButton(
            child: const Text('スタート'),
            //カウントスタート
            onPressed: () => bloc.start.add(null),
          ),
        );
      },
    );
  }
}