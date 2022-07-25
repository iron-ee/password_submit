import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_submit/data/password_data_controller.dart';
import 'package:password_submit/widget/keypad_widget.dart';
import 'package:password_submit/widget/password_length_widget.dart';

class PasswordConfirmScreen extends StatefulWidget {
  final List<String> passwordAddData;
  const PasswordConfirmScreen({
    Key? key,
    required this.passwordAddData,
  }) : super(key: key);

  @override
  _PasswordConfirmScreenState createState() => _PasswordConfirmScreenState();
}

class _PasswordConfirmScreenState extends State<PasswordConfirmScreen> {
  PasswordDataController passwordDataController = Get.find();

  String title = '한번 더 입력해주세요.';
  String failTitle = '불일치 합니다. 다시 입력해주세요.';

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
    passwordDataController.passwordConfirmCancel();
    super.dispose();
  }

  void listener() {
    passwordDataController.setContext(context);
    passwordDataController.passwordConfirmListener();
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
                  backSpaceWidget(context),
                  const SizedBox(
                    height: 20,
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

  Widget backSpaceWidget(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: GestureDetector(
        onTap: () {
          passwordDataController.passwordInputData.clear();
          passwordDataController.passwordResult.clear();
          Navigator.of(context).pushReplacementNamed('/add');
        },
        child: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        passwordDataController.isPasswordCheck.value ? title : failTitle,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: passwordDataController.isPasswordCheck.value
              ? Colors.black
              : Colors.red,
        ),
      ),
    );
  }
}
