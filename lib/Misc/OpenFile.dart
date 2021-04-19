import 'package:flutter/services.dart' show rootBundle;

class OpenFile {
  Future<List<String>> getDataFromFile(String filename) async {
    String allTheSlurs = await _getFileData(filename);
    return allTheSlurs.split(",");
  }

  Future<String> _getFileData(String path) async {
    return await rootBundle.loadString(path);
  }
}
