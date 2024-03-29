import 'package:fln/widgets/HomeScaffold.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "CexCheck",
      theme: ThemeData(
          primaryColor: Color.fromARGB(255, 223, 33, 39),
          textTheme: TextTheme(
            bodyText1: TextStyle(color: Colors.black87),
            bodyText2:
                TextStyle(color: Colors.black54, fontWeight: FontWeight.w700),
          ),
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: Color.fromARGB(255, 206, 172, 122))),
      // This is the theme of your application.
      //
      // Try running your application with "flutter run". You'll see the
      // application has a blue toolbar. Then, without quitting the app, try
      // changing the primarySwatch below to Colors.green and then invoke
      // "hot reload" (press "r" in the console where you ran "flutter run",
      // or simply save your changes to "hot reload" in a Flutter IDE).
      // Notice that the counter didn't reset back to zero; the application
      // is
      //not restarted.
      // This makes the visual density adapt to the platform that you run
      // the app on. For desktop platforms, the controls will be smaller and
      // closer together (more dense) than on mobile platforms.
      home: HomeScaffold(title: 'cexcheck'),
    );
  }
}
