class ViolationOffense {
  final int level;
  final int fine;
  final String penalty;

  ViolationOffense({
    required this.level,
    required this.fine,
    required this.penalty,
  });

  factory ViolationOffense.fromJson(Map<String, dynamic> json) {
    return ViolationOffense(
      level: json['level'] as int,
      fine: json['fine'] as int,
      penalty: json['penalty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'level': level,
      'fine': fine,
      'penalty': penalty,
    };
  }

  ViolationOffense copyWith({
    int? level,
    int? fine,
    String? penalty,
  }) {
    return ViolationOffense(
      level: level ?? this.level,
      fine: fine ?? this.fine,
      penalty: penalty ?? this.penalty,
    );
  }
}
