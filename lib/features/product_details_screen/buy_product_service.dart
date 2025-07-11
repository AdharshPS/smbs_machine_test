import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_details_model.dart';

class BuyProductService with ChangeNotifier {
  Future<Razorpay?> buyProduct({
    required double amount,
    required String title,
  }) async {
    try {
      Razorpay razorpay = Razorpay();
      var options = {
        'key': 'rzp_test_BwXpgPiQ3we4I5',
        'amount': amount * 100,
        'name': title,
        // 'description': widget.product.description,
        'retry': {'enabled': true, 'max_count': 5},
        'send_sms_hash': true,
        'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      };
      razorpay.open(options);
      notifyListeners();
      return razorpay;
    } on Exception catch (e) {
      log('Error: $e');
      return null;
    }
  }

  Future<void> addToBoughtProducts({
    required ProductDetailsModel product,
  }) async {
    var box = await Hive.openBox('boughtProducts');
    List<ProductDetailsModel> existingList =
        box
            .get('bought_products', defaultValue: [])!
            .cast<ProductDetailsModel>();
    log('bought products list: $existingList');
    existingList.add(product);
    box.put('bought_products', existingList);
    log('bought products list: $existingList');
    List<ProductDetailsModel> hel = await getBoughtProducts();
    log('hel: $hel');
    notifyListeners();
  }

  Future<List<ProductDetailsModel>> getBoughtProducts() async {
    var box = await Hive.openBox('boughtProducts');
    notifyListeners();
    return box
        .get('bought_products', defaultValue: [])!
        .cast<ProductDetailsModel>();
  }
}
