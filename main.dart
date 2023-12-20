import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:untitled11/form-test.dart';
import 'package:untitled11/login.dart';
import 'package:untitled11/registration.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(MyApp());
}
//void main() {
  //runApp(
    //DevicePreview(
      //builder: (context) => MyApp(), // Wrap your app
    //),
  //);
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.purple,
      ),
      home: LogIn(),
    );
  }
}
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
    );
  }
}

