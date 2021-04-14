import 'package:flutter/material.dart';

import 'package:memby/screens/landingScreen.dart';
import 'package:overlay_support/overlay_support.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MembyApp());
}

class MembyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<FlutterFireAuthService>(
            create: (_) => FlutterFireAuthService(FirebaseAuth.instance),
          ),
          StreamProvider(
            create: (context) =>
                context.read<FlutterFireAuthService>().authStateChanges,
            initialData: null,
          )
        ],
        child: OverlaySupport(
          child: MaterialApp(
            theme: ThemeData(
              fontFamily: 'Alef-Regular',
              textTheme: TextTheme(
                headline1:
                    TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
                bodyText2: TextStyle(fontSize: 14.0),
              ),
            ),
            home: Landing(),
          ),
        ));
  }
}
