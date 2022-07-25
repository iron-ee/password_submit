import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PasswordDataController extends GetxController {
  /// 입력되는 패스워드 데이터
  RxList<String> passwordInputData = <String>[].obs;

  /// 등록될 패스워드 값
  List<String> passwordResult = [];

  /// 패스워드가 맞는지 체크하는 플래그
  Rx<bool> isPasswordCheck = true.obs;

  /// 패스워드 등록이 성공됐는지 체크하는 플래그
  Rx<bool> isComplete = false.obs;

  /// 현재 페이지 context
  late BuildContext context;

  /// 비밀번호 등록 페이지 => 패스워드 6자리 입력 체크 리스너
  late StreamSubscription<List<String>> passwordInputDataListenerAdd;

  /// 비밀번호 확인 페이지 => 패스워드 6자리 입력 체크 및 검증 리스너
  late StreamSubscription<List<String>> passwordInputDataListenerConfirm;

  /// 현재 페이지 context 입력하는 메서드
  void setContext(BuildContext context) {
    this.context = context;
  }

  /// 비밀번호 등록 페이지 => 패스워드 6자리 입력 완료시 실행되는 메서드
  void addComplete() {
    passwordResult = passwordInputData.value;
    Navigator.of(context).pushReplacementNamed(
      '/confirm',
      arguments: [passwordResult],
    );
    clearData();
  }

  /// 비밀번호 확인 페이지 => 패스워드 6자리 입력 완료시 실행되는 메서드
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

  /// 비밀번호 등록 페이지 => 패스워드 6자리 입력 체크 리스너
  void passwordAddListener() {
    passwordInputDataListenerAdd = passwordInputData.listen((data) {
      if (data.length == 6) {
        addComplete();
      }
    });
  }

  /// 비밀번호 확인 페이지 => 패스워드 6자리 입력 체크 및 검증 리스너
  void passwordConfirmListener() {
    passwordInputDataListenerConfirm = passwordInputData.listen((data) {
      if (data.length == 6) {
        confirmComplete();
      }
    });
  }

  /// 비밀번호 등록 페이지 리스너 메모리 해제
  void passwordAddCancel() {
    passwordInputDataListenerAdd.cancel();
  }

  /// 비밀번호 확인 페이지 리스너 메모리 해제
  void passwordConfirmCancel() {
    passwordInputDataListenerConfirm.cancel();
  }

  /// 데이터 청소
  void clearData() {
    passwordInputData.value = [];
    isPasswordCheck.value = true;
  }

  /// 데이터 초기화 및 리셋
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
