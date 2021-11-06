import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:pomodoro_timer/main.dart';
import 'package:pomodoro_timer/UI/timer.dart';

class Result extends StatelessWidget {
  Result(this.workTime, this.brakeTime, this.rapCounter) {
    record = this.workTime * this.rapCounter;
  }
  int workTime, brakeTime, rapCounter;
  int record = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('休憩を終了してください'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: Container(
              alignment: Alignment.center,
              child: Text(
                " $rapCounter サイクル終了しました。\nこのタイマーで合計$record分間作業しました\nもう1サイクル続けますか？",
                textAlign: TextAlign.center,
                style: TextStyle(
                  height: 3.0,
                ),
              ),
            )),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          // はい　：　もう1サイクル
                          child: Text('はい'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Timer(workTime, workTime, brakeTime, rapCounter)),
                            );
                          },
                        ),
                        RaisedButton(
                          // いいえ　：　Homeに戻る
                          child: Text('いいえ'),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainMenu()),
                            );
                          },
                        ),
                      ],
                    ),
                    RaisedButton(
                      child: Text('結果をシェアする'),
                      onPressed: () => _share(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _share() => Share.share('ポモドーロテクニックを使って、$record分頑張りました！\n##ここにappのURL##');
}
