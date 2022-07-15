import 'package:demo_app/receive.dart';
import 'package:demo_app/send.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  final pages = [
    Send(),
    Request(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      bottomNavigationBar: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 0;
                  });
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 24,
                )),
            IconButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 1;
                  });
                },
                icon: const Icon(
                  Icons.call_received,
                  color: Colors.white,
                  size: 24,
                )),
          ],
        ),
      ),
    );
  }
}
