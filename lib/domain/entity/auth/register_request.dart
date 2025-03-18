/*----------------------------------------------------------------------------*/
/**
 * \file         register_request.dart
 * \brief        Model class for user registration request.
 *               This class is used to serialize and deserialize
 *               registration request data.
 * <p>
 * \platform     Flutter:DART
 * \copyright    Levante Studios 2025
 */
/*----------------------------------------------------------------------------*/

class RegisterRequest {
  final String fullName;
  final String email;
  final String password;
  final String inviteCode;
  final String country;

  RegisterRequest({
    required this.fullName,
    required this.email,
    required this.password,
    required this.inviteCode,
    required this.country,
  });

  /// Converts a JSON map to a `RegisterRequest` instance.
  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      inviteCode: json['inviteCode'] ?? '',
      country: json['country'] ?? '',
    );
  }

  /// Converts a `RegisterRequest` instance to a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'password': password,
      'inviteCode': inviteCode,
      'country': country,
    };
  }
}
