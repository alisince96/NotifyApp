import 'dart:convert';
import 'dart:io';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:p_notify/app/constants/app.keys.dart';
import 'package:p_notify/core/api/product.api.dart';
import 'package:p_notify/core/models/brand_model.dart';
import 'package:p_notify/core/models/category_model.dart';
import 'package:p_notify/core/models/prod_model.dart';
import 'package:p_notify/core/models/productID.model.dart';
import 'package:p_notify/core/models/product.model.dart';
import 'package:p_notify/core/models/single_prod.dart';
import 'package:p_notify/core/notifiers/authentication.notifer.dart';
import 'package:p_notify/core/notifiers/user.notifier.dart';
import 'package:p_notify/core/utils/snackbar.util.dart';
import 'package:provider/provider.dart';

class ProductNotifier with ChangeNotifier {
  List<Data> brands = [];
  List<Data> featured = [];
  List<CategoryData> categories = [];
  List<ProdData> selectedBrandProds = [];
  bool fetchBrandsLoading = false;
  List<ProdData> searchedProducts = [];

  final ProductAPI _productAPI = ProductAPI();
  // this function is used on the product screen to fetch all the brands
  Future fetchBrands({required BuildContext context}) async {
    try {
      var products = await _productAPI.fetchBrands();
      var response = BrandModel.fromJson(jsonDecode(products));

      brands = response.data ?? [];
      notifyListeners();
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }

  // this function is used on the product screen to fetch all the Featured Brands
  Future fetchFeatured({required BuildContext context}) async {
    try {
      var products = await _productAPI.fetchFeatured();
      var response = BrandModel.fromJson(jsonDecode(products));

      featured = response.data ?? [];
      notifyListeners();
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }

  // this function is used on the product screen to fetch all the Categories
  Future fetchCategories({required BuildContext context}) async {
    try {
      var products = await _productAPI.fetchCategories();
      var response = CategoryModel.fromJson(jsonDecode(products));

      categories = response.data ?? [];
      notifyListeners();
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }

  // this function is used to notify for the Sale
  Future getNotified(
      {required BuildContext context, required String productId}) async {
    try {
      print(
          'userid: ${Provider.of<AuthenticationNotifier>(context, listen: false).userId}');
      print('productId: $productId');
      await _productAPI.getNotified(
          Provider.of<AuthenticationNotifier>(context, listen: false).userId ??
              '',
          productId);

      notifyListeners();
    } on SocketException catch (_) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
      //     text: 'Oops No You Need A Good Internet Connection',
      //     context: context));
    }
  }

  // this function is used to Show the brands Item
  Future fetchBrandProducts({required String id}) async {
    try {
      fetchBrandsLoading = true;
      var products = await _productAPI.fetchBrandProducts(id);
      var response = SingleProd.fromJson(jsonDecode(products));
      selectedBrandProds = response.data ?? [];
      fetchBrandsLoading = false;
      notifyListeners();
    } on SocketException catch (_) {
      fetchBrandsLoading = false;
      // ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
      //     text: 'Oops No You Need A Good Internet Connection',
      //     context: context));
    }
  }

// this function is used to Show the Category Item
  Future fetchCategoryProducts({required String id}) async {
    try {
      fetchBrandsLoading = true;
      var products = await _productAPI.fetchCategoryProducts(id);
      var response = SingleProd.fromJson(jsonDecode(products));
      selectedBrandProds = response.data ?? [];
      fetchBrandsLoading = false;
      notifyListeners();
    } on SocketException catch (_) {
      fetchBrandsLoading = false;
      // ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
      //     text: 'Oops No You Need A Good Internet Connection',
      //     context: context));
    }
  }

// this function is used to Show the Products Item
  Future fetchProducts({required BuildContext context}) async {
    try {
      var products = await _productAPI.fetchProducts();
      var response = ProductModel.fromJson(jsonDecode(products));

      final _productBody = response.data;

      // final _productFilled = response.filled;
      // final _productReceived = response.received;

      // if (_productReceived && _productFilled) {
      //   return _productBody;
      // } else if (!_productFilled && _productReceived) {
      //   return [];
      // }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }

// this function is used to Show Search Items
  Future searchProducts({required String text}) async {
    try {
      var products = await _productAPI.searchProducts(text);
      var response = ProdModel.fromJson(jsonDecode(products));

      searchedProducts = response.data ?? [];
      notifyListeners();

      // final _productFilled = response.filled;
      // final _productReceived = response.received;

      // if (_productReceived && _productFilled) {
      //   return _productBody;
      // } else if (!_productFilled && _productReceived) {
      //   return [];
      // }
    } on SocketException catch (_) {}
  }

// this function is used to Show the Product Details
  Future fetchProductDetail(
      {required BuildContext context, required dynamic id}) async {
    try {
      var products = await _productAPI.fetchProductDetail(id: id);
      var response = ProductIdModel.fromJson(jsonDecode(products));

      final _productBody = response.data;
      final _productFilled = response.filled;
      final _productReceived = response.received;

      if (_productReceived && _productFilled) {
        return _productBody;
      } else if (!_productFilled && _productReceived) {
        return [];
      }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackUtil.stylishSnackBar(
            text: 'Oops No You Need A Good Internet Connection',
            context: context),
      );
    }
  }

  Future fetchProductCategory(
      {required BuildContext context, required dynamic categoryName}) async {
    try {
      var products =
          await _productAPI.fetchProductCategory(categoryName: categoryName);
      var response = ProductModel.fromJson(jsonDecode(products));

      final _productBody = response.data;
      // final _productFilled = response.filled;
      // final _productReceived = response.received;

      // if (_productReceived && _productFilled) {
      //   return _productBody;
      // } else if (!_productFilled && _productReceived) {
      //   return [];
      // }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }

  Future searchProduct(
      {required BuildContext context, required dynamic productName}) async {
    try {
      var products = await _productAPI.searchProduct(productName: productName);
      var response = ProductModel.fromJson(jsonDecode(products));

      final _productBody = response.data;
      // final _productFilled = response.filled;
      // final _productReceived = response.received;

      // if (_productReceived && _productFilled) {
      //   return _productBody;
      // } else if (!_productFilled && _productReceived) {
      //   return [];
      // }
    } on SocketException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackUtil.stylishSnackBar(
          text: 'Oops No You Need A Good Internet Connection',
          context: context));
    }
  }
}
