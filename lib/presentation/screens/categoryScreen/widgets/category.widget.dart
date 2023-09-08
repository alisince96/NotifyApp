import 'package:flutter/material.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/models/product.model.dart';
import 'package:p_notify/core/models/single_prod.dart';
import 'package:p_notify/core/notifiers/product.notifier.dart';
import 'package:p_notify/presentation/screens/productDetailScreen/product.detail.screen.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:provider/provider.dart';

Widget showDataInGrid(
    {required themeFlag,
 
    required BuildContext context,
    required double height}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.700,
      ),
      itemCount: Provider.of<ProductNotifier>(context).searchedProducts.length,
      itemBuilder: (context, index) {
        final prod = Provider.of<ProductNotifier>(context, listen: true)
            .searchedProducts[index];
           

        return _showProducts(
            context: context, prod: prod, themeFlag: themeFlag, height: height);
      },
    ),
  );
}

Widget _showProducts(
    {required BuildContext context,
    required ProdData prod,
    required bool themeFlag,
    required double height}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: Colors.grey.withOpacity(0.2),
        width: 1,
      ),
    ),
    elevation: 6,
    color: themeFlag ? AppColors.mirage : AppColors.creamColor,
    child: GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        Navigator.of(context).pushNamed(
          AppRouter.prodDetailRoute,
          arguments: ProductDetailsArgs(prodData: prod),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            child: Hero(
              tag: Key(prod.id.toString()),
              child: SizedBox(
                height: height,
                child: Image.network(
                            "http://89.116.156.87/${prod.thumbnailImage}",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                (loadingProgress == null)
                                    ? child
                                    : Center(child: const CircularProgressIndicator()),
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/noimage.png"),
                          ),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prod.name ?? '',
                  style: CustomTextWidget.bodyText3(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'PKR  ${prod.basePrice}',
                  style: CustomTextWidget.bodyText3(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
Widget showDataInGrid1(
    {required themeFlag,
    required List<ProdData> list,
    required BuildContext context,
    required double height}) {
      
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
    child: GridView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.700,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
    
        // final prod = Provider.of<ProductNotifier>(context, listen: true)
        //     .searchedProducts[index];
        //     print("Search Product Index"+prod.toJson().toString());

        return _showProducts1(
            context: context, prod: list[index], themeFlag: themeFlag, height: height);
      },
    ),
  );
}

Widget _showProducts1({required BuildContext context, required ProdData prod, required themeFlag, required double height}) {

return Card(
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: BorderSide(
        color: Colors.grey.withOpacity(0.2),
        width: 1,
      ),
    ),
  child: GestureDetector(
          behavior: HitTestBehavior.translucent,
      onTap: () {
         Navigator.of(context).pushNamed(
           AppRouter.prodDetailRoute,
           arguments: ProductDetailsArgs(prodData: prod),
         );
      },
    child: Column(
       mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
              ClipRRect(
               borderRadius: const BorderRadius.only(
                 topLeft: Radius.circular(10),
                 topRight: Radius.circular(10),
               ),
               child: Hero(
                 tag: Key(prod.id.toString()),
                 child: SizedBox(
                   height: height,
                   child:Image.network(
                            "http://89.116.156.87/${prod.thumbnailImage}",
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                (loadingProgress == null)
                                    ? child
                                    :const Center(child:  CircularProgressIndicator()),
                            errorBuilder: (context, error, stackTrace) =>
                                Image.asset("assets/images/noimage.png"),
                          )
   
                 ),
               ),
             ),
                       Container(
              margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    prod.name ?? '',
                    style: CustomTextWidget.bodyText3(
                      color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'PKR  ${prod.basePrice}',
                    style: CustomTextWidget.bodyText3(
                      color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
  ),
         
  );


}

// Widget _showProducts1(
//     {required BuildContext context,
//     required ProdData prod,
//     required bool themeFlag,
//     required double height}) {
//   return Card(
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(10),
//       side: BorderSide(
//         color: Colors.grey.withOpacity(0.2),
//         width: 1,
//       ),
//     ),
//     elevation: 6,
//     color: themeFlag ? AppColors.mirage : AppColors.creamColor,
//     child: GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: () {
//         // Navigator.of(context).pushNamed(
//         //   AppRouter.prodDetailRoute,
//         //   arguments: ProductDetailsArgs(prodData: prod),
//         // );
//       },
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(10),
//               topRight: Radius.circular(10),
//             ),
//             child: Hero(
//               tag: Key(prod.id.toString()),
//               child: SizedBox(
//                 height: height,
//                 child: Image(image: NetworkImage('http://89.116.156.87/${prod.thumbnailImage}')),
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.fromLTRB(8, 8, 8, 8),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   prod.name ?? '',
//                   style: CustomTextWidget.bodyText3(
//                     color: themeFlag ? AppColors.creamColor : AppColors.mirage,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//                 Text(
//                   'PKR  ${prod.basePrice}',
//                   style: CustomTextWidget.bodyText3(
//                     color: themeFlag ? AppColors.creamColor : AppColors.mirage,
//                   ),
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }
