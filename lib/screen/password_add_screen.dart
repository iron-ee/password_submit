import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_submit/data/password_data_controller.dart';
import 'package:password_submit/widget/keypad_widget.dart';
import 'package:password_submit/widget/password_length_widget.dart';

class PasswordAddScreen extends StatefulWidget {
  const PasswordAddScreen({Key? key}) : super(key: key);

  @override
  State<PasswordAddScreen> createState() => _PasswordAddScreenState();
}

class _PasswordAddScreenState extends State<PasswordAddScreen> {
  PasswordDataController passwordDataController = Get.find();

  String title = '비밀번호를 입력해주세요.';

  String num = '0123456789';
  String randomValue = '';
  String keyPadValue = '';

  @override
  void initState() {
    initKeyPadNum();
    listener();
    super.initState();
  }

  @override
  void dispose() {
    passwordDataController.passwordAddCancel();
    super.dispose();
  }

  void listener() {
    passwordDataController.setContext(context);
    passwordDataController.passwordAddListener();
  }

  void initKeyPadNum() {
    for (int i = 0; randomValue.length < 10; i++) {
      int rand = math.Random().nextInt(10);

      if (randomValue.contains(rand.toString())) continue;
      randomValue += num.substring(rand, rand + 1);
    }

    keyPadValue = '${randomValue.substring(0, 9)}@${randomValue.substring(9)}';
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        color: Colors.white,
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  titleWidget(),
                  SizedBox(
                    height: 0,
                    child: Text(
                        passwordDataController.passwordInputData.toString()),
                  ),
                  PasswordLengthWidget(
                    passwordInputData: passwordDataController.passwordInputData,
                    inputLength: 6,
                  ),
                  KeyPadWidget(
                    passwordInputData: passwordDataController.passwordInputData,
                    keyValue: keyPadValue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
