import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/constants/app.keys.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/models/notifications.dart';
import 'package:p_notify/core/notifiers/notification_notifier.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/presentation/widgets/custom.back.btn.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:provider/provider.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  void initState() {
    // Get all the notification list
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ReadCache.getString(key: AppKeys.id).then((value) {
        final provider =
            Provider.of<NotificaionsNotifier>(context, listen: false);
        provider.fetchNotifications(id: value as String);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    final items = Provider.of<NotificaionsNotifier>(context).notifications;
    final isLoading = Provider.of<NotificaionsNotifier>(context).isLoading;
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
       backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      appBar: AppBar(
       backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
        leading: CustomBackButton(
          route: AppRouter.homeRoute,
          themeFlag: themeFlag,
          
        ),
       
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Notifications',
          style: CustomTextWidget.bodyTextB2(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
      ),
      body: isLoading
          ? const _Loading()
          : SingleChildScrollView(
              child: Column(
                mainAxisAlignment: items.isEmpty
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  if (items.isEmpty) ...[
                    const _NoItem(),
                  ] else ...[
                    ListView.separated(
                      reverse: true,
                      itemCount: items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return _NotificationItem(
                          item: items[index],
                          themeFlag: themeFlag,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 20);
                      },
                    ),
                  ]
                ],
              ),
            ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationItem item;
  final bool themeFlag;
  const _NotificationItem({
    required this.item,
    required this.themeFlag,
  });

  @override
  Widget build(BuildContext context) {
    // Showing the Notification Item
    return Container(
      height: 100,
      alignment: Alignment.center,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          radius: 40,
          child: Center(
            child: Icon(Icons.notifications),
          ),
        ),
        title: Text(
          item.notificationText ?? '',
          style: CustomTextWidget.bodyTextB2(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
        subtitle: Text(
          item.createdAt ?? '',
          style: CustomTextWidget.bodyText3(
            color: themeFlag ? AppColors.creamColor : AppColors.mirage,
          ),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircularProgressIndicator(),
        const SizedBox(height: 10),
        Text(
          'Loading...',
          style: CustomTextWidget.bodyTextB2(
            color: AppColors.creamColor,
          ),
        ),
      ],
    );
  }
}

class _NoItem extends StatelessWidget {
  const _NoItem();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: Icon(Icons.hourglass_empty),
        ),
      ],
    );
  }
}
