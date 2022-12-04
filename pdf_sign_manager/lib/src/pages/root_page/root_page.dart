import 'package:flutter/material.dart';
import '../work_page/work_page.dart';

class RootPage extends StatefulWidget {
  int? _pageIndex;
  RootPage({Key? key, int? pageIndex})
      : _pageIndex = pageIndex,
        super(key: key);

  @override
  State<RootPage> createState() => _RootPageState(_pageIndex);
}

class _RootPageState extends State<RootPage> {
  int _pageIndex;
  _RootPageState(pageIndex) : _pageIndex = pageIndex;
  GlobalKey bottomNavigationKey = GlobalKey();
  NavigationRailLabelType labelType = NavigationRailLabelType.all;
  double groupAligment = -1.0;
  List<Widget> pageList = <Widget>[
    const WorkPage(),
    const WorkPage(),
    const WorkPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_pageIndex == null) {
      _pageIndex = 0;
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(146, 170, 131, 1),
      body: SafeArea(
        child: Row(
          children: <Widget>[
            NavigationRail(
              backgroundColor: Color.fromRGBO(146, 170, 131, 1),
              //backgroundColor: Color.fromRGBO(254, 233, 225, 1),
              selectedIndex: _pageIndex,
              groupAlignment: groupAligment,
              onDestinationSelected: (int index) {
                setState(() {
                  _pageIndex = index;
                });
              },
              labelType: labelType,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.home_outlined, color: Color.fromRGBO(254, 233, 225, 1)),
                  selectedIcon: Icon(Icons.home, color: Color.fromRGBO(254, 233, 225, 1),),
                  label: Text('First', style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border, color: Color.fromRGBO(254, 233, 225, 1),),
                  selectedIcon: Icon(Icons.book, color: Color.fromRGBO(254, 233, 225, 1),),
                  label: Text('Second', style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.logout_rounded, color: Color.fromRGBO(254, 233, 225, 1),),
                  selectedIcon: Icon(Icons.login_rounded, color: Color.fromRGBO(254, 233, 225, 1),),
                  label: Text('Login', style: TextStyle(color: Color.fromRGBO(254, 233, 225, 1)),),
                ),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            // This is the main content.
            Expanded(
              child: Container(child: pageList.elementAt(_pageIndex),)
            ),
          ],
        ),
      ),
    );
  }
}