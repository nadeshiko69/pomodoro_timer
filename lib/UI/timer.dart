import 'package:flutter/material.dart';
import 'package:quiver/async.dart';
import 'package:pomodoro_timer/widget/percentage.dart';
import 'package:pomodoro_timer/UI/result.dart';

class Timer extends StatefulWidget {
  Timer(this.workTime, this.currentTime ,this.brakeTime, this.rapCounter);
  int workTime, currentTime, brakeTime, rapCounter;

    _Timer createState() => _Timer(workTime, currentTime, brakeTime, rapCounter);
}

class _Timer extends State<Timer>{
  // ### parameter ###
  // 内部処理用
  int initWorkTime, initBrakeTime;
  bool isWorking = true; // true : 仕事中、false : 休憩中
  int startTime = 0;  //測る時間 [sec]
  int currentTime;    // 今の時間 [sec]
  int rapCounter; // 何周したか[回]
  // UI表示用
  int minute = 0;
  int second = 0;
  double percentage = 0;
  String appBarText = "作業中...";

  _Timer(this.initWorkTime, this.currentTime, this.initBrakeTime, this.rapCounter){
    startTimer(isWorking);
  }

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
        minute = currentTime ~/ 60;
        second = currentTime % 60;
        percentage = 1 - (currentTime / startTime);

      });
    });

    //終了時
    sub.onDone(() {
      sub.cancel();
      // Work  -> Brake
      // Brake -> 画面遷移
      if(stateCheck == true) {
        stateCheck = !stateCheck;
        appBarText = "休憩中...";
        setState(() {
          startTimer(stateCheck);
        });
      }
      else{
        rapCounter++;
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Result(initWorkTime, initBrakeTime, rapCounter)
          ),
        );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false, // 戻るボタン非表示
        title: Text(appBarText),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Percentage(percentage),
            // 残り時間を表示
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "$minute :",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                    ),

                  ),
                  Text(
                    second.toString().padLeft(2,"0"), // 秒数が1桁の時0で桁揃えする
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}