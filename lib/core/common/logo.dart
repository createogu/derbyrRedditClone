import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../constants/size.dart';

class Logo extends StatelessWidget {
  final double? size;

  const Logo({
    this.size,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (size ?? 24) * 1.3,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Image.asset(
              Constants.logoPath,
              height: (size ?? 24),
              width: (size ?? 24),
            ),
          ),
          const SizedBox(
            width: SMALL_GAP,
          ),
          Text(
            Constants.serviceNameKor,
            style: TextStyle(
              fontSize: (size ?? 24),
              fontWeight: FontWeight.w900,
            ),
          )
        ],
      ),
    );
  }
}
