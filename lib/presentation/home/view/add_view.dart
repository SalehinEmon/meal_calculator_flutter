import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:meal_calculator/model/mess_member_model.dart';
import 'package:meal_calculator/presentation/home/provider/mess_calculator_provider.dart';
import 'package:meal_calculator/presentation/home/widgets/text_field_components.dart';
import 'package:provider/provider.dart';

class AddView extends StatefulWidget {
  const AddView({super.key});

  @override
  State<AddView> createState() => _AddViewState();
}

class _AddViewState extends State<AddView> {
  TextEditingController memberNameController = TextEditingController();
  TextEditingController totalExpenseController = TextEditingController();
  TextEditingController totalMealController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _clearAllField() {
    memberNameController.clear();
    totalExpenseController.clear();
    totalMealController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MessCalculatorProvider>(
      builder: (BuildContext context,
          MessCalculatorProvider messCalculatorProvider, Widget? child) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Add new Member'),
            ),
            body: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                children: [
                  TextFieldComponents(
                    controller: memberNameController,
                    hintText: "Member Name",
                    lebelText: "Member Name",
                    
                    validator: ValidationBuilder().required().build(),
                  ),
                  TextFieldComponents(
                    controller: totalExpenseController,
                    hintText: "Total Expense",
                    lebelText: "Total Expense",
                    keyboardType: TextInputType.number,
                    validator: ValidationBuilder().required().build(),
                  ),
                  TextFieldComponents(
                    controller: totalMealController,
                    hintText: "Total Meal",
                    lebelText: "Total Meal",
                    keyboardType: TextInputType.number,
                    validator: ValidationBuilder().required().build(),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        messCalculatorProvider.add(
                          MessMemberModel(
                            memberName: memberNameController.text,
                            totalMeal:
                                double.tryParse(totalMealController.text) ?? 0,
                            totalExpense:
                                double.tryParse(totalExpenseController.text) ??
                                    0,
                          ),
                        );
                        _clearAllField();
                      }
                    },
                    child: const Text('Add Member'),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _clearAllField();
                        messCalculatorProvider.removeAll();
                      },
                      child: const Text('Remove All'))
                ],
              ),
            ));
      },
    );
  }
}
