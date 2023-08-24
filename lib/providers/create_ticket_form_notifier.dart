import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:u_traffic_enforcer/config/enums/field_type.dart';
import 'package:u_traffic_enforcer/config/extensions/input_validator.dart';
import 'package:u_traffic_enforcer/model/form_input_settings.dart';

import '../config/enums/ticket_field.dart';

class CreateTicketFormNotifier extends ChangeNotifier {
  static final _formatter = FilteringTextInputFormatter.allow(
    RegExp(r"[a-zA-Z]+|\s"),
  );

  bool _noDriver = false;
  bool _ownedByDriver = false;

  final Map<TicketField, dynamic> _vehicleFormFields = {
    TicketField.violationsID: <Set<String>>{},
    TicketField.vehicleType: "",
    TicketField.engineNumber: "",
    TicketField.chassisNumber: "",
    TicketField.plateNumber: "",
    TicketField.vehicleOwner: "",
    TicketField.vehicleOwnerAddress: "",
  };

  final Map<TicketField, dynamic> _driverFormFields = {
    TicketField.licenseNumber: "",
    TicketField.lastName: "",
    TicketField.firstName: "",
    TicketField.middleName: "",
    TicketField.birthDate: "",
    TicketField.phone: "",
    TicketField.email: "",
    TicketField.address: "",
  };

  final _driverFormkey = GlobalKey<FormState>();
  final _vehicleFormKey = GlobalKey<FormState>();

  final Map<TicketField, FormSettings> _formSettings = {
    TicketField.firstName: FormSettings(
      label: "First Name",
      errorMessage: "Please enter a valid name",
      formatters: [_formatter],
      type: TicketFieldType.driver,
    ),
    TicketField.middleName: FormSettings(
      label: "Middle Name",
      errorMessage: "Please enter a valid name",
      formatters: [_formatter],
      type: TicketFieldType.driver,
    ),
    TicketField.lastName: FormSettings(
      label: "Last Name",
      errorMessage: "Please enter a valid name",
      formatters: [_formatter],
      type: TicketFieldType.driver,
    ),
    TicketField.birthDate: FormSettings(
      label: "Birthdate",
      type: TicketFieldType.driver,
    ),
    TicketField.phone: FormSettings(
      label: "Phone Number",
      errorMessage: "Please enter a valid phone number",
      type: TicketFieldType.driver,
      keyboardType: TextInputType.phone,
    ),
    TicketField.email: FormSettings(
      label: "Email",
      errorMessage: "Please enter a valid email address",
      type: TicketFieldType.driver,
      keyboardType: TextInputType.emailAddress,
    ),
    TicketField.address: FormSettings(
      label: "Address",
      type: TicketFieldType.driver,
    ),
    TicketField.licenseNumber: FormSettings(
      label: "License Number",
      errorMessage: "Please enter a License Number",
      type: TicketFieldType.driver,
    ),
    TicketField.plateNumber: FormSettings(
      label: "Plate Number",
      errorMessage: "Please enter valid plate number",
      type: TicketFieldType.vehicle,
    ),
    TicketField.chassisNumber: FormSettings(
      label: "Chassis Number",
      errorMessage: "Please enter valid chassis number",
      type: TicketFieldType.vehicle,
    ),
    TicketField.engineNumber: FormSettings(
      label: "Engine Number",
      errorMessage: "Please enter valid engine number",
      type: TicketFieldType.vehicle,
    ),
    TicketField.vehicleType: FormSettings(
      label: "Vehicle Type",
      errorMessage: "Please enter valid vehicle type",
      type: TicketFieldType.vehicle,
    ),
    TicketField.vehicleOwner: FormSettings(
      label: "Vehicle Owner",
      errorMessage: "Please enter valid name",
      type: TicketFieldType.vehicle,
    ),
    TicketField.vehicleOwnerAddress: FormSettings(
      label: "Vehicle Owner Address",
      errorMessage: "Please enter valid address",
      type: TicketFieldType.vehicle,
    ),
  };

  ///
  ///
  /// ------------------- GETTERS
  ///
  ///

  GlobalKey get driverFormKey => _driverFormkey;
  GlobalKey get vehicleFormKey => _vehicleFormKey;

  bool get noDriver => _noDriver;
  bool get ownedByDriver => _ownedByDriver;

  Map<TicketField, dynamic> get driverFormData => _driverFormFields;
  Map<TicketField, dynamic> get vehicleFormData => _vehicleFormFields;

  Map<TicketField, FormSettings> get formSettings => _formSettings;

  ///
  ///
  /// ------------------- SETTERS
  ///
  ///

  String? validateName(String? value, TicketField field) {
    switch (field) {
      case TicketField.firstName:
        {
          return value.isNotNull && !value!.isValidName
              ? _formSettings[field]!.errorMessage
              : null;
        }
      case TicketField.middleName:
        {
          return value.isNotNull && !value!.isValidName
              ? _formSettings[field]!.errorMessage
              : null;
        }
      default:
        {
          return value.isNotNull && !value!.isValidName
              ? _formSettings[TicketField.lastName]!.errorMessage
              : null;
        }
    }
  }

  String? validatePhone(String? value) {
    return value.isNotNull && !value!.isValidPhone
        ? _formSettings[TicketField.phone]!.errorMessage
        : null;
  }

  String? validateEmail(String? value) {
    return value.isNotNull && !value!.isValidEmail
        ? _formSettings[TicketField.email]!.errorMessage
        : null;
  }

  void updateDriverFormField(TicketField field, dynamic value) {
    _driverFormFields[field] = value;
    notifyListeners();
  }

  void updateVehicleFormField(TicketField field, dynamic value) {
    _vehicleFormFields[field] = value;
    notifyListeners();
  }

  void setNoDriver(bool value) {
    _noDriver = value;
    _ownedByDriver = false;

    notifyListeners();
  }

  void setOwnedByDriver(bool value) {
    _ownedByDriver = value;
    if (value && !_noDriver) {
      String firstName = _formSettings[TicketField.firstName]!.controller!.text;
      String middleName =
          _formSettings[TicketField.middleName]!.controller!.text;
      String lastName = _formSettings[TicketField.lastName]!.controller!.text;

      _formSettings[TicketField.vehicleOwner]!.controller!.text =
          "$lastName, $firstName $middleName";

      _formSettings[TicketField.vehicleOwnerAddress]!.controller!.text =
          _formSettings[TicketField.address]!.controller!.text;
    } else {
      _formSettings[TicketField.vehicleOwner]!.controller!.clear();
      _formSettings[TicketField.vehicleOwnerAddress]!.controller!.clear();
    }
    notifyListeners();
  }

  void clearDriverFields([bool value = false]) {
    _formSettings.forEach((key, value) {
      value.controller!.clear();
    });

    _driverFormFields.forEach((key, value) {
      _driverFormFields[key] = "";
    });

    _noDriver = value;
  }
}
