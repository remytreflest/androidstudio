import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ipssisqy2023/view/resgister_view.dart';
import 'package:lottie/lottie.dart';

class MyLoader extends StatefulWidget {
  const MyLoader({super.key});

  @override
  State<MyLoader> createState() => _MyLoaderState();
}

class _MyLoaderState extends State<MyLoader> {

  PageController pageController = PageController(initialPage: 0);
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      Navigator.push(context,MaterialPageRoute(
          builder : (context){
            dispose();
            return const MyRegisterView();
          }
      ));
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: PageView(
        children: [
          Center(
            child: Lottie.asset("assets/animation_lk9qcjxv.json"),
          ),
        ],
        controller: pageController,
      ),
    );
  }
}
