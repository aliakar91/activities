import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Clock extends StatelessWidget {
  const Clock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          return Center(
            child: Column(
              children: [
                Container(width: 100,height: 100,
                  child: AnalogClock(
                    decoration: BoxDecoration(
                        border: Border.all(width: 2.0, color: Colors.black),
                        color: Colors.yellow,
                        shape: BoxShape.circle),
                    width: 20.0,
                    isLive: true,
                    hourHandColor: Colors.black,
                    minuteHandColor: Colors.black,
                    showSecondHand: false,
                    numberColor: Colors.black87,
                    showNumbers: true,
                    textScaleFactor: 1.4,
                    showTicks: false,
                    showDigitalClock: false,
                    datetime: DateTime(2019, 1, 1, 9, 12, 15),
                  ),
                ),
                Text(
                  DateFormat('MM/dd/yyyy hh:mm:ss').format(DateTime.now()),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
