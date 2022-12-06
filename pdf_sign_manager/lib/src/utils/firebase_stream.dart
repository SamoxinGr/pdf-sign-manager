import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf_sign_manager/src/pages/auth_pages/login_page.dart';
import 'package:pdf_sign_manager/src/pages/root_page/root_page.dart';

import '../pages/auth_pages/home_page.dart';
import '../pages/auth_pages/verify_email_page.dart';

class FirebaseStream extends StatelessWidget {
  const FirebaseStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(
              body: Center(child: Text('Что-то пошло не так!')));
        } else if (snapshot.hasData) {
          if (!snapshot.data!.emailVerified) {
            return const VerifyEmailScreen();
          }
          return LoginScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}