import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/responsive/mob_screen_layout.dart';
import 'package:myapp/responsive/responsive_layout_screen.dart';
import 'package:myapp/screens/login_screen.dart';
import 'package:myapp/responsive/web_screen_layout.dart';
import 'package:myapp/utilities/colors.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram',
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
      // home: ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: LoginPage(),
    );
  }
}
