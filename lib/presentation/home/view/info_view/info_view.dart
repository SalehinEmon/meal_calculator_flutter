import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:meal_calculator/model/mess_member_model.dart';
import 'package:meal_calculator/presentation/home/provider/mess_calculator_provider.dart';
import 'package:meal_calculator/presentation/drawer/app_drawer.dart';
import 'package:meal_calculator/presentation/home/view/info_view/widgets/info_list_table.dart';
import 'package:meal_calculator/presentation/home/widgets/text_field_components.dart';
import 'package:meal_calculator/presentation/home/view/info_view/widgets/info_list_item.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextStyle textStyle = const TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    Size pageSize = MediaQuery.of(context).size;
    return Consumer<MessCalculatorProvider>(
      builder: (BuildContext context,
          MessCalculatorProvider messCalculatorProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            title: const Text('Meal Calculator'),
          ),
          drawer: const AppDrawer(),
          // appBar: AppBar(
          //   title: const Text('Information Page'),
          // ),
          body: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: pageSize.width,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Stack(
                      // alignment: Alignment.topCenter,
                      //mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            backgroundColor: Colors.lightBlueAccent,
                            radius: 60,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  messCalculatorProvider
                                      .perMealCost()
                                      .toStringAsFixed(2),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Text(
                                  "Per Meal",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.lightBlueAccent,
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                color: Colors.white,
                                onPressed: () {
                                  addDialogWindow(
                                      context, messCalculatorProvider);
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.lightBlueAccent,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Totla Meal',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${messCalculatorProvider.totalMeal()}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const VerticalDivider(
                        color: Colors.lightBlueAccent,
                      ),
                      Column(
                        children: [
                          const Text(
                            'Total expense',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '${messCalculatorProvider.totalExpense()}',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const Divider(
                color: Colors.lightBlueAccent,
              ),
              messCalculatorProvider.waitFlag
                  ? generateWaitingLoader()
                  : messCalculatorProvider.length == 0
                      ? const Text("No data found")
                      : ListView(
                          shrinkWrap: true,
                          children: [
                            InfoListTable(
                              messMemberList: messCalculatorProvider.allMember,
                              perMealCost: messCalculatorProvider.perMealCost(),
                              updateWidget: const SizedBox(),
                              deleteWidget: const SizedBox(),
                              onEditPressed: (index) {
                                updateDialogWindow(
                                    context, messCalculatorProvider, index);
                              },
                              onDeletePressed: (index) {
                                deleteDialog(
                                    context, index, messCalculatorProvider);
                              },
                            ),
                          ],
                        ),
            ],
          ),
        );
      },
    );
  }

  generateWaitingLoader() {
    return const SizedBox(
      height: 50,
      child: LinearProgressIndicator(
        color: Colors.lightBlueAccent,
      ),
    );
  }

  updateDialogWindow(
      BuildContext context, MessCalculatorProvider messProvider, int index) {
    MessMemberModel messMember = messProvider.allMember[index];
    TextEditingController memberName =
        TextEditingController(text: messMember.memberName ?? '');
    TextEditingController totalExpense =
        TextEditingController(text: '${messMember.totalExpense ?? 0}');
    TextEditingController totalMeal =
        TextEditingController(text: '${messMember.totalMeal ?? 0}');
    GlobalKey<FormState> localFormKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              title: const Text("Update"),
              content: Form(
                key: localFormKey,
                child: Wrap(
                  children: [
                    TextFieldComponents(
                      controller: memberName,
                      hintText: "Name",
                      lebelText: 'Name',
                      validator:
                          ValidationBuilder(requiredMessage: "Name Required")
                              .required()
                              .build(),
                    ),
                    TextFieldComponents(
                      controller: totalExpense,
                      hintText: "Total Expense",
                      lebelText: 'Total expense',
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder(
                              requiredMessage: "Total Expense Required")
                          .required()
                          .build(),
                    ),
                    TextFieldComponents(
                      controller: totalMeal,
                      hintText: "Total Meal",
                      lebelText: 'Total Meal',
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder(
                              requiredMessage: "Total Meal Required")
                          .required()
                          .build(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Update'),
                  onPressed: () {
                    if (localFormKey.currentState!.validate()) {
                      messProvider.updateAt(
                        index,
                        MessMemberModel(
                          memberName: memberName.text,
                          totalExpense: double.parse(totalExpense.text ?? '0'),
                          totalMeal: double.parse(totalMeal.text ?? '0'),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ]);
        });
  }

  addDialogWindow(BuildContext context, MessCalculatorProvider messProvider) {
    TextEditingController memberName = TextEditingController();
    TextEditingController totalExpense = TextEditingController();
    TextEditingController totalMeal = TextEditingController();
    GlobalKey<FormState> localFormKey = GlobalKey<FormState>();
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              title: const Text("Add New"),
              content: Form(
                key: localFormKey,
                child: Wrap(
                  children: [
                    TextFieldComponents(
                      controller: memberName,
                      hintText: "Name",
                      lebelText: 'Name',
                      validator:
                          ValidationBuilder(requiredMessage: "Name Required")
                              .required()
                              .build(),
                    ),
                    TextFieldComponents(
                      controller: totalExpense,
                      hintText: "Total Expense",
                      lebelText: 'Total expense',
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder(
                              requiredMessage: "Total Expense Required")
                          .required()
                          .build(),
                    ),
                    TextFieldComponents(
                      controller: totalMeal,
                      hintText: "Total Meal",
                      lebelText: 'Total Meal',
                      keyboardType: TextInputType.number,
                      validator: ValidationBuilder(
                              requiredMessage: "Total Meal Required")
                          .required()
                          .build(),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Add'),
                  onPressed: () {
                    if (localFormKey.currentState!.validate()) {
                      messProvider.add(
                        MessMemberModel(
                          memberName: memberName.text,
                          totalExpense: double.parse(totalExpense.text ?? '0'),
                          totalMeal: double.parse(totalMeal.text ?? '0'),
                        ),
                      );
                      Navigator.of(context).pop();
                    }
                  },
                ),
              ]);
        });
  }

  deleteDialog(
      BuildContext context, int index, MessCalculatorProvider messProvider) {
    MessMemberModel messMember = messProvider.allMember[index];
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
              title: const Text("Remove"),
              content: Wrap(
                children: [
                  Text('Want to delete ${messMember.memberName}?'),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text('Close'),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                TextButton(
                  child: const Text('Delete'),
                  onPressed: () {
                    messProvider.removeAt(index);
                    Navigator.of(context).pop();
                  },
                ),
              ]);
        });
  }
}
