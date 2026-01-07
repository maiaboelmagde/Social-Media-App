import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/app/authenticated_app.dart';
import 'package:social_media_app/core/di/service_locator.dart';
import 'package:social_media_app/features/auth/presentation/screens/sign_in_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: sl<FirebaseAuth>().authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return AuthenticatedApp();
        }
        return SignInScreen();
      },
    );
  }
}
