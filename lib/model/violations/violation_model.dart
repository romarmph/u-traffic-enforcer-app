import 'package:u_traffic_enforcer/config/utils/exports.dart';

class Violation {
  final String? id;
  final String name;
  final List<ViolationOffense> offense;
  final bool isDisabled;
  // final List<ViolationOffense> offenseBigVehicle;
  final String createdBy;
  final String editedBy;
  final Timestamp dateCreated;
  final Timestamp? dateEdited;
  bool isSelected;

  Violation({
    this.isSelected = false,
    required this.id,
    required this.name,
    required this.offense,
    this.isDisabled = false,
    // required this.offenseBigVehicle,
    required this.createdBy,
    required this.editedBy,
    required this.dateCreated,
    this.dateEdited,
  });

  factory Violation.fromJson(Map<String, dynamic> json, String id) {
    return Violation(
      id: id,
      name: json['name'],
      offense: List<Map<String, dynamic>>.from(json['offense'])
          .map((e) => ViolationOffense.fromJson(e))
          .toList(),
      isDisabled: json['isDisabled'],
      // offenseBigVehicle:
      //     List<Map<String, dynamic>>.from(json['offenseBigVehicle'])
      //         .map((e) => ViolationOffense.fromJson(e))
      //         .toList(),
      createdBy: json['createdBy'],
      editedBy: json['editedBy'],
      dateCreated: json['dateCreated'],
      dateEdited: json['dateEdited'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'offense': offense,
      'isDisabled': isDisabled,
      'createdBy': createdBy,
      'editedBy': editedBy,
      'dateCreated': dateCreated,
      'dateEdited': dateEdited,
      // 'offenseBigVehicle': offenseBigVehicle,
    };
  }

  Violation copyWith({
    String? id,
    String? name,
    List<ViolationOffense>? offense,
    bool? isDisabled,
    List<ViolationOffense>? offenseBigVehicle,
    String? createdBy,
    String? editedBy,
    Timestamp? dateCreated,
    Timestamp? dateEdited,
  }) {
    return Violation(
      id: id ?? this.id,
      name: name ?? this.name,
      offense: offense ?? this.offense,
      isDisabled: isDisabled ?? this.isDisabled,
      // offenseBigVehicle: offenseBigVehicle ?? this.offenseBigVehicle,
      createdBy: createdBy ?? this.createdBy,
      editedBy: editedBy ?? this.editedBy,
      dateCreated: dateCreated ?? this.dateCreated,
      dateEdited: dateEdited ?? this.dateEdited,
    );
  }
}
