import 'package:file_selector/file_selector.dart';

Future<String?> pickDirectory() async {
  return await getDirectoryPath();
}
