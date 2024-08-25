import 'package:flutter/material.dart';
import 'package:meal_calculator/presentation/home/view/add_view.dart';
import 'package:meal_calculator/presentation/home/view/info_view/info_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<Widget> widgetList = [
    const InfoPage(),
    const AddView(),
  ];
  List<BottomNavigationBarItem> navigationBarList = [
    const BottomNavigationBarItem(
      label: "Home",
      icon: Icon(Icons.home),
    ),
    const BottomNavigationBarItem(
      label: "Account Balance",
      icon: Icon(Icons.account_balance_wallet),
    ),
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetList[selectedIndex],
      // bottomNavigationBar: BottomNavigationBar(    
      //   currentIndex: selectedIndex,
      //   items: navigationBarList,
      //   onTap: (selectedIndexValue) {
      //     setState(() {
      //       selectedIndex = selectedIndexValue;
      //     });
      //   },
      // ),
    );
  }
}
