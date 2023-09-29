import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnterPasswordWidget extends StatefulWidget {
  final int activeStep;
  final void Function(String password) onPasswordEntered;
  final void Function(int newStep) updateActiveStep;

  const EnterPasswordWidget({
    Key? key,
    required this.onPasswordEntered,
    required this.activeStep,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<EnterPasswordWidget> createState() => _EnterPasswordWidgetState();
}

class _EnterPasswordWidgetState extends State<EnterPasswordWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var readPassword = false;
  var readAgainPassword = false;
  var checkbox = false;
  var password = '';
  var repeatPassword = '';
  var correctPassword = false;

  @override
  Widget build(BuildContext context) {
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
                  height: 40,
                ),
                const SizedBox(
                  width: 209,
                  child: Text(
                    'Create and enter your password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Container(
                  width: 365,
                  height: 48,
                  padding: const EdgeInsets.fromLTRB(20, 0, 8, 0),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(36, 36, 36, 1),
                    borderRadius: BorderRadius.circular(10),
                    border: correctPassword == true
                        ? Border.all(
                            color: const Color.fromRGBO(235, 87, 87, 1),
                            width: 1,
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              password = value;
                              correctPassword = false;
                            });
                          },
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
                SizedBox(
                  width: 365,
                  height: 20,
                  child: Row(
                    children: [
                      if (correctPassword == true)
                        const Text(
                          'Please check the password matches the required characters',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(235, 87, 87, 1),
                          ),
                        ),
                    ],
                  ),
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
                          onChanged: (value) {
                            setState(() {
                              repeatPassword = value;
                              correctPassword = false;
                            });
                          },
                          cursorColor: Colors.white,
                          obscureText: readAgainPassword == true ? false : true,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Enter again',
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
                        icon: readAgainPassword == true
                            ? const Icon(CupertinoIcons.eye)
                            : const Icon(CupertinoIcons.eye_slash),
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        color: const Color.fromRGBO(187, 131, 255, 1),
                        onPressed: () {
                          setState(() {
                            readAgainPassword = !readAgainPassword;
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
                  height: 313,
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
                        if (password.length < 8 ||
                            !password.contains(RegExp(r'[a-z]')) ||
                            !password.contains(RegExp(r'[A-Z]')) ||
                            !password.contains(RegExp(r'\d')) ||
                            !password.contains(
                                RegExp(r'[\!\@\#\$\%\^\&\*\(\)\-\_\=\+]')) ||
                            password != repeatPassword) {
                          correctPassword = true;
                        }
                        if (password.length >= 8 &&
                            password.contains(RegExp(r'[a-z]')) &&
                            password.contains(RegExp(r'[A-Z]')) &&
                            password.contains(RegExp(r'\d')) &&
                            password.contains(
                                RegExp(r'[\!\@\#\$\%\^\&\*\(\)\-\_\=\+]')) &&
                            password == repeatPassword) {
                          widget.onPasswordEntered(password);
                          widget.updateActiveStep(widget.activeStep + 1);
                        }
                      });
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
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
