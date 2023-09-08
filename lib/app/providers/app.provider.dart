import 'package:p_notify/core/notifiers/authentication.notifer.dart';
import 'package:p_notify/core/notifiers/cart.notifier.dart';
import 'package:p_notify/core/notifiers/device_info_provider.dart';
import 'package:p_notify/core/notifiers/notification_notifier.dart';
import 'package:p_notify/core/notifiers/product.notifier.dart';
import 'package:p_notify/core/notifiers/size.notifier.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/core/notifiers/user.notifier.dart';
import 'package:p_notify/core/service/payment.service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ChangeNotifierProvider(create: (_) => AuthenticationNotifier()),
    ChangeNotifierProvider(create: (_) => UserNotifier()),
    ChangeNotifierProvider(create: (_) => ProductNotifier()),
    ChangeNotifierProvider(create: (_) => SizeNotifier()),
    ChangeNotifierProvider(create: (_) => CartNotifier()),
    ChangeNotifierProvider(create: (_) => PaymentService()),
    ChangeNotifierProvider(create: (_) => DeviceInfoProvider()),
    ChangeNotifierProvider(create: (_) => NotificaionsNotifier()),
  ];
}
