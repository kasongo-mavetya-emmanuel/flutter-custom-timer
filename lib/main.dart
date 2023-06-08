import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CustomTimer(),
    );
  }
}

class CustomTimer extends StatefulWidget {
  const CustomTimer({Key? key}) : super(key: key);

  @override
  State<CustomTimer> createState() => _CustomTimerState();
}

class _CustomTimerState extends State<CustomTimer> {

  int index=1;
  int hrs=0;
  int mins=0;
  int secs=0;
  int totalSecs=0;
  Timer? timer;

  void startTimer({bool reset=true}){
      if(reset){
        resetTimer();
      }

      timer= Timer.periodic(Duration(seconds: 1), (timer) {
        if(totalSecs>0){
          setState(() {
            totalSecs--;
          });
        }
        else{
          stopTimer(reset: false);
        }
      });


  }

  void stopTimer({bool reset=true}){
    if(reset){
      resetTimer();
    }

    setState(() {
      timer!.cancel();
    });
  }

  void resetTimer(){
    setState(() {
      hrs=0;
      mins=0;
      secs=0;
      totalSecs=0;
    });
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    bool isRunning= timer==null?false:timer!.isActive;
    return Scaffold(
      appBar: AppBar(title: Text('CUSTOM TIMER'),),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: increaseTimer,
                        icon: Icon(Icons.keyboard_arrow_up)),
                    IconButton(
                        onPressed: decreaseTimer,
                        icon: Icon(Icons.keyboard_arrow_down)),
                  ],
                ),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: (){
                        setState(() {
                          index=2;
                        });
                      },
                        child: Text('${(totalSecs~/3600).toString().padLeft(2,'0')}:',
                          style: TextStyle(fontSize: 24,
                              color: index==2?Colors.red: Colors.black),)),
                    InkWell(
                      onTap: (){
                        setState(() {
                          index=1;
                        });
                      },
                        child: Text('${((totalSecs/60)%60).toInt().toString().padLeft(2,'0')}:',
                            style: TextStyle(fontSize: 24,
                                color: index==1?Colors.red: Colors.black))),
                    InkWell(
                      onTap: (){
                        setState(() {
                          index=0;
                        });
                      },
                        child: Text('${(totalSecs%60).toInt().toString().padLeft(2,'0')}',
                            style: TextStyle(fontSize: 24,
                                color: index==0?Colors.red: Colors.black))),
                  ],
                ),
              ],
            ),

            !isRunning?
            ElevatedButton(onPressed: (){
              startTimer(reset: false);
            }, child: Text('Start'))
            :
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        stopTimer(reset: false);
                      },
                child: Text('Pause'),)),
                SizedBox(width: 10,),
                Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        stopTimer(reset: true);
                      },
                  child: Text('Stop'),)),
              ],
            ),

          ],
        ),
      ),
    );
  }

  void increaseTimer(){

    if(index==0){
      setState(() {
        secs++;
      });
    }
    if(index==1){
      setState(() {
        mins++;
      });
    }
    if(index==2){
      setState(() {
        hrs++;
      });
    }

    setState(() {
      totalSecs=(hrs*3600 + mins * 60 + secs).abs();
    });

  }

  void decreaseTimer(){
    if(index==0){
      setState(() {
        secs--;
      });
    }
    if(index==1){
      setState(() {
        mins--;
      });
    }
    if(index==2){
      setState(() {
        hrs--;
      });
    }

    setState(() {
      totalSecs=(hrs*3600 + mins * 60 + secs).abs();
    });
  }


}


