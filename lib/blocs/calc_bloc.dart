import 'dart:async';
import 'dart:math' show Random;

class CalcBloc {
  final _startController = StreamController<void>();
  final _calcController = StreamController<int>();
  final _outputController = StreamController<String>();
  final _btnController = StreamController<bool>();

  // 入力用sinkのGetter
  //getは受け取り専用？
  StreamSink<void> get start => _startController.sink;

  // 出力用streamのGetter
  Stream<String> get onAdd => _outputController.stream;
  Stream<bool> get onToggle => _btnController.stream;

  static const _repeat = 2;
  int _sum = 0;
  var _timer;

  //上部のクラスと名前かぶっていて処理内容がいまいち理解できていない
  CalcBloc() {

    print('blocClass');//→表示されないのでメソッドではない？
    // スタートボタンが押されるのを待つ（ブログのコメント内容で理解してない）
    //Start関数を_startControllerから受け取る？
    _startController.stream.listen((_) => _start());

    // 秒数が通知されるのを待つ
    _calcController.stream.listen((count) => _calc(count));

    // ボタンの表示を指示する
    //フラグを登録する
    _btnController.sink.add(true);
  }

  //SetUp
  void _start() {
    print('Start');
    _sum = 0;
    //空のStringを登録する
    _outputController.sink.add('');
    //ボタンを透明化する
    _btnController.sink.add(false);

    // 1秒ごとに秒数を通知
    //一秒ごとに_calcControllerに数字を登録する
    _timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      _calcController.sink.add(t.tick);
    });
  }

  //時間管理
  void _calc(int count) {
    //秒数を受け取り6秒カウントするまで計算し続ける
    if (count < _repeat + 1) {
      //ランダムな数字を決定
      final num = Random().nextInt(99) + 1;
      //表示された数字を登録して表示
      _outputController.sink.add('$num');
      //加算処理
      _sum += num;
    } else {
      //タイマー止めて
      _timer.cancel();
      //結果表示して
      _outputController.sink.add('答えは$_sum');
      //ボタンを表示する
      _btnController.sink.add(true);
    }
  }

  //使われてないからわからない（いったん閉じる処理かな？
  void dispose() {
    _startController.close();
    _calcController.close();
    _outputController.close();
    _btnController.close();
  }
}