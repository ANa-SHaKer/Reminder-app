import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:reminder/constants/theme_data.dart';


class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  static const duration = const Duration(seconds: 1);

  int secondsPassed = 0;
  bool isActive = false;

  Timer timer;

  void handleTick() {
    if (isActive) {
      setState(() {
        secondsPassed = secondsPassed + 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (timer == null) {
      timer = Timer.periodic(duration, (Timer t) {
        handleTick();
      });
    }
    int seconds = secondsPassed % 60;
    int minutes = secondsPassed ~/ 60;
    int hours = secondsPassed ~/ (60 * 60);

    return   Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Timer',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 40),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 200,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              LabelText(
                  label: 'HRS', value: hours.toString().padLeft(2, '0')),
              LabelText(
                  label: 'MIN',
                  value: minutes.toString().padLeft(2, '0')),
              LabelText(
                  label: 'SEC',
                  value: seconds.toString().padLeft(2, '0')),
            ],
          ),
          SizedBox(height: 60),
          Container(
            width: 200,
            height: 47,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                border: Border.all(width: 3)
            ),
            child: MaterialButton(

              child: Text(isActive ? 'STOP' : 'START',),
              onPressed: () {
                setState(() {
                  isActive = !isActive;
                });
              },
            ),
          ),
          SizedBox(height: 200,),

        ],
      ),
    );
  }
}

class LabelText extends StatelessWidget {
  LabelText({this.label, this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          '$value',
          style: TextStyle(
              color: Colors.white, fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Text(
          '$label',
          style: TextStyle(
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}

class TimerrPage extends StatefulWidget {
  @override
  _TimerrPageState createState() => _TimerrPageState();
}

class _TimerrPageState extends State<TimerrPage> {

  int hour=0;
  int min=0;
  int sec=0;
  int TimeForTimer;
  String timetodisplay="";

  void start(){
    TimeForTimer = (hour*60*60)+(min*60)+sec;
    Timer.periodic(Duration(seconds: 1),(Timer t){
      setState(() {
        if(TimeForTimer < 1){
          t.cancel();
          timetodisplay="";
          if (TimeForTimer==0){
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Timer App",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  content: new Text("No Time Remaning",style: TextStyle(fontSize: 20,),),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Ok",style: TextStyle(fontSize: 20,),),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        }
        else if (TimeForTimer<60){
          timetodisplay = TimeForTimer.toString();
          TimeForTimer=TimeForTimer-1;
        }
        else if (TimeForTimer < 3600){
          int m=TimeForTimer~/60;
          int s=TimeForTimer-(60*m);
          timetodisplay=m.toString()+":"+s.toString();
        }
        else {
          int h=TimeForTimer~/3600;
          int t=TimeForTimer-(3600*h);
          int m=t~/60;
          int s=t-(60*m);
          timetodisplay=h.toString()+":"+m.toString()+":"+s.toString();
          TimeForTimer=TimeForTimer-1;
        }
      });
    } );
  }
  void reset(){
    setState(() {
      TimeForTimer=0;
      timetodisplay="";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Row(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text("HH",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        onChanged: (val){
                          setState(() {
                            hour=val;
                          });
                        }
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text("MM",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 60,
                        onChanged: (val){
                          setState(() {
                            min=val;
                          });
                        }
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text("SS",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 60,
                        onChanged: (val){
                          setState(() {
                            sec=val;
                          });
                        }
                    ),
                  ],
                )
              ],
            ),
          ),
          new Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text("Time Remaining:",style: TextStyle(fontSize: 30,color: Colors.white,),),
                  new Text(timetodisplay,style:TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),),
                ],
              )
          ),
          new Expanded(
            flex: 1,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Container(
            decoration: BoxDecoration(
            border: Border.all(color: Colors.white,width: 3)
          ),
          child: MaterialButton(
                  child:
                  Text("START",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                  onPressed: start,
                ),),
    Container(
    decoration: BoxDecoration(
    border: Border.all(color: Colors.white,width: 3)
    ),
    child: MaterialButton(
                  child:
                  Text("RESET",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
                  onPressed: reset,
                ))
              ],
            ),
          )
        ],

    );
  }
}

