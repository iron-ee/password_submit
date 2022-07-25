import 'dart:math' as math;

import 'package:flutter/material.dart';

class KeyPadWidget extends StatefulWidget {
  final List<String> passwordInputData;

  const KeyPadWidget({
    Key? key,
    required this.passwordInputData,
  }) : super(key: key);

  @override
  _KeyPadWidgetState createState() => _KeyPadWidgetState();
}

class _KeyPadWidgetState extends State<KeyPadWidget> {
  String num = '0123456789';
  String randomValue = '';
  String keyPadValue = '';

  void initKeyPadNum() {
    /// 0 부터 9 까지의 랜덤 한 숫자를 만드는 반복문
    for (int i = 0; randomValue.length < 10; i++) {
      int rand = math.Random().nextInt(10);

      if (randomValue.contains(rand.toString())) continue;
      randomValue += num.substring(rand, rand + 1);
    }

    /// Grid 로 만든 키패드의 9번째 칸 공백을 위한 가공
    keyPadValue = '${randomValue.substring(0, 9)}@${randomValue.substring(9)}';
  }

  @override
  void initState() {
    /// 랜덤 키패드 초기화
    initKeyPadNum();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ((MediaQuery.of(context).size.width - 180) / 3) * 4,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 0,
          crossAxisSpacing: 70,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index != 9) {
            if (index != 11) {
              /// 공백 칸과 지우기 칸을 제외한 숫자 키패드
              return numKeyPadWidget(index);
            } else {
              /// 11번째 칸 지우기 키패드
              return deleteKeyPadWidget();
            }
          } else {
            /// 공백 키패드
            return const SizedBox();
          }
        },
      ),
    );
  }

  Widget numKeyPadWidget(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.passwordInputData.length <= 6) {
            widget.passwordInputData.add(keyPadValue[index]);
          }
        });
      },
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            keyPadValue[index],
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }

  Widget deleteKeyPadWidget() {
    return GestureDetector(
      onTap: () {
        if (widget.passwordInputData.isNotEmpty) {
          setState(() {
            widget.passwordInputData.removeLast();
          });
        }
      },
      child: const Icon(Icons.keyboard_backspace),
    );
  }
}
