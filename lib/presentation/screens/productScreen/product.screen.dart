import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:p_notify/core/notifiers/authentication.notifer.dart';
import 'package:p_notify/presentation/screens/productScreen/widgets/categories.dart';
import 'package:p_notify/presentation/screens/productScreen/widgets/featured.dart';
import 'package:provider/provider.dart';
import 'package:p_notify/app/constants/app.assets.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/core/notifiers/product.notifier.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/core/notifiers/user.notifier.dart';
import 'package:p_notify/presentation/screens/productScreen/widgets/brands.widget.dart';
import 'package:p_notify/presentation/screens/productScreen/widgets/recommended.widget.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:p_notify/presentation/widgets/dimensions.widget.dart';
import 'package:p_notify/presentation/widgets/shimmer.effects.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();
    // Here Getting all the data including brands , featured, categories from API
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProductNotifier>(context, listen: false)
          .fetchBrands(context: context);
      Provider.of<ProductNotifier>(context, listen: false)
          .fetchFeatured(context: context);
      Provider.of<ProductNotifier>(context, listen: false)
          .fetchCategories(context: context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Taking the theme data 
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
// Getting User Data from AuthenticationNotifier
    AuthenticationNotifier _userData =
        Provider.of<AuthenticationNotifier>(context);
    var userName = _userData.userEmail ?? ' ';
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: SafeArea(
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: CustomTextWidget.bodyTextB1(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    vSizedBox1,
                    Text(
                      'What Would You Like To Wear Today ??',
                      style: CustomTextWidget.bodyText3(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                    vSizedBox2,
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            AppColors.rawSienna,
                            AppColors.mediumPurple,
                            AppColors.fuchsiaPink,
                          ],
                        ),
                      ),
                      height: MediaQuery.of(context).size.height * 0.23,
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 5, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pamper Your Feet ',
                              style: CustomTextWidget.bodyTextB2(
                                  color: AppColors.creamColor),
                            ),
                            Text(
                              'With our shoes',
                              style: CustomTextWidget.bodyTextB3(
                                  color: AppColors.creamColor),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // ElevatedButton(
                                //   style: ElevatedButton.styleFrom(
                                //     backgroundColor: AppColors.creamColor,
                                //     enableFeedback: true,
                                //     padding: const EdgeInsets.symmetric(
                                //       horizontal: 20,
                                //       vertical: 2,
                                //     ),
                                //     shape: RoundedRectangleBorder(
                                //       borderRadius: BorderRadius.circular(5.0),
                                //     ),
                                //   ),
                                //   onPressed: () {},
                                //   child: Text(
                                //     'Check',
                                //     style: CustomTextWidget.bodyText3(
                                //       color: AppColors.mirage,
                                //     ),
                                //   ),
                                // ),
                                hSizedBox2,
                                SizedBox(
                                  height: 115,
                                  width: 180,
                                  child: Image.asset(AppAssets.homeJordan),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    vSizedBox2,
                    const BrandWidget(),
                    vSizedBox2,
                    const FeaturedWidget(),
                    vSizedBox2,
                    const CategoryWidget(),
                    // SizedBox(
                    //   height: 200,
                    //   width: MediaQuery.of(context).size.width,
                    //   child: Consumer<ProductNotifier>(
                    //     builder: (context, notifier, _) {
                    //       return FutureBuilder(
                    //         future: notifier.fetchProducts(context: context),
                    //         builder: (context, snapshot) {
                    //           if (snapshot.connectionState ==
                    //               ConnectionState.waiting) {
                    //             return ShimmerEffects.loadShimmer(
                    //                 context: context);
                    //           } else if (!snapshot.hasData) {
                    //             return Center(
                    //               child: Text(
                    //                 'Some Error Occurred...',
                    //                 style: CustomTextWidget.bodyTextUltra(
                    //                   color: themeFlag
                    //                       ? AppColors.creamColor
                    //                       : AppColors.mirage,
                    //                 ),
                    //               ),
                    //             );
                    //           } else {
                    //             var _snapshot = snapshot.data as List;
                    //             return productForYou(
                    //               snapshot: _snapshot,
                    //               themeFlag: themeFlag,
                    //               context: context,
                    //             );
                    //           }
                    //         },
                    //       );
                    //     },
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
