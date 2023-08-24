import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_traffic_enforcer/config/enums/field_type.dart';

class FormSettings {
  final String label;
  final String? errorMessage;
  final List<TextInputFormatter> formatters;
  TextEditingController? controller;
  final TicketFieldType type;
  final TextInputType? keyboardType;

  FormSettings({
    required this.label,
    TextEditingController? controller,
    this.errorMessage,
    this.formatters = const [],
    required this.type,
    this.keyboardType,
  }) : controller = controller ?? TextEditingController();
}
