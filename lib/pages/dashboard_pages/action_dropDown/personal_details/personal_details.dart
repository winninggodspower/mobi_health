import 'package:intl/intl.dart';
import '../export_action_drop_down.dart';
import 'package:mobi_health/svg_assets.dart';
import 'package:country_picker/country_picker.dart';

class DetailsView extends StatefulWidget {
  DetailsView({super.key});

  @override
  State<DetailsView> createState() => _DetailsViewState();
}

class _DetailsViewState extends State<DetailsView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  DateTime? _selectedDateOfBirth;

  Country selectedCountry = Country(
      phoneCode: "+237",
      countryCode: 'CMR',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'cameroon',
      example: "Cameroon",
      displayName: "Cameroon",
      displayNameNoCountryCode: "CMR",
      e164Key: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: appAppBar('Personal Details'),
        body: SafeArea(
            child: SizedBox(
                width: 100.w,
                height: 100.h,
                child: SingleChildScrollView(
                    child: Padding(
                        padding:
                            EdgeInsets.only(left: 1.w, right: 1.w, top: 2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                width: 33.w,
                                height: 15.h,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.grey),
                                child: Image.asset(
                                  healthLogoPic,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Center(
                              child: Text(
                                "Edit",
                                textAlign: TextAlign.left,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17,
                                        color: Colors.black),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Form(
                              key: _formKey,
                              child: Container(
                                padding: const EdgeInsets.all(23),
                                decoration: const BoxDecoration(
                                  color: AppColors.customWhite,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(31.0),
                                    topRight: Radius.circular(31.0),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    const AppLabel(textContent: 'First name'),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      controller: TextEditingController(),
                                      decoration: const InputDecoration(
                                        hintText: 'John',
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    const AppLabel(textContent: 'Last name'),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      controller: TextEditingController(),
                                      decoration: const InputDecoration(
                                        hintText: 'John',
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter your name';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    const AppLabel(textContent: 'Phone number'),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '+237xxxxxxxxx',
                                        // ignore: avoid_unnecessary_containers, unnecessary_const
                                        prefixIcon: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                                padding: const EdgeInsets.only(
                                                    left: 24,
                                                    top: 8,
                                                    right: 24),
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                  right: BorderSide(
                                                    color: Color(0xFF8292AA),
                                                    width: 0.87,
                                                  ),
                                                )),
                                                child: InkWell(
                                                  onTap: () {
                                                    showCountryPicker(
                                                        context: context,
                                                        countryListTheme:
                                                            const CountryListThemeData(
                                                          bottomSheetHeight:
                                                              550,
                                                        ),
                                                        onSelect: ((value) => {
                                                              setState(() {
                                                                selectedCountry =
                                                                    value;
                                                              })
                                                            }));
                                                  },
                                                  child: Text(
                                                      '${selectedCountry.flagEmoji}'),
                                                )),
                                            const SizedBox(
                                              width: 24,
                                            ),
                                          ],
                                        ),
                                      ),
                                      controller: _phoneController,
                                      validator: (value) {
                                        final phoneRegex =
                                            RegExp(r'^\d{1,14}$');
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your phone number';
                                        } else if (!phoneRegex
                                            .hasMatch(value)) {
                                          return 'Please enter a valid 10-digit phone number';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    const AppLabel(
                                        textContent: 'Duration of Pregnancy'),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      controller: TextEditingController(),
                                      decoration: const InputDecoration(
                                        hintText: 'Date of Birth',
                                      ),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter Date of birth';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    const AppLabel(
                                        textContent: 'Date of Birth'),
                                    SizedBox(height: 1.h),
                                    TextFormField(
                                      controller: _dateOfBirthController,
                                      decoration: InputDecoration(
                                          hintText:
                                              'Date of Birth', // Placeholder text
                                          prefixIcon: IconButton(
                                            onPressed: () async {
                                              final DateTime? selectedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      firstDate: DateTime(1980),
                                                      lastDate: DateTime(2023));
                                              if (selectedDate != null) {
                                                final DateFormat formatter =
                                                    DateFormat('dd/MM/yyyy');
                                                final String formattedDate =
                                                    formatter
                                                        .format(selectedDate);
                                                setState(() {
                                                  _dateOfBirthController.text =
                                                      formattedDate;
                                                  _selectedDateOfBirth =
                                                      selectedDate;
                                                });
                                              }
                                            },
                                            icon: const Icon(
                                                Icons.calendar_month),
                                          )),
                                      validator: (value) {
                                        if (value?.isEmpty ?? true) {
                                          return 'Please enter your date of birth';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: 2.h),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.primary_800Color,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 28.w,
                                            vertical: 2.h,
                                          ),
                                        ),
                                        child: Text(
                                          'Save and update',
                                          style: GoogleFonts.alegreyaSans(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2.h),
                                    Center(
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.secondaryColor,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 36.w,
                                            vertical: 2.h,
                                          ),
                                        ),
                                        child: Text(
                                          'Logout',
                                          style: GoogleFonts.alegreyaSans(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 3.h),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))))));
  }
}
