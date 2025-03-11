class Scan {
  final int? id;
  final String code;
  final DateTime date; 
  final String description;
  final int userId;

  Scan({
    this.id,
    required this.code,
    required this.date,
    required this.description,
    required this.userId,
  });


  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'date': date.toIso8601String(),
      'description': description,
      'userId': userId,
    };
  }

  factory Scan.fromMap(Map<String, dynamic> map) {
    return Scan(
      id: map['id'],
      code: map['code'],
      date: DateTime.parse(map['date']), 
      description: map['description'],
      userId: map['userId'],
    );
  }
}
