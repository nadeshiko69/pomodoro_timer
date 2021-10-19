import 'package:flutter/material.dart';
import 'package:quiver/async.dart';

class Timer extends StatefulWidget {
  Timer(this.workTime, this.brakeTime);
  int workTime, brakeTime;

    _Timer createState() => _Timer(workTime, brakeTime);
}

class _Timer extends State<Timer>{
  _Timer(this.initWorkTime, this.initBrakeTime);
  int initWorkTime, initBrakeTime;
  bool isWorking = true; // true : 仕事中、false : 休憩中
  int startTime = 0;   //測る時間 [sec]
  int currentTime = 0; //今の時間 [sec]

  //カウントダウン処理
  void startTimer(bool stateCheck) {
    if (stateCheck)
      startTime = initWorkTime * 60;
    else
      startTime = initBrakeTime * 60;

    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: startTime), //初期値
      new Duration(seconds: 1), // 1秒幅
    );

    var sub = countDownTimer.listen(null);

    //カウントダウン
    sub.onData((duration) {
      setState(() {
        currentTime = startTime - duration.elapsed.inSeconds; //毎秒減らしていく
      });
    });

    //終了時
    sub.onDone(() {
      print("Done");
      sub.cancel();
      //currentTime = startTime;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("次のページ"),
      ),
      body: Container(
    // UI作り込む！
      ),
    );
  }
}