class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://mmm.disruptwave.com";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 30000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";
  static const String getOTP = baseUrl + "/api/otp/send";
  static const String verifyOTP = baseUrl + "/api/otp/verify";
  static const String logout = baseUrl + "/api/logout";
  static const String signupPublicUser = baseUrl + "/api/public-user/signup";
  static const String signupLegalProfessionalUser = baseUrl + "/api/legal-professional/signup";
  static const String checkSignUpStatus = baseUrl + "/api/check-signup-completion";
  static const String checkProfileStatus= baseUrl + "/api/check-profile-completion";
}