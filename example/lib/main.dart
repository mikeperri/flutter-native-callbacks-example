import 'package:flutter/material.dart';
import 'dart:async';

import 'package:async/async.dart';
import 'package:native_callbacks_example/native_callbacks_example.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final plugin = NativeCallbacksExample();
  CancelableOperation<int> methodAOperation;
  CancelableOperation<List<String>> methodBOperation;
  int methodAResult;
  List<String> methodBResult;

  @override
  void initState() {
    super.initState();
    plugin.doSetup();
    getNativeData();
  }

  Future<void> getNativeData() async {
    methodAOperation?.cancel();
    methodBOperation?.cancel();

    setState(() {
      methodAResult = null;
      methodBResult = null;
    });

    methodAOperation = CancelableOperation.fromFuture(plugin.methodA());
    methodAOperation
      .value
      .then((_methodAResult) {
        setState(() {
          methodAResult = _methodAResult;
        });
      });

    methodBOperation = CancelableOperation.fromFuture(plugin.methodB());
    methodBOperation
      .value
      .then((_methodBResult) {
        setState(() {
          methodBResult = _methodBResult;
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(child: Text('Method A result: $methodAResult')),
            Center(child: Text('Method B result: ${methodBResult?.join()}')),
            RaisedButton(
              onPressed: getNativeData,
              child: Text('Call native methods'),
            ),
          ],
        ),
      ),
    );
  }
}
