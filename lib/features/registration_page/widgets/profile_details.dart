import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileDetailsWidget extends StatefulWidget {
  final int activeStep;
  final void Function(int newStep) updateActiveStep;

  const ProfileDetailsWidget({
    Key? key,
    required this.activeStep,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<ProfileDetailsWidget> createState() => _ProfileDetailsWidgetState();
}

class _ProfileDetailsWidgetState extends State<ProfileDetailsWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TextEditingController dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    late int activeStep = widget.activeStep;
    final List<String> arr = ['Male', 'Female', 'No gender'];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Enter your profile details',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
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
            ),
            child: const Expanded(
              child: TextField(
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: InputDecoration(
                    hintText: 'Name',
                    hintStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none),
              ),
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
                SvgPicture.asset(
                  'assets/svg/calendar.svg',
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectDate(context),
                    child: AbsorbPointer(
                      child: TextFormField(
                        controller: dateController,
                        cursorColor: Colors.white,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'dd/mm/yyyy',
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/svg/chevron-down.svg',
                ),
                const SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 370,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ...arr.map((button) {
                  return Container(
                    width: 120,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        button,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
          const SizedBox(
            height: 332,
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
                widget.updateActiveStep(activeStep + 1);
              },
              child: Text(
                'Next',
                style: theme.textTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _selectDate(BuildContext context) async {
    DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            primaryColor: const Color.fromRGBO(227, 245, 99, 1),
            dialogBackgroundColor: const Color.fromRGBO(36, 36, 36, 1),
            disabledColor: Colors.grey,
            indicatorColor: const Color.fromRGBO(227, 245, 99, 1),
          ),
          child: child!,
        );
      },
    ))!;

    if (picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }
}
