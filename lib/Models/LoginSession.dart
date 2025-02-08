class LoginSession {
  String authToken;
  List<String> audioQuality;
  int maxSession;

  LoginSession({
    required this.authToken,
    required this.audioQuality,
    required this.maxSession
  });
}