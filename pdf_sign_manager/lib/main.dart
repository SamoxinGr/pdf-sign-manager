import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:pdf_sign_manager/src/pages/auth_pages/home_page.dart';
import 'firebase_options.dart';
import 'src/pages/auth_pages/login_page.dart';
import 'src/pages/auth_pages/reset_password_page.dart';
import 'src/pages/auth_pages/sign_up_page.dart';
import 'src/pages/auth_pages/verify_email_page.dart';
import 'src/pages/root_page/root_page.dart';
import 'src/utils/firebase_stream.dart';


/*final emailLinkProviderConfig = EmailLinkAuthProvider(
  actionCodeSettings: actionCodeSettings,
);*/

/*final actionCodeSettings = ActionCodeSettings(
  url: 'https://flutterfire-e2e-tests.firebaseapp.com',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);*/

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //var providers = [EmailAuthProvider()];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'pdf sign manager',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      //home: HomeScreen(),
      initialRoute: '/',
      routes: {
        '/': (context) => const FirebaseStream(),
        '/home': (context) => const HomeScreen(),
        '/account': (context) => RootPage(pageIndex: 0),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/reset_password': (context) => const ResetPasswordScreen(),
        '/verify_email': (context) => const VerifyEmailScreen(),
      },
    );
  }
}