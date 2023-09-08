import 'package:flutter/material.dart';

class ChooseCityWidget extends StatefulWidget {
  final int activeStep;
  final void Function(int newStep) updateActiveStep;

  const ChooseCityWidget({
    Key? key,
    required this.activeStep,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<ChooseCityWidget> createState() => _ChooseCategoriesWidgetState();
}

class _ChooseCategoriesWidgetState extends State<ChooseCityWidget> {
  String? selectedCity;
  TextEditingController searchController = TextEditingController();
  List<String> filteredCities = [];

  final List<String> arr = [
    'Saint Petersburg',
    'Moscow',
    'Kazan',
    'Kemerovo',
    'Barnaul',
    'Arkhangelsk',
    'Astrakhan',
    'Rostov-on-Don',
    'Belgorod',
  ];
  List<String> russianCities = [
    'Anapa',
    'Arkhangelsk',
    'Armavir',
    'Astrakhan',
    'Balakovo',
    'Balashikha',
    'Barnaul',
    'Bataisk',
    'Belgorod',
    'Berezniki',
    'Bryansk',
    'Cheboksary',
    'Chelyabinsk',
    'Chita',
    'Dzerzhinsk',
    'Elektrostal',
    'Engels',
    'Irkutsk',
    'Ivanovo',
    'Izhevsk',
    'Kaliningrad',
    'Kaluga',
    'Kalisz',
    'Kazan',
    'Kemerovo',
    'Khabarovsk',
    'Khimki',
    'Kirov',
    'Komsomolsk-on-Amur',
    'Kostroma',
    'Krasnodar',
    'Krasnoyarsk',
    'Kurgan',
    'Kursk',
    'Kyzyl',
    'Lipetsk',
    'Lyubertsy',
    'Magnitogorsk',
    'Mahachkala',
    'Maykop',
    'Miass',
    'Moscow',
    'Mytishchi',
    'Naberezhnye Chelny',
    'Nizhnekamsk',
    'Nizhnevartovsk',
    'Nizhny Novgorod',
    'Nizhny Tagil',
    'Noginsk',
    'Novocherkassk',
    'Novokuznetsk',
    'Novorossiysk',
    'Novosibirsk',
    'Obninsk',
    'Omsk',
    'Orenburg',
    'Penza',
    'Perm',
    'Podolsk',
    'Prokopyevsk',
    'Rubtsovsk',
    'Rostov-on-Don',
    'Ryazan',
    'Saint Petersburg',
    'Samara',
    'Saransk',
    'Saratov',
    'Severodvinsk',
    'Shakhty',
    'Sizran',
    'Smolensk',
    'Sarapul',
    'Sterlitamak',
    'Surgut',
    'Syktyvkar',
    'Taganrog',
    'Tambov',
    'Tolyatti',
    'Tomsk',
    'Tyumen',
    'Ufa',
    'Ulan-Ude',
    'Ulyanovsk',
    'Vladikavkaz',
    'Vladimir',
    'Vladivostok',
    'Volgograd',
    'Volzhsky',
    'Voronezh',
    'Yaroslavl',
    'Yekaterinburg',
    'Yoshkar-Ola',
    'Yuzhno-Sakhalinsk',
  ];

  @override
  void initState() {
    super.initState();
    filteredCities = russianCities;
  }

  void filterCities(String query) {
    setState(() {
      filteredCities = russianCities
          .where((city) => city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Column(
            children: filteredCities.map((city) {
              return ListTile(
                title: Text(city),
                onTap: () {
                  setState(() {
                    selectedCity = city;
                    searchController.text = city;
                    filteredCities = [];
                    Navigator.pop(context); // Закрыть модальное окно
                  });
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 40,
          ),
          const Text(
            'Choose a city',
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
            child: Column(
              children: [
                TextField(
                  controller: searchController,
                  onTap: () {
                    _showModalBottomSheet(context);
                  },
                  onChanged: filterCities,
                  decoration: const InputDecoration(
                    labelText: 'Search City',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 306,
            child: Center(
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                alignment: WrapAlignment.center,
                children: arr.map((button) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
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
            height: 200,
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
