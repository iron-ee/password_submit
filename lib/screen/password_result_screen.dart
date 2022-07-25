import 'package:flutter/material.dart';

class PasswordResultScreen extends StatelessWidget {
  final List<String> passwordResultData;
  const PasswordResultScreen({
    Key? key,
    required this.passwordResultData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '등록하신 비밀번호',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              passwordResultData.join(''),
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
