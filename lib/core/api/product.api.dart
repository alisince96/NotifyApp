import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:p_notify/app/routes/api.routes.dart';

class ProductAPI {
  final client = http.Client();
  final headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };
// All The API Related to User Products Present Here
  Future fetchProducts() async {
    const subUrl = '/api/v2/products';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);
    print(ApiRoutes.baseurl + subUrl);
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    print(body);
    return body;
  }

  Future fetchBrands() async {
    final Uri uri = Uri.parse('http://89.116.156.87/api/v2/brands');
    print('http://89.116.156.87/api/v2/brands');
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    print("FetchBrand"+body);
    return body;
  }

  Future fetchFeatured() async {
    final Uri uri = Uri.parse('http://89.116.156.87/api/v2/products/featured');
    print('http://89.116.156.87/api/v2/products/featured');
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    print(body);
    return body;
  }

  Future fetchCategories() async {
    final Uri uri = Uri.parse('http://89.116.156.87/api/v2/categories');
    print('http://89.116.156.87/api/v2/categories');
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    print(body);
    return body;
  }

  Future searchProducts(String text) async {
    final Uri uri =
        Uri.parse('http://89.116.156.87/api/v2/products/search?name=$text');
    print("UriSearc"+uri.toString());
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    print("Search Product"+body);
    return body;
  }

  Future getNotified(String userId, String productId) async {
    final Uri uri = Uri.parse('http://89.116.156.87/api/v1/notified-product');
    print('http://89.116.156.87/api/v1/notified-product');
    final http.Response response = await client.post(uri,
        headers: headers,
        body: jsonEncode({
          "user_id": userId,
          "product_id": productId,
        }));
    final body = response.body;
    print("GetNotified"+body);
    return body;
  }

  Future fetchBrandProducts(String id) async {
    const subUrl = '/api/v2/brands';
    final Uri uri = Uri.parse('http://89.116.156.87/api/v2/products/brand/$id');
    print('http://89.116.156.87/api/v2/products/brand/$id');
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );

    final body = response.body;
    print("FetchBrandProducts"+body);
    return body;
  }

  Future fetchCategoryProducts(String id) async {
    final Uri uri =
        Uri.parse('http://89.116.156.87/api/v2/products/category/$id');
    print('http://89.116.156.87/api/v2/products/category/$id');
    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    print("FetchCategoryProducts"+body);
    return body;
  }

  Future fetchProductDetail({required dynamic id}) async {
    var subUrl = '/api/v2/product/details/$id';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);

    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    return body;
  }

  Future fetchProductCategory({required dynamic categoryName}) async {
    var subUrl = '/product/category/$categoryName';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);

    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    return body;
  }

  Future searchProduct({required dynamic productName}) async {
    var subUrl = '/product/search/$productName';
    final Uri uri = Uri.parse(ApiRoutes.baseurl + subUrl);

    final http.Response response = await client.get(
      uri,
      headers: headers,
    );
    final body = response.body;
    return body;
  }
}
