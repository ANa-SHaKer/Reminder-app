import 'dart:async';

import 'package:clock/clock.dart';
import 'package:flutter/material.dart';
import 'package:reminder/constants/theme_data.dart';




class StopWatch extends StatefulWidget {
  @override
  _StopWatchState createState() => _StopWatchState();
}

class _StopWatchState extends State<StopWatch> {
  String timerButtonText = 'Start';
  bool timerIsrunning = false;
  var stopWatch = clock.stopwatch();

  void startTimer(){
    // If user clicks start button and timer is already running, stop the timer
    if (timerIsrunning == true){
      stopWatch.stop();
      timerIsrunning = false;
      timerButtonText = 'Resume';
    }
    else {
      stopWatch.start();
      timerIsrunning = true;
      timerButtonText = 'Pause';
    }

    Timer.periodic(Duration(seconds: 1), (timer){
      setState(() {}
      );
    }
    );
  }

  void resetTimer(){
    setState(() {
      stopWatch.stop();
      timerIsrunning = false;
      timerButtonText = 'Start Timer';
      stopWatch.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Stop Watch',
            style: TextStyle(
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700,
                color: CustomColors.primaryTextColor,
                fontSize: 30),
            textAlign: TextAlign.left,
          ),
          SizedBox(height: 200,),
          Container(
            child: Text(clockDuration(stopWatch.elapsed), style: TextStyle(fontSize: 60,color: Colors.white)),
            margin: EdgeInsets.only(bottom:30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,width: 3)
                ),
                child: MaterialButton(
                    child: Text(timerButtonText, style: TextStyle(color: Colors.white),),
                    onPressed: (){
                      startTimer();
                    }

                ),
                margin: EdgeInsets.only(left: 40, top: 20),
                height: 50,
                width: 100,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,width: 3)
                ),
                child: MaterialButton(
                    child: Text('Reset', style: TextStyle(color: Colors.white),),

                    onPressed: (){
                      resetTimer();
                    }

                ),
                margin: EdgeInsets.only(right: 40, top: 20),
                height: 50,
                width: 100,
              ),
            ],
          ),
          SizedBox(height: 200,),

        ],
      );
  }
}

String clockDuration(Duration duration) {
  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
  return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
}