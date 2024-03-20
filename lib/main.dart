import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sheeshable/functions/authentication_controller.dart';
import 'package:sheeshable/functions/session_controller.dart';
import 'package:sheeshable/pages/homepage.dart';
import 'package:sheeshable/pages/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('ar', 'AR'),
        Locale('it', 'IT'),
        Locale('fr', 'FR'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      title: 'Sheeshable',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _checkSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:  [
                  const Image(
                    image: AssetImage("assets/logo.png"),
                    width: 300,
                  ),
                 const SizedBox(
                    height: 20,
                  ),
                  SpinKitPumpingHeart(
                    color: Colors.pink[300],
                    duration: const Duration(seconds: 5),
                  ),
                ],
              ),
            ),
          );
        } else {
          final bool hasSession = snapshot.data ?? false;
          print(hasSession);
          return hasSession ? const HomePage() : const Authentication();
        }
      },
    );
  }

  Future<bool> _checkSession() async {
    await Future.delayed(const Duration(seconds: 5));
    final sessionChecker = SessionChecker();
    return sessionChecker.checkSession();
  }
}
