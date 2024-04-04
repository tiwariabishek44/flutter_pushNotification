class CanteenDataResponse {
  final String userid;
  final String name;
  final String email;
  final String phone;
  final String type;

  CanteenDataResponse({
    required this.userid,
    required this.type,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory CanteenDataResponse.fromJson(Map<String, dynamic> json) {
    return CanteenDataResponse(
      userid:
          json['userid'] ?? '', // Provide a default value if 'userid' is null
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone']?.toString() ??
          '', // Convert to String and provide default value
      type: json['type'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userid': userid,
      'name': name,
      'email': email,
      'phone': phone,
      'type': type,
    };
  }
}
