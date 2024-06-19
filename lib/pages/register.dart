import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  DateTime? _dob;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
      padding: const EdgeInsets.fromLTRB(23, 130, 23, 65),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('First Name',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 19.22,
                      fontWeight: FontWeight.w600,
                    )
            ),
            const SizedBox(height: 14),
            TextFormField(
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your first name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text('Last Name',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 19.22,
                      fontWeight: FontWeight.w600,
                    )
            ),
            const SizedBox(height: 14),
            TextFormField(
              controller: _lastNameController,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text('Date of Birth',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 19.22,
                      fontWeight: FontWeight.w600,
                    )
            ),
            const SizedBox(height: 14),
            TextFormField(
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your last name';
                }
                return null;
              },
            ),
            const SizedBox(height: 41),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Process the form data
                  print('First Name: ${_firstNameController.text}');
                  print('Last Name: ${_lastNameController.text}');
                  print('Date of Birth: $_dob');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    ));
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _dob) {
      setState(() {
        _dob = picked;
      });
    }
  }
}
