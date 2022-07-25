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

  @override
  void initState() {
    listener();
    super.initState();
  }

  @override
  void dispose() {
    /// 리스너 해제
    passwordDataController.passwordAddCancel();
    super.dispose();
  }

  void listener() {
    /// 현재 스크린 context 가져오기
    passwordDataController.setContext(context);

    /// 리스너 등록
    passwordDataController.passwordAddListener();
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

                  /// 패스워드 입력 길이 로우 위젯
                  PasswordLengthWidget(
                    passwordInputData: passwordDataController.passwordInputData,
                  ),

                  /// 랜덤 키패드 위젯
                  KeyPadWidget(
                    passwordInputData: passwordDataController.passwordInputData,
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
