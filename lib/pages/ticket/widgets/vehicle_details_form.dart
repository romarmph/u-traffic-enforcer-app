import 'package:u_traffic_enforcer/pages/ticket/vehicle_type_select_page.dart';

import '../../../config/utils/exports.dart';

class VehiecleDetailsForm extends ConsumerWidget {
  const VehiecleDetailsForm({
    super.key,
    required this.plateNumberController,
    required this.engineNumberController,
    required this.chassisNumberController,
    required this.vehicleOwnerController,
    required this.vehicleOwnerAddressController,
    required this.vehicleTypeController,
    required this.conductionController,
  });

  final TextEditingController plateNumberController;
  final TextEditingController engineNumberController;
  final TextEditingController chassisNumberController;
  final TextEditingController vehicleOwnerController;
  final TextEditingController vehicleOwnerAddressController;
  final TextEditingController vehicleTypeController;
  final TextEditingController conductionController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formValidator = ref.watch(formValidatorProvider);
    final form = ref.watch(createTicketFormProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Vehicle Details",
          style: const UTextStyle().textbasefontmedium,
        ),
        const SizedBox(height: USpace.space12),
        VehicleTypeInputField(
          controller: vehicleTypeController,
        ),
        const SizedBox(height: USpace.space12),
        CreateTicketField(
          formatters: [
            UpperCaseTextFormatter(),
          ],
          decoration: InputDecoration(
            labelText: 'Plate Number',
            suffixIcon: IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                QuickAlert.show(
                  context: context,
                  type: QuickAlertType.info,
                  title: 'Valid Formats',
                  text: plateNumberFormats,
                );
              },
            ),
          ),
          validator: formValidator.validatePlateNumber,
          controller: plateNumberController,
        ),
        const SizedBox(height: USpace.space12),
        CreateTicketField(
          decoration: const InputDecoration(
            labelText: 'Conduction Sticker or File Number',
          ),
          validator: (value) {
            return null;
          },
          controller: conductionController,
        ),
        const SizedBox(height: USpace.space12),
        CreateTicketField(
          formatters: [
            UpperCaseTextFormatter(),
          ],
          decoration: const InputDecoration(
            labelText: 'Engine Number',
          ),
          validator: (value) {
            return null;
          },
          controller: engineNumberController,
        ),
        const SizedBox(height: USpace.space12),
        CreateTicketField(
          formatters: [
            UpperCaseTextFormatter(),
          ],
          decoration: const InputDecoration(
            labelText: 'Chassis Number',
          ),
          controller: chassisNumberController,
        ),
        const SizedBox(height: USpace.space12),
        Row(
          children: [
            Expanded(
              child: Text(
                "Vehicle Owner",
                style: const UTextStyle().textbasefontmedium,
              ),
            ),
            Expanded(
              flex: 1,
              child: CheckboxListTile(
                title: const Text("Owned by Driver"),
                enabled: !form.isDriverNotPresent,
                contentPadding: const EdgeInsets.all(0),
                dense: true,
                visualDensity: VisualDensity.compact,
                value: ref.watch(isSameWithDriver),
                onChanged: (value) {
                  ref.read(isSameWithDriver.notifier).state = value!;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: USpace.space12),
        CreateTicketField(
          formatters: [
            UpperCaseTextFormatter(),
          ],
          decoration: const InputDecoration(
            labelText: 'Vehicle Owner',
          ),
          controller: vehicleOwnerController,
        ),
        const SizedBox(height: USpace.space12),
        CreateTicketField(
          formatters: [
            UpperCaseTextFormatter(),
          ],
          decoration: const InputDecoration(
            labelText: 'Vehicle Owner Address',
          ),
          controller: vehicleOwnerAddressController,
        ),
      ],
    );
  }
}

class VehicleTypeInputField extends ConsumerWidget {
  const VehicleTypeInputField({
    super.key,
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final form = ref.watch(createTicketFormProvider);
    final formValidator = ref.watch(formValidatorProvider);
    return TextFormField(
      readOnly: true,
      decoration: const InputDecoration(
        labelText: "Vehicle Type",
      ),
      controller: controller,
      validator: formValidator.validateVehicleType,
      onTap: () async {
        final VehicleType? type = await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const VehicleTypeSelectPage(),
          ),
        );

        if (type != null) {
          controller.text = type.typeName;
          form.setVehicleTypeID(type.id!);
        }
      },
    );
  }
}
