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
    return ListTile(
      subtitle: Table(
        //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: [
          const TableRow(
            children: [
              Text(
                'Name',
                textAlign: TextAlign.center,
              ),
              Text(
                'Balance',
                textAlign: TextAlign.center,
              ),
              Text(
                'Total meal',
                textAlign: TextAlign.center,
              ),
              Text(
                'Total Expense',
                textAlign: TextAlign.center,
              ),
              Text(
                'Actions',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          //for (MessMemberModel messMember in widget.messMemberList)
          for (var i = 0; i < widget.messMemberList.length; i++)
            TableRow(
              decoration: BoxDecoration(
                color: calculateBalance(
                            widget.messMemberList[i].totalMeal,
                            widget.messMemberList[i].totalExpense,
                            widget.perMealCost) <
                        0
                    ? Colors.red.withOpacity(0.5)
                    : Colors.lime.withOpacity(.5),
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
              children: [
                Text(widget.messMemberList[i].memberName ?? ''),
                Text(
                  '${calculateBalance(widget.messMemberList[i].totalMeal, widget.messMemberList[i].totalExpense, widget.perMealCost)}',
                ),
                Text(
                  '${widget.messMemberList[i].totalMeal ?? 0}',
                  textAlign: TextAlign.center,
                ),
                Text(
                  '${widget.messMemberList[i].totalExpense ?? 0}',
                  textAlign: TextAlign.center,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        widget.onEditPressed!(i);
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
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
