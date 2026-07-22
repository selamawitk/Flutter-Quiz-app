import 'package:equatable/equatable.dart';

class AnswerSecurity extends Equatable {
  final String username;
  final String securityQuestion;
  final String securityAnswer;
  final bool isVerified;
  final String? verificationToken;

  const AnswerSecurity({
    required this.username,
    required this.securityQuestion,
    required this.securityAnswer,
    this.isVerified = false,
    this.verificationToken,
  });

  @override
  List<Object?> get props => [
    username, 
    securityQuestion, 
    securityAnswer, 
    isVerified, 
    verificationToken
  ];

  AnswerSecurity copyWith({
    String? username,
    String? securityQuestion,
    String? securityAnswer,
    bool? isVerified,
    String? verificationToken,
  }) {
    return AnswerSecurity(
      username: username ?? this.username,
      securityQuestion: securityQuestion ?? this.securityQuestion,
      securityAnswer: securityAnswer ?? this.securityAnswer,
      isVerified: isVerified ?? this.isVerified,
      verificationToken: verificationToken ?? this.verificationToken,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'securityQuestion': securityQuestion,
      'securityAnswer': securityAnswer,
      'isVerified': isVerified,
      if (verificationToken != null) 'verificationToken': verificationToken,
    };
  }

  factory AnswerSecurity.fromJson(Map<String, dynamic> json) {
    return AnswerSecurity(
      username: json['username'] ?? '',
      securityQuestion: json['securityQuestion'] ?? '',
      securityAnswer: json['securityAnswer'] ?? '',
      isVerified: json['isVerified'] ?? false,
      verificationToken: json['verificationToken'],
    );
  }
} 