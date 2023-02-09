import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController _controller = StreamController();

// 1 st method
  addStreamData() async {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 2));

      _controller.sink.add(i);
    }
  }

// 2 nd method - easy way
  Stream<int> addStreamData2() async* {
    for (var i = 0; i < 10; i++) {
      await Future.delayed(const Duration(seconds: 2));

      yield i;
    }
  }

  @override
  void initState() {
    super.initState();
    // 1 st method
    // addStreamData();

    // 2 nd method
    addStreamData2();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Stream and Stream builder"),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Stream Value", style: TextStyle(fontSize: 24)),
            SizedBox(height: 8),
            StreamBuilder(
                // 1 st method
                // stream: _controller.stream,

                // 2nd method
                stream: addStreamData2(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text("Error");
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator.adaptive();
                  }

                  return Text("${snapshot.data}",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold));
                })
          ],
        ),
      )),
    );
  }
}
