import 'package:equatable/equatable.dart';

class ForgotPassword extends Equatable {
  final String username;
  final String? email;
  final String? resetToken;
  final DateTime? requestTime;
  final bool isTokenValid;

  const ForgotPassword({
    required this.username,
    this.email,
    this.resetToken,
    this.requestTime,
    this.isTokenValid = false,
  });

  @override
  List<Object?> get props => [username, email, resetToken, requestTime, isTokenValid];

  ForgotPassword copyWith({
    String? username,
    String? email,
    String? resetToken,
    DateTime? requestTime,
    bool? isTokenValid,
  }) {
    return ForgotPassword(
      username: username ?? this.username,
      email: email ?? this.email,
      resetToken: resetToken ?? this.resetToken,
      requestTime: requestTime ?? this.requestTime,
      isTokenValid: isTokenValid ?? this.isTokenValid,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      if (email != null) 'email': email,
      if (resetToken != null) 'resetToken': resetToken,
      if (requestTime != null) 'requestTime': requestTime?.toIso8601String(),
      'isTokenValid': isTokenValid,
    };
  }

  factory ForgotPassword.fromJson(Map<String, dynamic> json) {
    return ForgotPassword(
      username: json['username'] ?? '',
      email: json['email'],
      resetToken: json['resetToken'],
      requestTime: json['requestTime'] != null 
          ? DateTime.parse(json['requestTime']) 
          : null,
      isTokenValid: json['isTokenValid'] ?? false,
    );
  }
} 