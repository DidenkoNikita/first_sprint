// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeFooter extends StatelessWidget {
  const HomeFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> arr = [
      {
        'icon': 'assets/svg/home.svg',
        'label': 'Home',
        'link': '/',
      },
      {
        'icon': 'assets/svg/services.svg',
        'label': 'Services',
        'link': '/services',
      },
      {
        'icon': 'assets/svg/clips.svg',
        'label': 'Clips',
        'link': '/clips',
      },
      {
        'icon': 'assets/svg/chats.svg',
        'label': 'Chats',
        'link': '/chats',
      },
      {
        'icon': 'assets/svg/profile.svg',
        'label': 'Profile',
        'link': '/profile',
      },
    ];
    String? currentRoute = ModalRoute.of(context)!.settings.name;

    return Container(
      height: 74,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(26, 26, 26, 1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: arr.map((item) {
          return Container(
            width: 75,
            height: 56,
            decoration: BoxDecoration(
              color: currentRoute == item['link'] ||
                      (currentRoute == '/profile_settings' &&
                          item['link'] == '/profile')
                  ? const Color.fromRGBO(227, 245, 99, 1)
                  : const Color.fromRGBO(26, 26, 26, 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed(item['link']);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    item['icon'],
                    color: currentRoute == item['link'] ||
                            (currentRoute == '/profile_settings' &&
                                item['link'] == '/profile')
                        ? Colors.black
                        : Colors.white,
                  ),
                  Text(
                    item['label'],
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: currentRoute == item['link'] ||
                              (currentRoute == '/profile_settings' &&
                                  item['link'] == '/profile')
                          ? Colors.black
                          : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
