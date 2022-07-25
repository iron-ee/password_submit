import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_submit/data/password_data_controller.dart';

class KeyPadWidget extends StatefulWidget {
  final List<String> passwordInputData;
  final String keyValue;

  const KeyPadWidget({
    Key? key,
    required this.keyValue,
    required this.passwordInputData,
  }) : super(key: key);

  @override
  _KeyPadWidgetState createState() => _KeyPadWidgetState();
}

class _KeyPadWidgetState extends State<KeyPadWidget> {
  PasswordDataController passwordDataController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1,
          mainAxisSpacing: 20,
          crossAxisSpacing: 70,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index != 9) {
            if (index != 11) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    if (widget.passwordInputData.length <= 6) {
                      widget.passwordInputData.add(widget.keyValue[index]);
                    }
                  });
                },
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      widget.keyValue[index],
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              );
            } else {
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
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
