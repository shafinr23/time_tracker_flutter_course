import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

abstract class Database {
  Future<void> createJob(Map<String, dynamic> jobData);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  Future<void> createJob(Map<String, dynamic> jobData) async {
    final path = '/users/$uid/jobs/jobs_abc';
    final docRef = Firestore.instance.document(path);
    await docRef.setData(jobData);
  }
}
