import 'package:meta/meta.dart';

class Job {
  Job({@required this.id, @required this.name, @required this.ratePerHour});
  final String id;
  final String name;
  final int ratePerHour;

  factory Job.frommap(Map<String, dynamic> data, String documentId) {
    if (data == null) {
      return null;
    }
    final String name = data['name'];
    final int ratePerHour = data['ratePerHour'];
    return Job(name: name, ratePerHour: ratePerHour, id: documentId);
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
