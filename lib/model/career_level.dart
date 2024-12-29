class CareerLevel {
  final int id;
  final String name;

  CareerLevel({required this.id, required this.name});

  factory CareerLevel.fromJson(Map<String, dynamic> json) {
    return CareerLevel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
