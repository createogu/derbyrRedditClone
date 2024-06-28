import 'package:flutter/material.dart';
import 'dart:io';
import '../../features/feed/feed_screen.dart';
import '../../features/post/screens/add_post_screen.dart';

//에뮬레이터의 로컬 IP
final emulatorIp = 'http://10.0.0.2:3000';

//시뮬레이터의 로컬 IP
final simulatorIp = 'http://localhost:8080';

class Constants {
  static const serviceNameKor = "팀농구";
  static const serviceNameEng = "Teambasketball";

  final ip = Platform.isIOS ? simulatorIp : emulatorIp;

  static const logoPath = 'assets/images/logo.png';
  static const loginEmotePath = 'assets/images/loginEmote.png';
  static const googlePath = 'assets/images/google.png';

  static const bannerDefault =
      'https://thumbs.dreamstime.com/b/abstract-stained-pattern-rectangle-background-blue-sky-over-fiery-red-orange-color-modern-painting-art-watercolor-effe-texture-123047399.jpg';
  static const avatarDefault =
      'https://external-preview.redd.it/5kh5OreeLd85QsqYO1Xz_4XSLYwZntfjqou-8fyBFoE.png?auto=webp&s=dbdabd04c399ce9c761ff899f5d38656d1de87c2';

  static const tabWidgets = [
    FeedScreen(),
    AddPostScreen(),
  ];

  static const IconData up = Icons.thumb_up_alt_outlined;
  static const IconData down = Icons.thumb_down_alt_outlined;

  static const awardsPath = 'assets/images/awards';

  static const awards = {
    'awesomeAns': '${Constants.awardsPath}/awesomeanswer.png',
    'gold': '${Constants.awardsPath}/gold.png',
    'platinum': '${Constants.awardsPath}/platinum.png',
    'helpful': '${Constants.awardsPath}/helpful.png',
    'plusone': '${Constants.awardsPath}/plusone.png',
    'rocket': '${Constants.awardsPath}/rocket.png',
    'thankyou': '${Constants.awardsPath}/thankyou.png',
    'til': '${Constants.awardsPath}/til.png',
  };
}
