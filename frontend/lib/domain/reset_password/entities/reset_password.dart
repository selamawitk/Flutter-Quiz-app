import 'package:equatable/equatable.dart';

class ResetPassword extends Equatable {
  final String username;
  final String newPassword;
  final String confirmPassword;
  final String? token;

  const ResetPassword({
    required this.username,
    required this.newPassword,
    required this.confirmPassword,
    this.token,
  });

  @override
  List<Object?> get props => [username, newPassword, confirmPassword, token];

  ResetPassword copyWith({
    String? username,
    String? newPassword,
    String? confirmPassword,
    String? token,
  }) {
    return ResetPassword(
      username: username ?? this.username,
      newPassword: newPassword ?? this.newPassword,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
      if (token != null) 'token': token,
    };
  }

  factory ResetPassword.fromJson(Map<String, dynamic> json) {
    return ResetPassword(
      username: json['username'] ?? '',
      newPassword: json['newPassword'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
      token: json['token'],
    );
  }
} 