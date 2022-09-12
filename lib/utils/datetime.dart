import 'package:cloud_firestore/cloud_firestore.dart';

DateTime fromTimestamp(Timestamp timestamp) {
  return timestamp.toDate();
}

Timestamp toTimestamp(DateTime date) {
  return Timestamp.fromDate(date);
}
