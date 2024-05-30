import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';

class SpiderAppScreen extends StatefulWidget{
  final String label;
  final Widget body;
  final bool showNavBar;

  SpiderAppScreen(this.label, {required this.body, required this.showNavBar});

  @override
  State<StatefulWidget> createState() => _SpiderAppScreenState();

}

class _SpiderAppScreenState extends State<SpiderAppScreen>{
  static int currentPageIndex = 0;
  static Map<int, String> routs = {
    0: "/chats",
    1: "/issues"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: !widget.showNavBar ? null :
        NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
              if(currentPageIndex == 0){
                Navigator.pushReplacementNamed(context, routs[currentPageIndex]!);
              }else{
                Navigator.pushNamed(context, routs[currentPageIndex]!).then((val) => {
                  setState(() {
                    currentPageIndex = 0;
                  })
                });
              }
            });
          },
          indicatorColor: Colors.purpleAccent,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Badge(
                child: Icon(Icons.messenger),
              ),
              label: 'Chats',
            ),
            NavigationDestination(
              icon: Badge(
                  child: Icon(Icons.task_outlined)
              ),
              label: 'Issues',
            ),
          ],
        ),
      appBar: AppBar(
        leading: null,
        title: Text(
          widget.label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 24
          ),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(230, 255, 255, 255),
      body: widget.body,
    );

  }

}