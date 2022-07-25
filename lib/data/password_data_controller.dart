import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PasswordDataController extends GetxController {
  RxList<String> passwordInputData = <String>[].obs;
  List<String> passwordResult = [];
  Rx<bool> isPasswordCheck = true.obs;
  Rx<bool> isComplete = false.obs;

  late BuildContext context;

  late StreamSubscription<List<String>> passwordInputDataListenerAdd;
  late StreamSubscription<List<String>> passwordInputDataListenerConfirm;

  void setContext(BuildContext context) {
    this.context = context;
  }

  void addComplete() {
    passwordResult = passwordInputData.value;
    Navigator.of(context).pushReplacementNamed(
      '/confirm',
      arguments: [passwordResult],
    );
    clearData();
  }

  void confirmComplete() {
    if (passwordResult.toString() == passwordInputData.toString()) {
      isPasswordCheck.value = true;
      Navigator.of(context).pushReplacementNamed(
        '/result',
        arguments: [passwordResult],
      );
      isComplete.value = true;
      clearData();
      passwordResult = [];
    } else {
      isPasswordCheck.value = false;
    }
    passwordInputData.clear();
  }

  void passwordAddListener() {
    passwordInputDataListenerAdd = passwordInputData.listen((data) {
      if (data.length == 6) {
        addComplete();
      }
    });
  }

  void passwordConfirmListener() {
    passwordInputDataListenerConfirm = passwordInputData.listen((data) {
      if (data.length == 6) {
        confirmComplete();
      }
    });
  }

  void passwordAddCancel() {
    passwordInputDataListenerAdd.cancel();
  }

  void passwordConfirmCancel() {
    passwordInputDataListenerConfirm.cancel();
  }

  void clearData() {
    passwordInputData.value = [];
    isPasswordCheck.value = true;
  }

  void resumedResetData() {
    passwordInputData.value = [];
    isPasswordCheck.value = true;
    isComplete.value = false;
    if (passwordResult.isNotEmpty) {
      passwordResult = [];
      Navigator.of(context).pushReplacementNamed('/add');
    }
  }
}
