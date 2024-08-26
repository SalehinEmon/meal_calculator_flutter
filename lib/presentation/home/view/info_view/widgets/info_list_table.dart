import 'package:flutter/material.dart';
import 'package:meal_calculator/model/mess_member_model.dart';

class InfoListTable extends StatefulWidget {
  List<MessMemberModel> messMemberList;
  double perMealCost;
  Function(int index)? onEditPressed;
  Function(int index)? onDeletePressed;
  Widget updateWidget;
  Widget deleteWidget;

  InfoListTable({
    super.key,
    required this.messMemberList,
    required this.perMealCost,
    required this.updateWidget,
    required this.deleteWidget,
    this.onEditPressed,
    this.onDeletePressed,
  });

  @override
  State<InfoListTable> createState() => _InfoListTableState();
}

class _InfoListTableState extends State<InfoListTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Table(
          // border: TableBorder.all(
          //   color: Colors.white,
          //   width: 1,
          // ),
          //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            TableRow(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  topLeft: Radius.circular(15),
                ),
              ),
              children: [
                headingText('Name'),
                headingText('Balance'),
                headingText('Total meal'),
                headingText('Total Expense'),
                headingText('Actions'),
              ],
            ),
            //for (MessMemberModel messMember in widget.messMemberList)
            for (var i = 0; i < widget.messMemberList.length; i++)
              TableRow(
                decoration: BoxDecoration(
                  borderRadius: i == 0
                      ? const BorderRadius.only(
                          bottomLeft: Radius.circular(15),
                          bottomRight: Radius.circular(15))
                      : BorderRadius.circular(5),
                  color: (i % 2 != 0) ? Colors.transparent : Colors.grey[200],
                ),
                children: [
                  bodyText(
                    widget.messMemberList[i].memberName ?? '',
                    Colors.black,
                  ),
                  bodyText(
                    '${calculateBalance(
                      widget.messMemberList[i].totalMeal,
                      widget.messMemberList[i].totalExpense,
                      widget.perMealCost,
                    )}',
                    chooseBalanceTextCol(
                      widget.messMemberList[i].totalMeal,
                      widget.messMemberList[i].totalExpense,
                      widget.perMealCost,
                    ),
                  ),
                  bodyText('${widget.messMemberList[i].totalMeal ?? 0}',
                      Colors.black),
                  bodyText('${widget.messMemberList[i].totalExpense ?? 0}',
                      Colors.black),
                  Row(
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          widget.onEditPressed!(i);
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          widget.onDeletePressed!(i);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                      widget.updateWidget,
                      widget.deleteWidget,
                    ],
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}

double calculateBalance(
    double? totalMeal, double? totalExpense, double? perMealCost) {
  String tempBalance =
      ((totalExpense ?? 0) - ((perMealCost ?? 0) * (totalMeal ?? 0)))
          .toStringAsFixed(2);

  return double.parse(tempBalance);
}

Color chooseBalanceTextCol(
    double? totalMeal, double? totalExpense, double? perMealCost) {
  double balance = calculateBalance(totalMeal, totalExpense, perMealCost);
  return balance > 0
      ? const Color.fromARGB(255, 43, 110, 45)
      : balance == 0
          ? Colors.blue
          : Colors.red;
}

Widget headingText(String text) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

Widget bodyText(String text, Color textColor) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    ),
  );
}
