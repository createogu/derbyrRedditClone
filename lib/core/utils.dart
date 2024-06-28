import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
}

Future<FilePickerResult?> pickImage() async {
  final image = await FilePicker.platform.pickFiles(type: FileType.image);

  return image;
}

String getCommCdNm(List commList, String commCd) {
  for (var item in commList) {
    if (item['comm_cd'] == commCd) {
      return item['comm_cd_nm'];
    }
  }
  return '';
}
