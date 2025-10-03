class ApiConstant {
  static const String baseUrl = "http://127.0.0.1:8000/api";
  static const String imageBase = "http://127.0.0.1:8000/";
  static const String login = "$baseUrl/auth/login";
  static const String logout = "$baseUrl/auth/logout";
  static const String refresh = "$baseUrl/auth/refresh";
  static const String branch = "$baseUrl/show_branches_admin";
  static const String request = "$baseUrl/show_main_categories_admin";
  static const String getMeals = "$baseUrl/show_meals_admin";
  static const String getTypesOfMeals = "$baseUrl/show_types_admin";
  static const String make_meal_unavailable = "$baseUrl/make_meal_unavailable";
  static const String make_meal_available = "$baseUrl/make_meal_available";
  static const String show_coupons = "$baseUrl/show_coupons";
  static const String add_coupon = "$baseUrl/add_coupon";
  static const String edit_minOrder = "$baseUrl/edit_min_order";
  static const String edit_percentValue = "$baseUrl/edit_value";
  static const String edit_expires_date = "$baseUrl/edit_expires_at";
  static const String delete_coupon = "$baseUrl/deletecoupon";
  static const String show_all_orders = "$baseUrl/show_all_orders";
  static const String accept_order = "$baseUrl/accept_order";
  static const String show_last_accepted_orders = "$baseUrl/show_last_accepted_orders";
  static const String show_archive_orders = "$baseUrl/show_archive_orders";
}