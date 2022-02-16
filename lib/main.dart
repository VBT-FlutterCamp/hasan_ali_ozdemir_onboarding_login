import 'package:flutter/material.dart';
import 'package:onboarding_app/view/auth/auth_view.dart';
import 'package:onboarding_app/view/onboarding/onboarding_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/onBoarding': (BuildContext context) => OnBoardingPage(),
        '/auth': (BuildContext context) => AuthPage(),
      },
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: OnBoardingPage()
    );
  }
}

