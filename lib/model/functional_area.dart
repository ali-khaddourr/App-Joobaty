class FunctionalArea {
  final int id;
  final String name;

  FunctionalArea({required this.id, required this.name});

  factory FunctionalArea.fromJson(Map<String, dynamic> json) {
    return FunctionalArea(
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
