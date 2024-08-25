import 'package:flutter/material.dart';
import 'package:meal_calculator/presentation/home/home_view.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutView extends StatefulWidget {
  const AboutView({super.key});

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'This app is developed by',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w300,
              ),
            ),
            InkWell(
              child: const Text(
                "Golam Salehin",
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                ),
              ),
              onTap: () {
                _launchUrl();
              },
            ),
            TextButton(
              onPressed: () {
                if (mounted) {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) => const HomeView(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                }
              },
              child: const Text(
                "Home",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _launchUrl() async {
    Uri url = Uri.parse('https://bd.linkedin.com/in/salehinemon');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
