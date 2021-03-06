import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  //create credentials
  static const _credentials = r'''
{
  "type": "service_account",
  "project_id": "flutter-gsheets-app-355806",
  "private_key_id": "8fa5508cbf5d70d1c18bc85df441b22435d23cd7",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC6qxvwo8o4mqaV\n4u9bhmpiq7QrND8WVXYxDoeZrVViuUFnBTIhLyYJUJU8+BblfnQ/s9fjW4lunYFh\nPDj25pB9xg0EGW4Jis3R+MPrCOJhNRKDTlQnWuTlGRxACWWhcGz5Et98BEcGNo7g\naOs9K/jAz+Ch/0R3tA4jMxPe4jLGVZw0/Fa1hq/g6jzrOwyFfdM2q+PXU/YjxR7P\nuZ+f2zGKuzSikiPQ5FrC5CZ5S3MoS9O8N0ZVejFCWQRzMBC3tw97Fe9aT7Tv0qSk\ngxZSsgkkKpH8JSUQ87BcgZqsSJV5o3PdFp9oyk3IK1W2MUqcDnACPI//iJgoCGDW\nWCLHRPNvAgMBAAECggEARF+Kc2E7H/KdlAc0jzyz2QJ1kuGnPgH9schVqNeRkAC1\nUQvZKciAUScgEt34XQUthWvVZuTPeSHeEwShBOa9BCS3/clmwb4C16cb9AokCWEM\nL+ZP8r5bWwMQkvAeNrzcXXspOt7COSdgvBgSGizyB4XdDNlYddQQ3ZnG7HvEB1sQ\nh2woT/oTfs9uu00NES/gfBemjtAsQfi+3iCmtbkTs+eizH5Vx99H1sXzEjftZsuy\nEV5vrEAOw3dUEffcAMfx38OBb8uRNkL8AW79iHKbgtyhVcqhLsZRWKa9hzyljwX2\n2VE1Vhx8I22gMjlZEPAf1+hycEq1RRZFLpqibgTTcQKBgQD7wgsen4odsY7I6iV8\nj8jpZvb/G1MIyI36grzEtDWCuVRhGHvkpXMJk7kHJ+jPYKjKH5EAoO7LKXPwqOUe\nr9jBooSP3UBJ8oTGKm97QtLmCUiEnsyXTXw7xCXs95gvwMtl5EhXy3bIkr7U7SqR\nzYE0lHNEFVadCzT64Eo+ihH2NwKBgQC90E1aIBeknUbE3Wn6aOTaf16yTtWmbPCO\nOKqaHo0Fq15fYYHb1r62SxRdtrrDnbw3vuCCp+j38EidD02Z51IwCAKKvYQebmYF\na0DH2RY9ohXY6ZK1DsYKWzUPh/BtybLpY80yFx256c4F02haD5TZUMwY+/XsZdmi\nVXtO84FQiQKBgDY63TRSf2jYB37F2R9UxZ1pPYlENIWu1c6BfPIOM3yeOUvU/1MI\nRJhqhq/A7AhHtPQdCpoNEIMYwc20Q+5xSIqlXFK1ARUstWcOWwc9JLrCgyl2H3H0\nEe+518WMq+6VY/rlyqOGw2Z/HbY2BDZ2Av/1fkLLKeYYNOhZigSgry/PAoGABMgh\nmrqiPdhkdwMo71EDKun4hb9srHOkH8EXsyg/3zuw9fAr6FDhnxAHJFE9JT5tBm59\nk20NdmmMOsCu8MieDm21Oq+Ji4a2dT59dEtovwa9TCieNId5v7sKfCitiuaA5lZI\nThG9Avj74rOvtk0cL9lUOvDmAh2SvP8wSw3hXRkCgYB9MfkLLaqdU5b8APCnyLcV\naO4G7odSUc1JnbeEuQ4iEdTIzgcH1reIc+VBpGXlRa/5SlUUAYEcMUVwBEsnqyAn\nmFjSTQwW+9mUZ9ZQa5Z6UoLALOlNRJ6iPuaXGHwybBhFrtfDzUA7eRdLtYRf8lsZ\ngRSODht6i6yWUK0XaYuwSA==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets-app@flutter-gsheets-app-355806.iam.gserviceaccount.com",
  "client_id": "115513638346284142396",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets-app%40flutter-gsheets-app-355806.iam.gserviceaccount.com"
}

''';

  // some variables to keep track of..
  static int numberOfNotes = 0;
  static List<List<dynamic>> currentNotes = [
    //[ to do, completed ]
  ];
  static bool loading = true;

  //set up and connect to the spreadsheet
  static const _spreadsheetId = '1DEJeqfWR6FsmKPN2qEw8Ht7iGsJ3soOrgMcjdLYdIMY';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  //initialize the spreadsheet
  Future<void> init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while (
        (await _worksheet!.values.value(column: 1, row: numberOfNotes + 1)) !=
            '') {
      numberOfNotes++;
    }
    // now we know how many notes to load, now let's load them!
    loadNotes();
  }

  // load existing notes from the spreadsheet
  static Future loadNotes() async {
    if (_worksheet == null) return;

    for (int i = 0; i < numberOfNotes; i++) {
      final String newNote =
          await _worksheet!.values.value(column: 1, row: i + 1);
      if (currentNotes.length < numberOfNotes) {
        currentNotes.add([newNote, 
        int.parse(await _worksheet!.values.value(column: 2, row: i + 1))]);
      }
    }
    loading = false;
  }

  //insert a new note
  static Future insert(String note) async {
    if (_worksheet == null) return;
    numberOfNotes++;
    currentNotes.add([note, 0]);
    await _worksheet!.values.appendRow([note, 0]);
  }

  static Future update(int index, int isTaskCompleted) async {
    _worksheet!.values.insertValue(isTaskCompleted, column: 2, row: index + 1);
  }
}
