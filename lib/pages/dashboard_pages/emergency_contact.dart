import 'package:mobi_health/providers/authentication_provider.dart';

import 'action_dropDown/export_action_drop_down.dart';
import 'dart:developer' as developer;

class EmergencyContact extends StatefulWidget {

  const EmergencyContact({super.key});

  @override
  State<EmergencyContact> createState() => _EmergencyContactState();
}

class _EmergencyContactState extends State<EmergencyContact> {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? emergencyContact;


  @override
  void initState() {
    final authProvider = context.read<AuthenticationProvider>();
    final userInfo = authProvider.userInfo;

    emergencyContact = userInfo?['emergencyContact'];
    _phoneController.text = emergencyContact ?? '';
    developer.log(emergencyContact.toString());

    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthenticationProvider>();
    final userInfo = authProvider.userInfo;

   emergencyContact = userInfo?['emergencyContact'];

    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: appAppBar('Emergency contact'),
        body: SafeArea(
            child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter an emergency contact we can get to if any issues. This can be your guardian, spouse or fclose friend',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: 20),
                          const AppLabel(
                              textContent: 'Current emergency contact'),
                          const SizedBox(height: 4),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              hintText: '+927 412 9122',
                              fillColor: AppColors.grayLight,
                            ),
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Please enter your last name';
                              }
                              if (value == emergencyContact) {
                                return 'this is your emergency contact already';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 9),
                          materialButton(
                              buttonBkColor:
                                  const Color.fromARGB(255, 189, 189, 189),
                              onPres: () {
                                 if (_formKey.currentState?.validate() ?? false) {
                                  authProvider.updateEmergencyContact(_phoneController.text.trim(), context);
                                } 
                                },
                              text: "Update Contact",
                              textColor: AppColors.gray,
                              width: double.infinity,
                              borderRadiusSize: 5,
                              height: 50),
                        ],
                      ),
                    ),
                  ),
                ))));
  }
}
