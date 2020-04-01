import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:time_tracker_flutter_course/services/auth.dart';

class SingInBloc {
  SingInBloc({@required this.auth});

  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();

  Stream<bool> get isLoadingStream => _isLoadingController.stream;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  Future<User> _singIn(Future<User> Function() singInMathod) async {
    try {
      _setIsLoading(true);
      return await singInMathod();
    } catch (e) {
      rethrow;
    } finally {
      _setIsLoading(false);
    }
  }

  Future<User> singInAnonymosly() async => await _singIn(auth.singInAnonymosly);

  Future<User> singInWithGoogle() async => await _singIn(auth.singInWithGoogle);
}
