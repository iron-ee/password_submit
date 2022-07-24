import 'package:flutter/material.dart';
import 'package:password_submit/screen/password_add_screen.dart';
import 'package:password_submit/screen/password_confirm_screen.dart';
import 'package:password_submit/screen/password_result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
      initialRoute: '/add',
      routes: {
        '/add': (context) => const PasswordAddScreen(),
      },
      onGenerateRoute: (value) {
        if (value.name == '/confirm') {
          final dynamic args = value.arguments;
          print('$args');
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
