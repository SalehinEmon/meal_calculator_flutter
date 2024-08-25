import 'package:flutter/material.dart';
import 'package:meal_calculator/model/mess_member_model.dart';

class InfoViewItem extends StatefulWidget {
  MessMemberModel messMember;
  double perMealCost;
  Widget? updateWidget;
  Widget? deleteWidget;

  InfoViewItem({
    super.key,
    required this.messMember,
    required this.perMealCost,
    this.updateWidget,
    this.deleteWidget,
  });

  @override
  State<InfoViewItem> createState() => _InfoViewItemState();
}

class _InfoViewItemState extends State<InfoViewItem> {
  @override
  Widget build(BuildContext context) {
    double totalMealCost =
        (widget.messMember.totalMeal ?? 0) * widget.perMealCost;
    double balance = 0;
    if (widget.messMember.totalExpense != null) {
      balance = totalMealCost - widget.messMember.totalExpense!;
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
        top: 5,
        bottom: 5,
      ),
      child: Card(
        elevation: 12,
        color: Colors.white70,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: balance == 0
                ? Colors.lightBlueAccent
                : balance < 0
                    ? Colors.lightGreenAccent
                    : Colors.deepOrangeAccent,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(5),
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(5),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(20),
                  // bottomLeft: Radius.circular(20),
                  // bottomRight: Radius.circular(5),
                ),
              ),
              tileColor: Colors.grey[300],
              dense: true,
              trailing: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: -20,
                children: [
                  // Text('( ${balance.toStringAsFixed(2)})'),
                  widget.deleteWidget ?? const SizedBox(),
                  widget.updateWidget ?? const SizedBox(),
                ],
              ),
              title: Text(
                '${widget.messMember.memberName}(${balance.toStringAsFixed(2)})',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  wordSpacing: 2,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Text(
                        "Total Meal",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.lightBlueAccent,
                    ),
                    Expanded(
                      child: Text(
                        "Total Expense",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    VerticalDivider(
                      color: Colors.lightBlueAccent,
                    ),
                    Expanded(
                      child: Text(
                        "Total Meal Cost",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(
              color: Colors.lightBlueAccent,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    widget.messMember.totalMeal!.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    widget.messMember.totalExpense!.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    totalMealCost.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
