import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';

abstract class Database {
  Future<void> createJob(Job job);
}

class FirestoreDatabase implements Database {
  FirestoreDatabase({@required this.uid}) : assert(uid != null);
  final String uid;
  Future<void> createJob(Job job) async {
    final path = '/users/$uid/jobs/jobs_abc';
    final docRef = Firestore.instance.document(path);
    await docRef.setData(job.toMap());
  }
}
