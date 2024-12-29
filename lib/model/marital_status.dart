class MaritalStatus {
  final int id;
  final String name;

  MaritalStatus({required this.id, required this.name});

  factory MaritalStatus.fromJson(Map<String, dynamic> json) {
    return MaritalStatus(
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
