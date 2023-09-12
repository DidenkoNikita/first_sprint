import 'package:flutter/material.dart';

class ChooseMoodWidget extends StatefulWidget {
  final int activeStep;
  final void Function(int newStep) updateActiveStep;

  const ChooseMoodWidget({
    Key? key,
    required this.activeStep,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<ChooseMoodWidget> createState() => _ChooseCategoriesWidgetState();
}

class _ChooseCategoriesWidgetState extends State<ChooseMoodWidget> {
  Map<String, bool> obj = {
    'funny': false,
    'sad': false,
    'gambling': false,
    'romantic': false,
    'energetic': false,
    'festive': false,
    'calm': false,
    'friendly': false,
    'cognitive': false,
    'dreamy': false,
    'do_not_know': false,
  };

  bool areAllFalse() {
    return !obj.containsValue(true);
  }

  void handleButtonPress(String button) {
    setState(() {
      if (button == "Don't know") {
        for (var key in obj.keys) {
          obj[key] = false;
        }
        obj['do_not_know'] = true;
      } else {
        final key = button.toLowerCase().replaceAll(' ', '_');
        obj[key] = !(obj[key] ?? false);
        obj['do_not_know'] = false;
      }
      debugPrint(obj.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    const List<String> arr = [
      'Funny',
      'Sad',
      'Gambling',
      'Romantic',
      'Energetic',
      'Festive',
      'Calm',
      'Friendly',
      'Cognitive',
      'Dreamy',
      "Don't know",
    ];
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Choose your mood',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: 306,
            child: Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: arr.map((button) {
                  return GestureDetector(
                    onTap: () {
                      handleButtonPress(button);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: obj[button == "Don't know"
                                    ? 'do_not_know'
                                    : button
                                        .toLowerCase()
                                        .replaceAll(' ', '_')] ==
                                true
                            ? const Color.fromRGBO(223, 197, 255, 1)
                            : const Color.fromRGBO(36, 36, 36, 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: obj[button == "Don't know"
                                      ? 'do_not_know'
                                      : button
                                          .toLowerCase()
                                          .replaceAll(' ', '_')] ==
                                  true
                              ? Colors.black
                              : Colors.white,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(
            height: 280,
          ),
          Container(
            width: 365,
            height: 48,
            decoration: BoxDecoration(
              color: areAllFalse()
                  ? const Color.fromRGBO(227, 245, 99, 1)
                  : const Color.fromRGBO(227, 245, 99, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: areAllFalse()
                  ? null
                  : () {
                      widget.updateActiveStep(widget.activeStep + 1);
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
}
