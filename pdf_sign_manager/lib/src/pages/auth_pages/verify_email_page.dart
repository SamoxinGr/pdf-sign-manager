import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/snack_bar.dart';
import '../root_page/root_page.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
        const Duration(seconds: 3),
            (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();

    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    print(isEmailVerified);

    if (isEmailVerified) timer?.cancel();
  }

  Future<void> sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail = false);
      await Future.delayed(const Duration(seconds: 5));

      setState(() => canResendEmail = true);
    } catch (e) {
      print(e);
      if (mounted) {
        SnackBarService.showSnackBar(
          context,
          '$e',
          //'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? RootPage(pageIndex: 0)
      : Scaffold(
    backgroundColor: Color.fromRGBO(146, 170, 131, 1),
    resizeToAvoidBottomInset: false,
    appBar: AppBar(
      backgroundColor: Color.fromRGBO(72, 57, 42, 1),
      title: const Text('Верификация Email адреса', style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Письмо с подтверждением было отправлено на вашу электронную почту.',
              style: TextStyle(
                fontSize: 20,
                color: Color.fromRGBO(254, 233, 225, 1),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: canResendEmail ? sendVerificationEmail : null,
              icon: const Icon(Icons.email),
              label: const Text('Повторно отправить', style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                timer?.cancel();
                await FirebaseAuth.instance.currentUser!.delete();
              },
              child: const Text(
                'Отменить',
                style: TextStyle(
                    color: Color.fromRGBO(254, 233, 225, 1)
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}