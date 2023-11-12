import 'package:flutter/material.dart';

class ChooseCategoriesWidget extends StatefulWidget {
  final int activeStep;
  final void Function(int newStep) updateActiveStep;
  final void Function(Map<String, bool> obj) onCategoriesChoiced;

  const ChooseCategoriesWidget({
    Key? key,
    required this.activeStep,
    required this.onCategoriesChoiced,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<ChooseCategoriesWidget> createState() => _ChooseCategoriesWidgetState();
}

class _ChooseCategoriesWidgetState extends State<ChooseCategoriesWidget> {
  Map<String, bool> obj = {
    'restaurants': false,
    'trade_fairs': false,
    'lectures': false,
    'cafe': false,
    'bars': false,
    'sport': false,
    'dancing': false,
    'games': false,
    'quests': false,
    'concerts': false,
    'parties': false,
    'show': false,
    'for_free': false,
    'cinema': false,
    'theaters': false,
  };

  bool areAllFalse() {
    return !obj.containsValue(true);
  }

  @override
  Widget build(BuildContext context) {
    const List<String> arr = [
      'Restaurants',
      'Trade fairs',
      'Lectures',
      'Cafe',
      'Bars',
      'Sport',
      'Dancing',
      'Games',
      'Quests',
      'Concerts',
      'Parties',
      'Show',
      'For free',
      'Cinema',
      'Theaters',
    ];

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Choose categories',
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
                      setState(() {
                        final key = button.toLowerCase().replaceAll(' ', '_');
                        obj[key] = !(obj[key] ?? false);
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: obj[button.toLowerCase().replaceAll(' ', '_')] ==
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
                          color:
                              obj[button.toLowerCase().replaceAll(' ', '_')] ==
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
            height: 216,
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
                      widget.onCategoriesChoiced(obj);
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
