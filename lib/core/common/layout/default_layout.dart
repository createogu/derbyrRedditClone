import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teambasketball/theme/pallete.dart';

import '../../constants/size.dart';

//데코레이터 같은 기능
class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroudColor;
  final String? title;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroudColor,
    this.title,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    return Scaffold(
      appBar: RenderAppBar(),
      bottomNavigationBar: bottomNavigationBar,
      //??는 왼쪽 값이 null이면 오른쪽 값
      backgroundColor: backgroudColor ?? Pallete.whiteColor,
      body: SafeArea(
        top: true,
        bottom: false,
        child: child,
      ),
    );
  }

  AppBar? RenderAppBar() {
    if (title == null) {
    } else {
      return AppBar(
        backgroundColor: Pallete.whiteColor,
        surfaceTintColor: Pallete.whiteColor,
        elevation: 0,
        // !는 null이 안들어온다는 명시
        title: Text(title!,
            style: TextStyle(
              fontSize: MEDIUM_FONT_SIZE,
              fontWeight: FontWeight.w700,
            )),
      );
    }
  }
}
