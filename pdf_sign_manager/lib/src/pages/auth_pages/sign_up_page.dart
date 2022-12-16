import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../utils/database_service.dart';
import '../../utils/snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreen();
}

class _SignUpScreen extends State<SignUpScreen> {
  bool isHiddenPassword = true;
  TextEditingController emailTextInputController = TextEditingController();
  TextEditingController passwordTextInputController = TextEditingController();
  TextEditingController passwordTextRepeatInputController =
  TextEditingController();
  TextEditingController jobTextInputController = TextEditingController();
  TextEditingController fullNameInputController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTextInputController.dispose();
    passwordTextInputController.dispose();
    passwordTextRepeatInputController.dispose();
    jobTextInputController.dispose();
    fullNameInputController.dispose();

    super.dispose();
  }

  void togglePasswordView() {
    setState(() {
      isHiddenPassword = !isHiddenPassword;
    });
  }

  Future<void> signUp() async {
    final navigator = Navigator.of(context);

    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    if (passwordTextInputController.text !=
        passwordTextRepeatInputController.text) {
      SnackBarService.showSnackBar(
        context,
        'Пароли должны совпадать',
        true,
      );
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextInputController.text.trim(),
        password: passwordTextInputController.text.trim(),
      );
      DatabaseService service = DatabaseService(); //addUser to DB
      await service.addUser("team", emailTextInputController.text.trim(), jobTextInputController.text.trim(), fullNameInputController.text.trim());

    } on FirebaseAuthException catch (e) {
      print(e.code);

      if (e.code == 'email-already-in-use') {
        SnackBarService.showSnackBar(
          context,
          'Такой Email уже используется, повторите попытку с использованием другого Email',
          true,
        );
        return;
      } else {
        SnackBarService.showSnackBar(
          context,
          'Неизвестная ошибка! Попробуйте еще раз или обратитесь в поддержку.',
          true,
        );
      }
    }

    navigator.pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(146, 170, 131, 1),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(72, 57, 42, 1),
        title: const Text('Зарегистрироваться', style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                controller: emailTextInputController,
                validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Введите правильный Email'
                    : null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  hintText: 'Введите Email',
                  hintStyle: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                autocorrect: false,
                controller: passwordTextInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  hintText: 'Введите пароль',
                  hintStyle: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                autocorrect: false,
                controller: passwordTextRepeatInputController,
                obscureText: isHiddenPassword,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  hintText: 'Введите пароль еще раз',
                  hintStyle: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                  suffix: InkWell(
                    onTap: togglePasswordView,
                    child: Icon(
                      isHiddenPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: fullNameInputController,
                validator: (value) => value != null && value.length < 6
                    ? 'Минимум 6 символов'
                    : null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  hintText: 'Введите фамилию и имя',
                  hintStyle: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                keyboardType: TextInputType.text,
                autocorrect: false,
                controller: jobTextInputController,
                validator: (value) => value != null && value.length < 2
                    ? 'Минимум 2 символа'
                    : null,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                      BorderSide(color: Color.fromRGBO(254, 233, 225, 1))),
                  hintText: 'Введите должность',
                  hintStyle: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(72, 57, 42, 1),
                    elevation: 8,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                onPressed: signUp,
                child: const Center(child: Text('Регистрация', style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),),),
              ),
              const SizedBox(height: 30),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text(
                  'Войти',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Color.fromRGBO(254, 233, 225, 1)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}