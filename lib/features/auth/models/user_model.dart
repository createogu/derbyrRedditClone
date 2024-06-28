import 'package:flutter/foundation.dart';

class UserModel {
  final String uid;
  final String name;
  final String profilePic;
  final String banner;
  final bool isAuthenticated; // if guest or not
  final String genderGb;
  final String classGb;
  final String addressCode;
  final String addressName;
  final String introduce;
  final double height;
  final double weight;
  final int point;
  final List<String> positions;
  final List<String> awards;

//<editor-fold desc="Data Methods">
  const UserModel(
      {required this.uid,
      required this.name,
      required this.profilePic,
      required this.banner,
      required this.isAuthenticated,
      required this.genderGb,
      required this.classGb,
      required this.addressCode,
      required this.addressName,
      required this.introduce,
      required this.height,
      required this.weight,
      required this.positions,
      required this.awards,
      required this.point});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          profilePic == other.profilePic &&
          banner == other.banner &&
          isAuthenticated == other.isAuthenticated &&
          genderGb == other.genderGb &&
          classGb == other.classGb &&
          addressCode == other.addressCode &&
          addressName == other.addressName &&
          introduce == other.introduce &&
          height == other.height &&
          weight == other.weight &&
          listEquals(other.positions, positions) &&
          listEquals(other.awards, awards) &&
          point == other.point);

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      profilePic.hashCode ^
      banner.hashCode ^
      isAuthenticated.hashCode ^
      genderGb.hashCode ^
      classGb.hashCode ^
      addressCode.hashCode ^
      addressName.hashCode ^
      introduce.hashCode ^
      height.hashCode ^
      weight.hashCode ^
      positions.hashCode ^
      awards.hashCode ^
      point.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' uid: $uid,' +
        ' name: $name,' +
        ' profilePic: $profilePic,' +
        ' banner: $banner,' +
        ' isAuthenticated: $isAuthenticated,' +
        ' genderGb: $genderGb,' +
        ' classGb: $classGb,' +
        ' addressCode: $addressCode,' +
        ' addressName: $addressName,' +
        ' introduce: $introduce,' +
        ' height: $height,' +
        ' weight: $weight,' +
        ' positions: $positions,' +
        ' awards: $awards,' +
        ' point: $point,' +
        '}';
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? profilePic,
    String? banner,
    bool? isAuthenticated,
    String? genderGb,
    String? classGb,
    String? addressCode,
    String? addressName,
    String? introduce,
    double? height,
    double? weight,
    List<String>? positions,
    List<String>? awards,
    int? point,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      profilePic: profilePic ?? this.profilePic,
      banner: banner ?? this.banner,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      genderGb: genderGb ?? this.genderGb,
      classGb: classGb ?? this.classGb,
      addressCode: addressCode ?? this.addressCode,
      addressName: addressName ?? this.addressName,
      introduce: introduce ?? this.introduce,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      positions: positions ?? this.positions,
      awards: awards ?? this.awards,
      point: point ?? this.point,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'profilePic': this.profilePic,
      'banner': this.banner,
      'isAuthenticated': this.isAuthenticated,
      'genderGb': this.genderGb,
      'classGb': this.classGb,
      'addressCode': this.addressCode,
      'addressName': this.addressName,
      'introduce': this.introduce,
      'height': this.height,
      'weight': this.weight,
      'positions': this.positions,
      'awards': this.awards,
      'point': this.point,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      banner: map['banner'] ?? '',
      isAuthenticated: map['isAuthenticated'] ?? false,
      genderGb: map['genderGb'] ?? '',
      classGb: map['classGb'] ?? '',
      addressCode: map['addressCode'] ?? '',
      addressName: map['addressName'] ?? '',
      introduce: map['introduce'] ?? '',
      height: map['height'] ?? 0,
      weight: map['weight'] ?? 0,
      positions: List<String>.from(map['positions']),
      awards: List<String>.from(map['awards']),
      point: map['point'].toInt() ?? 0,
    );
  }

//</editor-fold>
}
