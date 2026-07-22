class PasswordReset {
  final String username;
  final String newPassword;
  final Map<String, String> securityAnswers;

  PasswordReset({
    required this.username,
    required this.newPassword,
    required this.securityAnswers,
  });
} 