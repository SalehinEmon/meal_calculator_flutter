class MessMemberModel {
  String? memberName;
  double? totalExpense;
  double? totalMeal;

  MessMemberModel({this.memberName, this.totalExpense, this.totalMeal});

  MessMemberModel.fromJson(Map<String, dynamic> json) {
    memberName = json['memberName'];
    totalExpense = json['totalExpense'];
    totalMeal = json['totalMeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['memberName'] = memberName;
    data['totalExpense'] = totalExpense;
    data['totalMeal'] = totalMeal;
    return data;
  }
}
