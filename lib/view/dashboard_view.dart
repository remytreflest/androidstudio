import 'package:flutter/material.dart';
import 'package:ipssisqy2023/view/my_drawer.dart';
import 'package:ipssisqy2023/view/resgister_view.dart';

class MyDashBoardView extends StatefulWidget {
  const MyDashBoardView({super.key});

  @override
  State<MyDashBoardView> createState() => _MyDashBoardViewState();
}

class _MyDashBoardViewState extends State<MyDashBoardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Container(
        width: MediaQuery.of(context).size.width *0.75,
        height: MediaQuery.of(context).size.height,
        color: Colors.amber,
        child: const MyDrawer(),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.purple,
      body: bodyPage(),
    );
  }

  Widget bodyPage(){
    return Text("Ma body Page");
  }
}
