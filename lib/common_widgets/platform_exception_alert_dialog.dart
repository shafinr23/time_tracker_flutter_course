import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import 'package:time_tracker_flutter_course/common_widgets/platform_alart_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlartDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: exception.message,
          defaultActionText: 'OK',
        );
}
