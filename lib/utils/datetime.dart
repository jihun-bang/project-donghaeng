import 'package:cloud_firestore/cloud_firestore.dart';

DateTime FromTimestamp(Timestamp timestamp) {
  return timestamp.toDate();
}

Timestamp toTimestamp(DateTime date) {
  return Timestamp.fromDate(date);
}
