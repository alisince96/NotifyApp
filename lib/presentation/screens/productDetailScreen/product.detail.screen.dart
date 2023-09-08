import 'package:flutter/material.dart';
import 'package:p_notify/core/models/single_prod.dart';
import 'package:provider/provider.dart';

import 'package:p_notify/app/constants/app.assets.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/core/models/productID.model.dart';
import 'package:p_notify/core/notifiers/product.notifier.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/presentation/screens/productDetailScreen/widget/ui.detail.dart';
import 'package:p_notify/presentation/widgets/custom.loader.dart';

class ProductDetail extends StatefulWidget {
  final ProductDetailsArgs productDetailsArguements;
  const ProductDetail({
    Key? key,
    required this.productDetailsArguements,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isAlert = false;
  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;

    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 45, 20, 0),
          child: Consumer<ProductNotifier>(builder: (context, notifier, _) {
            //Showing the Product Detail Screen
            return productUI(
                context: context,
                themeFlag: themeFlag,
                alertButton: isAlert,
                // Bell Icon Button on Product Detail Screen
                onAlertTap: () {
                  isAlert = !isAlert;
                  setState(() {});
                  // Calling the Notifiy API
                  Provider.of<ProductNotifier>(context, listen: false)
                      .getNotified(
                          context: context,
                          productId: widget.productDetailsArguements.prodData.id
                              .toString());
                },
                prodData: widget.productDetailsArguements.prodData);
          }),
        ),
      ),
    );
  }
}

class ProductDetailsArgs {
  final ProdData prodData;
  const ProductDetailsArgs({required this.prodData});
}
