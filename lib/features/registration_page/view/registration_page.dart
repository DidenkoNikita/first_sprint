import 'package:evently_sprint/features/registration_page/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  int activeStep = 1;

  Map user = {
    'user': {},
    'user_categories': {},
    'user_mood': {},
  };

  void updateActiveStep(int newStep) {
    setState(() {
      activeStep = newStep;
    });
  }

  @override
  Widget build(BuildContext context) {
    const arr = [1, 2, 3, 4, 5, 6];
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(48, 48, 48, 1),
        elevation: 0,
        title: const Text(
          'Sign up',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Image.asset(
              'assets/gif/eyes.gif',
              width: 215,
              height: 84,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: arr.map((item) {
              final isActive = activeStep == item;
              return Row(
                children: [
                  item != 1
                      ? Container(
                          width: 11.24,
                          height: 4,
                          color: isActive || item <= activeStep
                              ? const Color.fromRGBO(227, 245, 99, 1)
                              : const Color.fromRGBO(36, 36, 36, 1),
                        )
                      : Container(),
                  Container(
                    decoration: BoxDecoration(
                      color: isActive || item <= activeStep
                          ? const Color.fromRGBO(227, 245, 99, 1)
                          : const Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 30,
                    height: 30,
                    child: Center(
                      child: Text(
                        item.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: isActive || item <= activeStep
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                  item != 6
                      ? Container(
                          width: 11.24,
                          height: 4,
                          color: isActive || item <= activeStep
                              ? const Color.fromRGBO(227, 245, 99, 1)
                              : const Color.fromRGBO(36, 36, 36, 1),
                        )
                      : Container(),
                ],
              );
            }).toList(),
          ),
          if (activeStep == 1) ...[
            PhoneNumberWidget(
              onPhoneEntered: (String phone) {
                setState(() {
                  user['user']['phone'] = phone;
                });
              },
              activeStep: activeStep,
              updateActiveStep: updateActiveStep,
            ),
          ],
          if (activeStep == 2) ...[
            ProfileDetailsWidget(
              onProfileDetails: (String name, String gender, String date) {
                setState(() {
                  user['user']['name'] = name;
                  user['user']['gender'] = gender;
                  user['user']['date_of_birth'] = date;
                  user['user']['color_theme'] = true;
                });
              },
              activeStep: activeStep,
              updateActiveStep: updateActiveStep,
            ),
          ],
          if (activeStep == 3) ...[
            EnterPasswordWidget(
              activeStep: activeStep,
              onPasswordEntered: (String password) {
                setState(() {
                  user['user']['password'] = password;
                });
              },
              updateActiveStep: updateActiveStep,
            ),
          ],
          if (activeStep == 4) ...[
            ChooseCategoriesWidget(
              activeStep: activeStep,
              onCategoriesChoiced: (Map<String, bool> obj) {
                setState(() {
                  user['user_categories'] = {...obj};
                });
              },
              updateActiveStep: updateActiveStep,
            ),
          ],
          if (activeStep == 5) ...[
            ChooseMoodWidget(
              activeStep: activeStep,
              onMoodChoiced: (Map<String, bool> obj) {
                setState(() {
                  user['user_mood'] = {...obj};
                });
              },
              updateActiveStep: updateActiveStep,
            ),
          ],
          if (activeStep == 6) ...[
            ChooseCityWidget(
              user: user,
              activeStep: activeStep,
              onCityEntered: (String city) {
                setState(() {
                  user['user']['city'] = city;
                });
              },
              updateActiveStep: updateActiveStep,
            ),
          ]
        ],
      ),
    );
  }
}
