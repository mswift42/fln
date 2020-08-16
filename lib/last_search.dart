import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class LastSearchService {
  final String lastSearchesFile = 'lastsearches.txt';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$lastSearchesFile');
  }

  Future<File> writeSearches(List<String> searches) async {
    final file = await _localFile;
    return file.writeAsString(searches.join(','));
  }

  Future<List<String>> readSearches() async {
    try {
      final file = await _localFile;

      String contents = await file.readAsString();
      return contents.split(',');
    } catch (e) {
      print(e);
    }
    return null;
  }
}
