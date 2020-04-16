import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter_course/app/home/models/job.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alart_dialog.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_exception_alert_dialog.dart';
import 'package:time_tracker_flutter_course/services/database.dart';

class AddJobPage extends StatefulWidget {
  const AddJobPage({Key key, @required this.database}) : super(key: key);
  final Database database;

  static Future<void> show(BuildContext context) async {
    final database = Provider.of<Database>(context, listen: false);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AddJobPage(
          database: database,
        ),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _AddJobPageState createState() => _AddJobPageState();
}

class _AddJobPageState extends State<AddJobPage> {
  String _name;
  int _ratePerHpur;
  final _formKey = GlobalKey<FormState>();
  bool _validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    //TODO:validate and save from
    if (_validateAndSave()) {
      try {
        final jobs = await widget.database.jobsStream().first;
        final allNames = jobs.map((job) => job.name).toList();
        if (allNames.contains(_name)) {
          PlatformAlartDialog(
            title: 'Name is used',
            content: 'choose a diffrent one ',
            defaultActionText: 'OK',
          ).show(context);
        } else {
          final job = Job(name: _name, ratePerHour: _ratePerHpur);
          await widget.database.createJob(job);
          Navigator.of(context).pop();
        }
      } on PlatformException catch (e) {
        //print(e.toString());
        PlatformExceptionAlertDialog(
          title: 'Opration failed ',
          exception: e,
        ).show(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2.0,
        title: Text('New Job'),
        actions: <Widget>[
          FlatButton(
            child: Text(
              'save',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: _submit,
          )
        ],
      ),
      body: _buildcontent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildcontent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildForm(),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildFormChildren(),
      ),
    );
  }

  List<Widget> _buildFormChildren() {
    return [
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Job Page',
        ),
        onSaved: (value) => _name = value,
        validator: (value) =>
            value.isNotEmpty ? null : 'name cant\'t be empty ',
      ),
      TextFormField(
        decoration: InputDecoration(
          labelText: 'Rate Per Hour',
        ),
        keyboardType: TextInputType.numberWithOptions(
          signed: false,
          decimal: false,
        ),
        onSaved: (value) => _ratePerHpur = int.tryParse(value) ?? 0,
      )
    ];
  }
}
