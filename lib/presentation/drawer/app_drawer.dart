import 'package:flutter/material.dart';
import 'package:meal_calculator/presentation/about/about.dart';
import 'package:meal_calculator/presentation/delete_all/delete_all.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 50,
              ),
              // ListTile(
              //   tileColor: Colors.grey[200],
              //   leading: const Icon(
              //     Icons.settings,
              //     color: Colors.lightBlueAccent,
              //   ),
              //   title: const Text(
              //     "Settings",
              //     textAlign: TextAlign.center,
              //     style: TextStyle(
              //       fontSize: 20,
              //       fontWeight: FontWeight.w300,
              //       wordSpacing: 2,
              //     ),
              //   ),
              // ),
              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(
                  Icons.delete,
                  color: Colors.lightBlueAccent,
                ),
                title: const Text(
                  "Delete All",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    wordSpacing: 2,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DeleteAll(),
                    ),
                  );
                },
              ),

              ListTile(
                tileColor: Colors.grey[200],
                leading: const Icon(
                  Icons.account_circle,
                  color: Colors.lightBlueAccent,
                ),
                title: const Text(
                  "About",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    wordSpacing: 2,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AboutView(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
