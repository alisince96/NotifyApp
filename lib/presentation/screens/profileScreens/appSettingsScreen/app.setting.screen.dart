import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/presentation/widgets/custom.back.btn.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:p_notify/presentation/widgets/dimensions.widget.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeNotifier _themeNotifier = Provider.of<ThemeNotifier>(context);
    var themeFlag = _themeNotifier.darkTheme;
    return Scaffold(
      backgroundColor: themeFlag ? AppColors.mirage : AppColors.creamColor,
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                CustomBackPop(themeFlag: themeFlag),
                Text(
                  'App Settings',
                  style: CustomTextWidget.bodyTextB2(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
              ],
            ),
            Consumer<ThemeNotifier>(
              builder: (context, notifier, _) {
                return SwitchListTile(
                  contentPadding: const EdgeInsets.only(left: 16, right: 4),
                  title: const Text(
                    'Dark Mode',
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  value: themeFlag,
                  activeColor:
                      themeFlag ? AppColors.creamColor : AppColors.mirage,
                  onChanged: (bool value) {
                    notifier.toggleTheme();
                  },
                );
              },
            ),
            Divider(height: 0, color: Colors.grey[400]),
            vSizedBox2,
            Text(
              'App Version',
              style: TextStyle(
                  fontSize: 14,
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              '0.0.1',
              style: TextStyle(
                  fontSize: 14,
                  color: themeFlag ? AppColors.creamColor : AppColors.mirage),
            ),
          ],
        ),
      ),
    );
  }
}
