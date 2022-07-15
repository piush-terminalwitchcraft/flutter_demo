import 'package:flutter/material.dart';

class RequestModel {
  var senderEmail;
  var ReceiverEmail;
  var startTime_Hours;
  var startTime_Minutes;
  var endTime_Hours;
  var endTime_minutes;
  RequestModel(this.senderEmail, this.ReceiverEmail, this.startTime_Hours,
      this.startTime_Minutes, this.endTime_Hours, this.endTime_minutes);
}
