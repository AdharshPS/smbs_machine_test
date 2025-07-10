import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
}
