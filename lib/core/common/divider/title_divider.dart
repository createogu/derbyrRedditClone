import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String title;
  final String? subTitle;

  const TitleDivider({required this.title, this.subTitle, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subTitle != null)
              Text(
                subTitle.toString(),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
        Divider(),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
