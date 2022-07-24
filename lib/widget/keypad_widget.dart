import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_submit/data/password_data_controller.dart';

class KeyPadWidget extends StatefulWidget {
  final List<String> passwordInputData;
  late List<String> passwordResult;
  final String keyValueResult;
  final String routeName;
  final dynamic arguments;

  KeyPadWidget({
    Key? key,
    required this.keyValueResult,
    required this.passwordInputData,
    required this.passwordResult,
    this.routeName = '',
    this.arguments,
  }) : super(key: key);

  @override
  _KeyPadWidgetState createState() => _KeyPadWidgetState();
}

class _KeyPadWidgetState extends State<KeyPadWidget> {
  PasswordDataController passwordDataController = Get.find();

  List<String> password = [];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GridView.builder(
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
                      password.add(widget.keyValueResult[index]);
                      widget.passwordInputData
                          .add(widget.keyValueResult[index]);
                      print('real password : $widget.passwordInputData}');

                      if (widget.passwordInputData.length == 6) {
                        if (widget.routeName.isNotEmpty) {
                          Navigator.of(context).pushReplacementNamed(
                            widget.routeName,
                            arguments: [password],
                          );
                        }
                        widget.passwordInputData.clear();
                      }
                    }
                  });
                },
                child: Container(
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      widget.keyValueResult[index],
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
