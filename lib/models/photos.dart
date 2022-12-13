class Photos {
  final int id;
  final String firstName;
  final String middleName;
  final String lastName;

  const Photos({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
  });
  factory Photos.fromJson(Map<String, dynamic> json) {
    return Photos(
      id: json['id'],
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
    );
  }
}
