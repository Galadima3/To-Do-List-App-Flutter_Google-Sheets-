import 'package:flutter/material.dart';
import 'package:flutter_gsheet/google_sheets_api.dart';
import 'package:flutter_gsheet/textbox.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({Key? key}) : super(key: key);

  // const NotesGrid({Key? key, required this.text, required this.numberOfNotes})
  //     : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: GoogleSheetsApi.currentNotes.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4),
        itemBuilder: (BuildContext context, int index) {
          return MyTextBox(text: GoogleSheetsApi.currentNotes[index][0]);
        });
  }

}
