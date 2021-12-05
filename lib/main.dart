import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/UI/timer.dart';

void main() {
  runApp(MainMenu());
}

class MainMenu extends StatefulWidget {
  MainMenu();

  @override
  _MainMenu createState() => _MainMenu();
}

class _MainMenu extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Home()
    );
  }
}


class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home>{
  List<String> workTime = ['5', '10', '15', '20', '25', '30', '35', '40', '45', '50', '55', '60'];
  String dropdownWorkValue = '25';
  List<String> brakeTime = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  String dropdownBrakeValue = '5';
  @override
  Widget build(BuildContext context){
    return Container(
      height:double.infinity,
      width: double.infinity,
      child: Scaffold(
        appBar: AppBar(
          title: Text('ポモドーロタイマー'),
        ),
        body: Center(
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('作業時間　'),
                      // じかん設定ボタンを配置
                      DropdownButton<String>(
                        value: dropdownWorkValue,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownWorkValue = newValue!;
                          });
                        },
                        items: workTime.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Text('分'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('休憩時間　'),
                      DropdownButton<String>(
                        value: dropdownBrakeValue,
                        iconSize: 24,
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownBrakeValue = newValue!;
                          });
                        },
                        items: brakeTime.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      Text('分'),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child : RaisedButton(
                    child: Text('スタート'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Timer(
                                int.parse(dropdownWorkValue),
                                int.parse(dropdownWorkValue),
                                int.parse(dropdownBrakeValue),
                                0
                            )
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}