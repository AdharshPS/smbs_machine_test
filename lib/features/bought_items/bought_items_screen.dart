import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smbs_machine_test/core/costants/color_constants.dart';
import 'package:smbs_machine_test/features/product_details_screen/buy_product_service.dart';
import 'package:smbs_machine_test/features/product_details_screen/product_details_screen.dart';
import 'package:smbs_machine_test/features/product_list_screen/product_details_model.dart';
import 'package:smbs_machine_test/main.dart';

class BoughtItemsScreen extends StatefulWidget {
  const BoughtItemsScreen({super.key});

  @override
  State<BoughtItemsScreen> createState() => _BoughtItemsScreenState();
}

class _BoughtItemsScreenState extends State<BoughtItemsScreen> {
  List<ProductDetailsModel> boughtProductsList = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      boughtProductsList =
          await Provider.of<BuyProductService>(
            context,
            listen: false,
          ).getBoughtProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<BuyProductService>(
        builder: (context, productProvider, child) {
          return boughtProductsList.length == 0
              ? Center(
                child: Text(
                  'No items purchased',
                  style: TextStyle(
                    color: ColorConstants.secondary,
                    fontSize: 16,
                  ),
                ),
              )
              : Padding(
                padding: const EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: boughtProductsList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        navigatorKey.currentState?.push(
                          MaterialPageRoute(
                            builder:
                                (context) => ProductDetailsScreen(
                                  product: boughtProductsList[index],
                                ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorConstants.scaffoldBackground,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: ColorConstants.blurColor,
                                blurRadius: 3,
                                spreadRadius: .1,
                                blurStyle: BlurStyle.normal,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: LayoutBuilder(
                            builder: (context, constraints) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Container(
                                        width: 100,
                                        color:
                                            ColorConstants.scaffoldBackground,
                                        child: Image.network(
                                          boughtProductsList[index].image ?? '',
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: Text(
                                      boughtProductsList[index].title ?? '',
                                      softWrap: true,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                      right: 10,
                                      bottom: 10,
                                      top: 2,
                                    ),
                                    child: Text(
                                      '\u20B9 ${boughtProductsList[index].price ?? 0}',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
        },
      ),
    );
  }
}
