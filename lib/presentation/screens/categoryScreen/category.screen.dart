import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:p_notify/app/constants/app.assets.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/notifiers/product.notifier.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/presentation/screens/categoryScreen/widgets/category.widget.dart';
import 'package:p_notify/presentation/widgets/custom.back.btn.dart';
import 'package:p_notify/presentation/widgets/custom.loader.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:p_notify/presentation/widgets/dimensions.widget.dart';
import 'package:p_notify/presentation/widgets/shimmer.effects.dart';

class CategoryScreen extends StatefulWidget {
  final CategoryScreenArgs categoryScreenArgs;

  const CategoryScreen({Key? key, required this.categoryScreenArgs})
      : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.categoryScreenArgs.fromCategory) {
      Provider.of<ProductNotifier>(context, listen: false)
          .fetchCategoryProducts(id: widget.categoryScreenArgs.id);
    } else {
      Provider.of<ProductNotifier>(context, listen: false)
          .fetchBrandProducts(id: widget.categoryScreenArgs.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
              child: Row(
                children: [
                  CustomBackButton(
                    route: AppRouter.homeRoute,
                    themeFlag: themeFlag,
                  ),
                  Center(
                    child: Text(
                      widget.categoryScreenArgs.categoryName,
                      style: CustomTextWidget.bodyTextB2(
                        color:
                            themeFlag ? AppColors.creamColor : AppColors.mirage,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            vSizedBox2,
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.85,
                  width: MediaQuery.of(context).size.width,
                  child: Consumer<ProductNotifier>(
                    builder: (context, notifier, _) {
                      final list =
                          Provider.of<ProductNotifier>(context, listen: true)
                              .selectedBrandProds;
                             
                      if (Provider.of<ProductNotifier>(context, listen: true)
                          .fetchBrandsLoading) {
                        return ShimmerEffects.buildCategoryShimmer(
                            context: context);
                      } else if (list.isEmpty) {
                        return customLoader(
                          context: context,
                          themeFlag: themeFlag,
                          text: 'No Stock Available',
                          lottieAsset: AppAssets.error,
                        );
                      } else {
                        return showDataInGrid1(
                            height: MediaQuery.of(context).size.height * 0.20,
                            list: list,
                            themeFlag: themeFlag,
                            context: context);
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryScreenArgs {
  final dynamic categoryName;
  final String id;
  final bool fromCategory;
  const CategoryScreenArgs(
      {required this.categoryName,
      required this.id,
      this.fromCategory = false});
}
