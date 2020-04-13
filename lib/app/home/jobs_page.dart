import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alart_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class JobsPage extends StatelessWidget {
  Future<void> _singOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.singOut();
      //onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _confirmSingout(BuildContext context) async {
    final didRequestSingout = await PlatformAlartDialog(
            title: 'Logout',
            content: 'are you sure you logout ',
            defaultActionText: 'Logout',
            cancelActionButton: 'cancle')
        .show(context);
    if (didRequestSingout == true) {
      _singOut(context);
    }
  }

  Future<void> _createJob(BuildContext context) async {
    try {
      final database = Provider.of<Database>(context, listen: false);

      await database.createJob(Job(name: 'blogging', ratePerHour: 45));
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'opration failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobs'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Log Out',
              style: TextStyle(fontSize: 17.0, color: Colors.white),
            ),
            onPressed: () => _confirmSingout(context),
          )
        ],
      ),
      body: Container(
        child: _buildContents(context),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _createJob(context),
      ),
    );
  }

  Widget _buildContents(BuildContext context) {
    final database = Provider.of<Database>(context);
    return StreamBuilder<List<Job>>(
      stream: database.jobsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final jobs = snapshot.data;
          final children = jobs.map((job) => Text(job.name)).toList();
          return ListView(children: children);
        }
        if(snapshot.hasError){
          return Center(
            child: Text('Some Error Occurred'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
