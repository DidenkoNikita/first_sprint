import 'package:flutter/material.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 10),
              child: Image.asset('assets/png/logo.png'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Text(
                'evently',
                style: theme.textTheme.bodyMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 30, 0, 40),
              child: Text(
                'Don’t have an account?',
                style: theme.textTheme.bodySmall,
              ),
            ),
            Container(
              width: 365,
              height: 48,
              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(227, 245, 99, 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/registration');
                },
                child: Text(
                  'Create personal account',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                width: 365,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(227, 245, 99, 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Create brand account',
                    style: theme.textTheme.titleSmall,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 72, 10, 0),
                  child: Text(
                    'Already have the account?',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 72, 0, 0),
                  child: InkWell(
                    child: const Text(
                      'Log in',
                      style: TextStyle(
                        color: Color.fromRGBO(187, 131, 255, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed('/login');
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
