import 'package:flutter/material.dart';

class PasswordLengthWidget extends StatefulWidget {
  final List<String> passwordInputData;
  final int inputLength;
  const PasswordLengthWidget({
    Key? key,
    required this.passwordInputData,
    required this.inputLength,
  }) : super(key: key);

  @override
  _PasswordLengthWidgetState createState() => _PasswordLengthWidgetState();
}

class _PasswordLengthWidgetState extends State<PasswordLengthWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(
            left: (MediaQuery.of(context).size.width - 216 - 40) / 2),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Row(
              children: [
                for (int i = 0; i < widget.inputLength; i++)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
              ],
            ),
            Row(
              children: widget.passwordInputData
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
