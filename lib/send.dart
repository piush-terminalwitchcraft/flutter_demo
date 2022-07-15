import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:day_night_time_picker/lib/constants.dart';
import 'package:day_night_time_picker/lib/daynight_timepicker.dart';
import 'package:demo_app/receive.dart';
import 'package:demo_app/request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Send extends StatefulWidget {
  const Send({Key? key}) : super(key: key);

  @override
  State<Send> createState() => _SendState();
}

class _SendState extends State<Send> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  String _email = "";
  String _phone_no = "";

  void onStartTimeChanged(TimeOfDay newTime) {
    setState(() {
      _startTime = newTime;
    });
  }

  void onEndTimeChanged(TimeOfDay newTime) {
    setState(() {
      _endTime = newTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 256,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email',
                hintText: 'Enter your email',
              ),
              onChanged: ((value) => _email = value),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: 256,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter email of receiver',
                hintText: 'Email',
              ),
              onChanged: ((value) => _phone_no = value),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: 256,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: _startTime,
                    onChange: onStartTimeChanged,
                    minuteInterval: MinuteInterval.FIVE,
                  ),
                );
              },
              child: Container(
                height: 32,
                alignment: Alignment.center,
                child: Text(
                  "Select Start time",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: 256,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  showPicker(
                    context: context,
                    value: _endTime,
                    onChange: onEndTimeChanged,
                    minuteInterval: MinuteInterval.FIVE,
                  ),
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 32,
                child: Text(
                  "Select End time  ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Container(
            width: 256,
            child: ElevatedButton(
              onPressed: () {
                sendDataToFirestore();
              },
              child: Container(
                alignment: Alignment.center,
                height: 32,
                child: Text(
                  "Send ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void sendDataToFirestore() {
    print(_email);
    print(_phone_no);
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users
        .add({
          'senderEmail': _email,
          'ReceiverEmail': _phone_no,
          'startTime_Hours': _startTime.hour.toString(),
          'startTime_Minutes': _startTime.minute.toString(),
          'endTime_Hours': _endTime.hour.toString(),
          'endTime_minutes': _endTime.minute.toString(),
          'status': 'pending',
        })
        .catchError((e) => print(e))
        .then((value) => {print("Success!")});
  }
}
