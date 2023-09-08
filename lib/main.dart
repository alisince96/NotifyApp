import 'package:cache_manager/cache_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:p_notify/app/constants/app.theme.dart';
import 'package:p_notify/app/providers/app.provider.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/core/service/push_noti_service.dart';
import 'package:provider/provider.dart';
// import 'web_url/configure_nonweb.dart'
//     if (dart.library.html) 'web_url/configure_web.dart';
var userName;
void main() async {
  // configureApp();
  // Flutter Binding , Firebase Initilizing, Notification Initilize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebasePushNoti().initNoti();
  userName = await ReadCache.getString(key: "Username")?? "Wait";
 
  runApp(const Lava());
}

class Lava extends StatelessWidget {
  const Lava({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return MultiProvider(
      providers: AppProvider.providers,// All the App Provider 
      child: const Core(),
    );
  }
}

class Core extends StatelessWidget {
  const Core({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, notifier, _) {
        return MaterialApp(
          title: 'P-Notify',
          // supportedLocales: AppLocalization.all,
          theme: notifier.darkTheme ? darkTheme : lightTheme,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: AppRouter.splashRoute,
        );
      },
    );
  }
}
/// After reading this code open the product Screen
