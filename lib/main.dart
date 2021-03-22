import 'package:flutter/material.dart';
import 'package:memby/screens/landingScreen.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:memby/firebase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      child: MaterialApp(
        home: Landing(),
      ),
    );
  }
}
