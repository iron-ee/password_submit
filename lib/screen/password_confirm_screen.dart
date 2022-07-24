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

  List<int> numContainer = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  String passwordNum = '0123456789';
  String keyValue = '';
  String keyValueResult = '';

  String title = '한번 더 입력해주세요.';

  @override
  void initState() {
    // passwordDataController.passwordInputData.clear();
    initKeyPadNum();

    print('widget passwordAddData : ${widget.passwordAddData}');
    // print('passwordResult : ${passwordDataController.passwordResult}');
    super.initState();
  }

  void initKeyPadNum() {
    for (int i = 0; keyValue.length < 10; i++) {
      int rand = math.Random().nextInt(10);
      // print('rand : $rand');

      if (keyValue.contains(rand.toString())) continue;
      keyValue += passwordNum.substring(rand, rand + 1);
      // print(keyValue);
    }

    keyValueResult = '${keyValue.substring(0, 9)}@${keyValue.substring(9)}';
    print('keyValueResult : $keyValueResult');

    // int counter = -1;
    // while (counter < 9) {
    //   counter++;
    //   // String password = keyValue[counter];
    //   // print('password : ${keyValue[counter]}');
    // }
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
              padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Text('${keyValue}'),
                  Center(
                    child: Text(
                        passwordDataController.passwordInputData.toString()),
                  ),
                  PasswordLengthWidget(
                    passwordInputData: passwordDataController.passwordInputData,
                    inputLength: 6,
                  ),
                  KeyPadWidget(
                    passwordInputData: passwordDataController.passwordInputData,
                    passwordResult: passwordDataController.passwordResult,
                    keyValueResult: keyValueResult,
                    // complete: () {
                    //   passwordDataController.passwordInputData.clear();
                    // },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
