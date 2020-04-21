import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> setData({
    @required String path,
    Map<String, dynamic> data,
  }) async {
    final refrence = Firestore.instance.document(path);
    print('$path : $data');
    await refrence.setData(data);
  }

  Future<void> deleteData({@required String path}) async {
    final referance = Firestore.instance.document(path);
    print('deleth : $path');
    await referance.delete();
  }

  Stream<List<T>> collectionStream<T>({
    @required String path,
    @required T builder(Map<String, dynamic> data, String documentId),
  }) {
    final reference = Firestore.instance.collection(path);
    final snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.documents
        .map(
          (snapshot) => builder(snapshot.data, snapshot.documentID),
        )
        .toList());
  }
}
