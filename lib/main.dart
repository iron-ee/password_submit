import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:password_submit/data/password_data_controller.dart';
import 'package:password_submit/screen/password_add_screen.dart';
import 'package:password_submit/screen/password_confirm_screen.dart';
import 'package:password_submit/screen/password_result_screen.dart';

void main() {
  runApp(const PasswordApp());
}

class PasswordApp extends StatefulWidget {
  const PasswordApp({Key? key}) : super(key: key);

  @override
  State<PasswordApp> createState() => _PasswordAppState();
}

class _PasswordAppState extends State<PasswordApp> with WidgetsBindingObserver {
  PasswordDataController passwordDataController =
      Get.put(PasswordDataController());

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        if (!passwordDataController.isComplete.value) {
          passwordDataController.resumedResetData();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Password Submit',
      theme: ThemeData(
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const PasswordAddScreen(),
      routes: {
        '/add': (context) => const PasswordAddScreen(),
      },
      onGenerateRoute: (value) {
        if (value.name == '/confirm') {
          final dynamic args = value.arguments;
          return MaterialPageRoute(builder: (context) {
            return PasswordConfirmScreen(
              passwordAddData: args[0],
            );
          });
        } else if (value.name == '/result') {
          final dynamic args = value.arguments;
          return MaterialPageRoute(builder: (context) {
            return PasswordResultScreen(
              passwordResultData: args[0],
            );
          });
        }
        return null;
      },
    );
  }
}
