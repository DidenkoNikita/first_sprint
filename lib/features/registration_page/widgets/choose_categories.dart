import 'package:flutter/material.dart';

class ChooseCategoriesWidget extends StatefulWidget {
  final int activeStep;
  final void Function(int newStep) updateActiveStep;

  const ChooseCategoriesWidget({
    Key? key,
    required this.activeStep,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<ChooseCategoriesWidget> createState() => _ChooseCategoriesWidgetState();
}

class _ChooseCategoriesWidgetState extends State<ChooseCategoriesWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 14),
                    child: InkWell(
                      onTap: () {},
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
              color: const Color.fromRGBO(227, 245, 99, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                widget.updateActiveStep(widget.activeStep + 1);
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
}
