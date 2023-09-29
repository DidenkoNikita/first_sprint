import 'package:evently_sprint/requests/registration/registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChooseCityWidget extends StatefulWidget {
  final int activeStep;
  final void Function(int newStep) updateActiveStep;
  final void Function(String city) onCityEntered;
  final Map user;

  const ChooseCityWidget({
    Key? key,
    required this.user,
    required this.activeStep,
    required this.onCityEntered,
    required this.updateActiveStep,
  }) : super(key: key);

  @override
  State<ChooseCityWidget> createState() => _ChooseCategoriesWidgetState();
}

class _ChooseCategoriesWidgetState extends State<ChooseCityWidget> {
  String? selectedCity;
  TextEditingController searchController = TextEditingController();
  List<String> filteredCities = [];
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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
    if (filteredCities.isEmpty) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: 525,
          decoration: const BoxDecoration(
            color: Color.fromRGBO(36, 36, 36, 1),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            children: filteredCities.map((city) {
              return ListTile(
                title: Text(
                  city,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedCity = city;
                    searchController.text = city;
                    filteredCities = [];
                    Navigator.pop(context);
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
          Container(
            width: 365,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(36, 36, 36, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/city.svg',
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white,
                        ),
                        controller: searchController,
                        onTap: () {
                          _showModalBottomSheet(context);
                        },
                        onChanged: filterCities,
                        decoration: const InputDecoration(
                          hintText: 'City',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/chevron-down.svg',
                    ),
                  ],
                ),
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
                      color: selectedCity == button
                          ? const Color.fromRGBO(223, 197, 255, 1)
                          : const Color.fromRGBO(36, 36, 36, 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          selectedCity = button;
                          searchController.text = selectedCity!;
                        });
                      },
                      child: Text(
                        button,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: selectedCity == button
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
            height: 242,
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
                setState(() async {
                  if (selectedCity != null) {
                    widget.onCityEntered(selectedCity.toString());
                    if (widget.user['user']['city'] != '') {
                      await Registration(
                              user: widget.user, navigatorKey: navigatorKey)
                          .registration();
                    }
                  }
                });
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
