import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'RU';
  PhoneNumber number = PhoneNumber(isoCode: 'RU');

  var readPassword = false;
  var checkbox = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 74,
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
                      filled: true,
                      fillColor: Color.fromRGBO(36, 36, 36, 1),
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
                  padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(36, 36, 36, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          cursorColor: Colors.white,
                          obscureText: readPassword == true ? false : true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: readPassword == true
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        color: const Color.fromRGBO(187, 131, 255, 1),
                        onPressed: () {
                          setState(() {
                            readPassword = !readPassword;
                          });
                          debugPrint(readPassword.toString());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 210,
                    ),
                    Checkbox(
                      value: checkbox,
                      activeColor: const Color.fromRGBO(187, 131, 255, 1),
                      checkColor: const Color.fromRGBO(187, 131, 255, 1),
                      focusColor: const Color.fromRGBO(187, 131, 255, 1),
                      hoverColor: const Color.fromRGBO(187, 131, 255, 1),
                      fillColor: MaterialStateProperty.resolveWith((states) {
                        if (!states.contains(MaterialState.selected)) {
                          return Colors.transparent;
                        }
                        return null;
                      }),
                      side: const BorderSide(
                          color: Color.fromRGBO(187, 131, 255, 1), width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        side: const BorderSide(
                          color: Color.fromRGBO(187, 131, 255, 1),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          checkbox = !checkbox;
                        });
                      },
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: 365,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(227, 245, 99, 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Log in',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 72, 10, 0),
                      child: Text(
                        'Don’t have an account?',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 72, 0, 0),
                      child: InkWell(
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            color: Color.fromRGBO(187, 131, 255, 1),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed('/');
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
