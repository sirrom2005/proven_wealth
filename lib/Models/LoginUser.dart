class LoginUser {
  final int id;
  final String authToken;
  final String email;
  final String lastLogin;
  final String name;
  final List<String> audioQuality;
  final String message;
  int maxSession;

  LoginUser({
    required this.id,
    required this.authToken,
    required this.email,
    required this.lastLogin,
    required this.name,
    required this.audioQuality,
    required this.message,
    this.maxSession = 0
  });
}