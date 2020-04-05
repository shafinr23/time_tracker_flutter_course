import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SingInBloc {
  SingInBloc({@required this.auth, @required this.isloading});

  final AuthBase auth;
  final ValueNotifier<bool> isloading;

  Future<User> _singIn(Future<User> Function() singInMathod) async {
    try {
      isloading.value = true;
      return await singInMathod();
    } catch (e) {
      isloading.value = false;
      rethrow;
    }
  }

  Future<User> singInAnonymosly() async => await _singIn(auth.singInAnonymosly);

  Future<User> singInWithGoogle() async => await _singIn(auth.singInWithGoogle);
}
