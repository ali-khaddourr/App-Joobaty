class JobExperience {
  final int id;
  final String name;

  JobExperience({required this.id, required this.name});

  factory JobExperience.fromJson(Map<String, dynamic> json) {
    return JobExperience(
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
