import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:smbs_machine_test/core/services/api_services.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_details_model.dart';

class ProductServices with ChangeNotifier {
  final Dio dio = ApiServices.getInstance();
  List<ProductDetailsModel> productsList = [];

  getAllProductsDetails() async {
    final String url = 'https://fakestoreapi.com/products';
    try {
      var response = await dio.get(url);
      final decodedData = jsonDecode(response.data);
      productsList =
          (decodedData as List)
              .map((products) => ProductDetailsModel.fromJson(products))
              .toList();
      log('product list: $productsList');
    } on Exception catch (e) {
      log('Error: $e');
    }
    notifyListeners();
  }
}
