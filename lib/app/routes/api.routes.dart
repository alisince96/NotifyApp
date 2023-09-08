class ApiRoutes {
  static const String baseurl = 'http://89.116.156.87';
}

class EndPoints {
  EndPoints._();

  static const String baseURL = 'http://89.116.156.87';
  static const String login = '/api/v2/auth/login';
  static const String signUp = '/api/v2/auth/signup';
  static const String categories = '/api/v2/categories';
  static const String homeCategories = '/api/v2/home-categories';
  static const String category = '/api/v2/products/category/{id}';
  static const String subCategories = '/api/v2/sub-categories/2';
  static const String brands = '/api/v2/brands';
  static const String brand = '/api/v2/products/brand/{id}';
  static const String search = '/api/v2/products/search';
  static const String featured = '/api/v2/products/featured';
}
