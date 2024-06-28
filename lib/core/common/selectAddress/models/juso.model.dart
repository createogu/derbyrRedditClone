class JusoModel {
  final String code;
  final String name;

  JusoModel({
    required this.code,
    required this.name,
  });

  factory JusoModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return JusoModel(
      code: json['code'],
      name: json['name'],
    );
  }
}
