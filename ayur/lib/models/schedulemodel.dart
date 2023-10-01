class Schedule {
  DateTime datetime;
  String description;
  int id;
  String medicineName;

  Schedule({
    required this.datetime,
    required this.description,
    required this.id,
    required this.medicineName,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      datetime: DateTime.parse(json['datetime']),
      description: json['description'],
      id: json['id'],
      medicineName: json['medicine_name'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['datetime'] = this.datetime.toIso8601String();
    data['description'] = this.description;
    data['id'] = this.id;
    data['medicine_name'] = this.medicineName;
    return data;
  }
}
