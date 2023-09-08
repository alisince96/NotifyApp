import 'package:flutter/material.dart';
import 'package:p_notify/core/models/single_prod.dart';
import 'package:provider/provider.dart';
import 'package:p_notify/app/constants/app.assets.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/models/productID.model.dart';
import 'package:p_notify/core/notifiers/cart.notifier.dart';
import 'package:p_notify/core/notifiers/size.notifier.dart';
import 'package:p_notify/core/notifiers/user.notifier.dart';
import 'package:p_notify/core/utils/snackbar.util.dart';
import 'package:p_notify/presentation/screens/productDetailScreen/widget/select.size.dart';
import 'package:p_notify/presentation/widgets/custom.back.btn.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:p_notify/presentation/widgets/dimensions.widget.dart';

Widget productUI(
    {required BuildContext context,
    required bool themeFlag,
    required alertButton,
    required ProdData prodData,
    required VoidCallback onAlertTap}) {
  CartNotifier cartNotifier = Provider.of<CartNotifier>(context, listen: false);
  UserNotifier userNotifier = Provider.of<UserNotifier>(context, listen: false);
  SizeNotifier sizeNotifier = Provider.of<SizeNotifier>(context, listen: false);
  bool isAlert = false;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      CustomBackPop(themeFlag: themeFlag),
      Column(
        children: [
          Center(
            child: Text(
              prodData.name ?? '',
              style: CustomTextWidget.bodyTextB1(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
            ),
          ),
          vSizedBox2,
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                child: themeFlag
                    ? Image.asset(AppAssets.diamondWhite)
                    : Image.asset(AppAssets.diamondBlack),
              ),
              Hero(
                tag: Key(prodData.id.toString()),
                child: InteractiveViewer(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.7,
                    child:Image.network(
                            "http://89.116.156.87/${prodData.thumbnailImage.toString()}",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                (loadingProgress == null)
                                    ? child
                                    : const CircularProgressIndicator(),
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/noimage.png"),
                          ),
                  ),
                ),
              ),
            ],
          ),
          vSizedBox2,
          Text(
            prodData.rating.toString(),
            style: CustomTextWidget.bodyText3(
              color: themeFlag ? AppColors.creamColor : AppColors.mirage,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
      vSizedBox2,
      // Text(
      //   'Choose Size',
      //   style: CustomTextWidget.bodyTextB4(
      //     color: themeFlag ? AppColors.creamColor : AppColors.mirage,
      //   ),
      // ),
      // vSizedBox2,
      // SizedBox(
      //   height: MediaQuery.of(context).size.height * 0.05,
      //   width: MediaQuery.of(context).size.width,
      //   child: selectSize(context: context, themeFlag: themeFlag),
      // ),
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${prodData.basePrice}',
              style: CustomTextWidget.bodyTextUltra(
                color: themeFlag ? AppColors.creamColor : AppColors.mirage,
              ),
            ),
            InkWell(
              onTap: () {
                onAlertTap();
              },
              child: Icon(
                Icons.notifications_active,
                color: alertButton ? Colors.blue : Colors.grey,
              ),
            )
          ],
        ),
      )
    ],
  );
}
