/*----------------------------------------------------------------------------*/
/**
 * \file         login_response.dart
 * \brief        Model class for login API response.
 *               Includes token and user details.
 * <p>
 * \platform     Flutter:DART
 * \copyright    Levante Studio 2025
 */
/*----------------------------------------------------------------------------*/

import 'dart:convert';

class LoginResponse {
  final String? token;
  final User? user;

  LoginResponse({ this.token,  this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user': user?.toJson(),
    };
  }

  static LoginResponse fromRawJson(String str) => LoginResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
}

class User {
  final String? id;
  final String? fullName;
  final String? country;
  final String? email;
  final String? inviteCode;
  final bool? isEmailVerified;
  final String? referredBy;
  final bool? isActive;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
     this.id,
     this.fullName,
     this.country,
     this.email,
     this.inviteCode,
     this.isEmailVerified,
    this.referredBy,
     this.isActive,
     this.createdAt,
     this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullName: json['fullName'],
      country: json['country'],
      email: json['email'],
      inviteCode: json['inviteCode'],
      isEmailVerified: json['isEmailVerified'],
      referredBy: json['referredBy'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'country': country,
      'email': email,
      'inviteCode': inviteCode,
      'isEmailVerified': isEmailVerified,
      'referredBy': referredBy,
      'isActive': isActive,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
