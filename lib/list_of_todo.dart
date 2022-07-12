import 'package:flutter/material.dart';
import 'package:flutter_gsheet/google_sheets_api.dart';

class MyTodoList extends StatefulWidget {
  const MyTodoList({Key? key}) : super(key: key);

  @override
  State<MyTodoList> createState() => _MyTodoListState();
}

class _MyTodoListState extends State<MyTodoList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: GoogleSheetsApi.currentNotes.length,
        itemBuilder: (BuildContext context, int index) {
          return CheckboxListTile(
            value: GoogleSheetsApi.currentNotes[index][1] == 0 ? false : true,
            onChanged: (newValue) {
              GoogleSheetsApi.update(index, newValue == false ? 0 : 1);
              setState(() {
                GoogleSheetsApi.currentNotes[index][1] =
                    (newValue == false ? 0 : 1);
              });
            },
            title: Text(GoogleSheetsApi.currentNotes[index][0]),
          );
        });
  }
}
