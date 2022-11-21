import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class TimestampConverter implements JsonConverter<String, Object> {
  const TimestampConverter();

  @override
  String fromJson(Object json) => DateFormat('yyyy-MM-dd hh:mm')
      .format(DateTime.parse((json as Timestamp).toDate().toString()));

  @override
  Object toJson(object) {
    return Object();
  }
}
