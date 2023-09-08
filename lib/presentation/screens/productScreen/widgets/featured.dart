import 'package:flutter/material.dart';
import 'package:p_notify/app/routes/api.routes.dart';
import 'package:p_notify/core/notifiers/product.notifier.dart';
import 'package:provider/provider.dart';
import 'package:p_notify/app/constants/app.assets.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/presentation/screens/categoryScreen/category.screen.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:p_notify/presentation/widgets/dimensions.widget.dart';
// Showing the featured Data on the Screen
class FeaturedWidget extends StatelessWidget {
  const FeaturedWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;

    List<String> _categories = [
      "Jordan's",
      "Adidas",
      "Puma",
      "Reebok",
      "Nike",
    ];
    List<String> _categoriesImages = [
      AppAssets.brandJordan,
      AppAssets.brandAdidas,
      AppAssets.brandPuma,
      AppAssets.brandReebok,
      AppAssets.brandNike
    ];

    showBrands(String text, var images, String id) {
      return GestureDetector(
        onTap: () {
          // Navigate to products Item Screen
          Navigator.of(context).pushNamed(
            AppRouter.categoryRoute,
            arguments: CategoryScreenArgs(categoryName: text, id: id),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(
                color: Colors.grey.withOpacity(0.2),
                width: 1,
              ),
            ),
            elevation: 6,
            color: themeFlag ? AppColors.mirage : AppColors.creamColor,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.38,
                  child: Image.network(
                            "http://89.116.156.87/$images",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                (loadingProgress == null)
                                    ? child
                                    : Center(child: const CircularProgressIndicator()),
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/noimage.png"),
                          )
                ),
                vSizedBox1,
                Text(
                  text,
                  style: CustomTextWidget.bodyText2(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured',
          style: CustomTextWidget.bodyTextB2(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
        vSizedBox2,
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            shrinkWrap: false,
            scrollDirection: Axis.horizontal,
            physics: const ScrollPhysics(),
            itemCount: Provider.of<ProductNotifier>(context).featured.length,
            itemBuilder: (BuildContext context, int index) {
              final list = Provider.of<ProductNotifier>(
                context,
              ).featured;
              
              return showBrands(
                  list[index].name ?? '',
                  list[index].logo,
                  list[index].id.toString());
            },
          ),
        )
      ],
    );
  }
}
