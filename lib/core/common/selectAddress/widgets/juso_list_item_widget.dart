import 'package:flutter/material.dart';
import 'package:teambasketball/theme/pallete.dart';

import '../../../constants/size.dart';
import '../models/juso.model.dart';

class JusoListItemWidget extends StatelessWidget {
  final String code;
  final String name;

  const JusoListItemWidget({
    required this.code,
    required this.name,
    Key? key,
  }) : super(key: key);

  factory JusoListItemWidget.fromModel({
    required JusoModel model,
  }) {
    return JusoListItemWidget(
      code: model.code,
      name: model.name,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Pallete.whiteColor,
      child: Center(
        child: Text(
          name.lastIndexOf(' ') != -1
              ? name.replaceRange(0, name.lastIndexOf(' '), '')
              : name,
          style: TextStyle(
            fontSize: SMALL_FONT_SIZE,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
