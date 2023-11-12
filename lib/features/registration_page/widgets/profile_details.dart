import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProfileDetailsWidget extends StatefulWidget {
  final int activeStep;
  final void Function(String name, String gender, String date) onProfileDetails;
  final void Function(int newStep) updateActiveStep;

  const ProfileDetailsWidget({
    Key? key,
    required this.onProfileDetails,
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

  var correctName = false;
  var name = '';
  var gender = 'Male';

  @override
  Widget build(BuildContext context) {
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
              border: correctName == true
                  ? Border.all(
                      color: const Color.fromRGBO(235, 87, 87, 1),
                      width: 1,
                    )
                  : null,
            ),
            child: Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    name = value;
                    correctName = false;
                  });
                },
                cursorColor: Colors.white,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                decoration: const InputDecoration(
                  hintText: 'Name',
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
          SizedBox(
            width: 365,
            height: 20,
            child: Row(
              children: [
                if (correctName == true)
                  const Text(
                    'Please fill in the required field',
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
                      color: gender == button
                          ? const Color.fromRGBO(223, 197, 255, 1)
                          : const Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          gender = button;
                        });
                      },
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: gender == button ? Colors.black : Colors.white,
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
                setState(() {
                  if (name.length >= 3 && selectedDate != null) {
                    widget.onProfileDetails(
                      name,
                      gender,
                      selectedDate.toString().substring(0, 10),
                    );
                    widget.updateActiveStep(activeStep + 1);
                  }
                  if (name.length < 3) {
                    correctName = true;
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
