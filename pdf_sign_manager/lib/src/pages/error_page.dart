import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'root_page/root_page.dart';

// ignore: must_be_immutable
class ErrorPage extends StatelessWidget {
  final String exPageName;
  ErrorPage({Key? key, required this.exPageName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    // handled errors opens dialog box instead new page
    return Scaffold(
      backgroundColor: Color.fromRGBO(36, 42, 50, 1),
      body: Column(
        children: [
          Flexible(flex: 7, child: Container()),
          Flexible(
            flex: 5,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor:
                MaterialStateProperty.all(Color.fromRGBO(16, 18, 21, 0.97)),
                shadowColor: MaterialStateProperty.all(Colors.black),
                elevation: MaterialStateProperty.all(12),
                padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                minimumSize:
                MaterialStateProperty.all(Size(width / 3, height / 10)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              onPressed: () => toPreviousPage(context),
              child: Text(
                "Back",
                style: TextStyle(
                    color: Color.fromRGBO(254, 233, 225, 1),
                    fontSize: 24),
              ),
            ),
          ),
          Flexible(flex: 7, child: Container()),
        ],
      ),
    );
  }

  final mfaAction = AuthStateChangeAction<MFARequired>(
        (context, state) async {
      final nav = Navigator.of(context);

      await startMFAVerification(
        resolver: state.resolver,
        context: context,
      );

      nav.pushReplacementNamed('/profile');
    },
  );

  toPreviousPage(context) {
    if (exPageName == "WorkPage") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => RootPage(pageIndex: 0)));
    }
    if (exPageName == "SearchPage") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => RootPage(pageIndex: 0)));
    }
    if (exPageName == "WatchListPage") {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => RootPage(pageIndex: 0)));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => RootPage(pageIndex: 0)));
    }
  }
}