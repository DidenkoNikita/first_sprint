import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class PhoneNumberWidget extends StatefulWidget {
  final int activeStep;
  final void Function(int newStep) updateActiveStep;

  const PhoneNumberWidget({
    Key? key,
    required this.activeStep,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<PhoneNumberWidget> createState() => _PhoneNumberWidgetState();
}

class _PhoneNumberWidgetState extends State<PhoneNumberWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'RU';
  PhoneNumber number = PhoneNumber(isoCode: 'RU');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late int activeStep = widget.activeStep;

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Enter your phone number',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              width: 365,
              height: 48,
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(36, 36, 36, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  debugPrint(number.phoneNumber);
                },
                onInputValidated: (bool value) {
                  debugPrint(value.toString());
                },
                hintText: 'Phone',
                errorMessage: 'Number entered incorrectly',
                cursorColor: Colors.white,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                selectorTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                selectorConfig: const SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: false,
                autoValidateMode: AutovalidateMode.disabled,
                initialValue: number,
                textAlignVertical: TextAlignVertical.top,
                textAlign: TextAlign.start,
                inputDecoration: const InputDecoration(
                  hintText: 'Phone',
                  hintStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: -45),
                  border: InputBorder.none,
                ),
                textFieldController: controller,
                formatInput: true,
                maxLength: 13,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                onSaved: (PhoneNumber number) {
                  debugPrint('On Saved: $number');
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: 365,
              height: 48,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(227, 245, 99, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  setState(() {
                    widget.updateActiveStep(activeStep + 1);
                    debugPrint(activeStep.toString());
                  });
                },
                child: Text(
                  'Next',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
            const SizedBox(
              height: 140,
            ),
            const Text(
              'Or',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 108.3,
                  height: 44,
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(36, 36, 36, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/svg/google.svg',
                    ),
                  ),
                ),
                Container(
                  width: 108.3,
                  height: 44,
                  margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(36, 36, 36, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/svg/facebook.svg',
                    ),
                  ),
                ),
                Container(
                  width: 108.3,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(36, 36, 36, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      'assets/svg/apple.svg',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
