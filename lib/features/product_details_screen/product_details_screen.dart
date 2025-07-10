import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:smbs_machine_test/core/costants/color_constants.dart';
import 'package:smbs_machine_test/features/product_details_screen/buy_product_service.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_details_model.dart';
import 'package:smbs_machine_test/shared/alerts/snackbar.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductDetailsModel product;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Product Details',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: ColorConstants.primary,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width * .8,
                        height: 300,
                        child: Image.network(widget.product.image ?? ''),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.product.title ?? '',
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\u20B9 ${widget.product.price ?? 0}',
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      widget.product.description ?? '',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              log('clicked');
              Razorpay? razorpay = await Provider.of<BuyProductService>(
                context,
                listen: false,
              ).buyProduct(
                amount: widget.product.price ?? 0,
                title: widget.product.title ?? '',
              );
              razorpay?.on(
                Razorpay.EVENT_PAYMENT_ERROR,
                handlePaymentErrorResponse,
              );
              razorpay?.on(
                Razorpay.EVENT_PAYMENT_SUCCESS,
                handlePaymentSuccessResponse,
              );
              razorpay?.on(
                Razorpay.EVENT_EXTERNAL_WALLET,
                handleExternalWalletSelected,
              );
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * .9,
              height: 50,
              decoration: BoxDecoration(
                color: ColorConstants.primary,
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                "Buy Now",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ColorConstants.scaffoldBackground,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    showSnackBar(
      scaffoldMessenger: scaffoldMessenger,
      content: 'Payment failed',
      backgroundColor: ColorConstants.errorColor,
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    showSnackBar(
      scaffoldMessenger: scaffoldMessenger,
      content: 'Payment successful',
      backgroundColor: ColorConstants.successColor,
    );
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    showSnackBar(
      scaffoldMessenger: scaffoldMessenger,
      content: 'External Wallet Selected- ${response.walletName}',
      backgroundColor: ColorConstants.blurColor,
    );
  }
}
