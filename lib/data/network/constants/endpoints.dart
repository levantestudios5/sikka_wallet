class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://server.sikkax.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String register = baseUrl + "/auth/register";
  static const String loginUser = baseUrl + "/auth/login";
  static const String getPosts = baseUrl + "/news";
  static const String getLeaderBoard = baseUrl + "/leaderboard";
  static const String getOTP = baseUrl + "/api/otp/send";
  static const String verifyOTP = baseUrl + "/api/otp/verify";
  static const String logout = baseUrl + "/api/logout";

}