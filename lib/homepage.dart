import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gsheet/button.dart';
import 'package:flutter_gsheet/google_sheets_api.dart';
import 'package:flutter_gsheet/list_of_todo.dart';
import 'package:flutter_gsheet/loading_circle.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () => setState(() {}),
    );
  }

  void _post() {
    GoogleSheetsApi.insert(_controller.text);
    _controller.clear();
    setState(() {});
  }

  // wait for the data to be fetched from google sheets
  void startLoading() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (GoogleSheetsApi.loading == false) {
        setState(() {});
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // start loading until the data arrives
    if (GoogleSheetsApi.loading == true) {
      startLoading();
    }
    return Scaffold(
        appBar: AppBar(
          title: const Text('Post A Note'),
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        backgroundColor: Colors.grey.shade300,
        body: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  child: GoogleSheetsApi.loading == true
                      ? const LoadingCircle()
                      : const MyTodoList(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'enter...',
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _controller.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text('@ Mylez '),
                        ),
                        MyButton(
                          text: 'P O S T',
                          function: _post,
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
