class ApiConstant {
  static const String baseUrl = "http://127.0.0.1:8000/api";
  static const String imageBase = "http://127.0.0.1:8000/";
  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/login";
  static const String logout = "$baseUrl/auth/logout";
  static const String refresh = "$baseUrl/auth/refresh";

  static const String branch = "$baseUrl/show_branches_admin";
  static const String request = "$baseUrl/getmaincategories";
  static const String getMeals = "$baseUrl/getmealsofcategory";
  static const String getTypesOfMeals = "$baseUrl/gettypesofmeal";
}