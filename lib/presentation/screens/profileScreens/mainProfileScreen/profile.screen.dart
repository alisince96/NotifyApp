import 'dart:io';

import 'package:cache_manager/cache_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:p_notify/app/constants/app.colors.dart';
import 'package:p_notify/app/constants/app.keys.dart';
import 'package:p_notify/app/routes/app.routes.dart';
import 'package:p_notify/core/notifiers/theme.notifier.dart';
import 'package:p_notify/core/notifiers/user.notifier.dart';
import 'package:p_notify/core/utils/snackbar.util.dart';
import 'package:p_notify/main.dart';
import 'package:p_notify/presentation/widgets/custom.back.btn.dart';
import 'package:p_notify/presentation/widgets/custom.text.style.dart';
import 'package:p_notify/presentation/widgets/dimensions.widget.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? imageFile = File("");

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  // Taking Images from Gallery
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        imageFile = File(pickedImage.path);
      });
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
          children: [
            Row(
              children: [
                CustomBackButton(
                  route: AppRouter.homeRoute,
                  themeFlag: themeFlag,
                ),
                Text(
                  'Profile',
                  style: CustomTextWidget.bodyTextB2(
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
              ],
            ),
            vSizedBox1,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  /// Circle Image 
                  _createAccountInformation(
                      context: context,
                      themeFlag: themeFlag,
                      imageFile: imageFile!),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.editProfileRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Update Info',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   behavior: HitTestBehavior.translucent,
                  //   onTap: () {
                  //     Navigator.of(context).pushNamed(AppRouter.notificaions);
                  //   },
                  //   child: Container(
                  //     margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Notifications',
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //             color: themeFlag
                  //                 ? AppColors.creamColor
                  //                 : AppColors.mirage,
                  //           ),
                  //         ),
                  //         Icon(
                  //           Icons.chevron_right,
                  //           size: 20,
                  //           color: themeFlag
                  //               ? AppColors.creamColor
                  //               : AppColors.mirage,
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.changePassRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Change Password',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(AppRouter.appSettingsRoute);
                    },
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 18, 0, 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Settings',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 18, 0, 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        DeleteCache.deleteKey(AppKeys.userData)
                            .whenComplete(() {
                          DeleteCache.deleteKey("Username").whenComplete(() {
                            Navigator.of(context)
                                .pushReplacementNamed(AppRouter.loginRoute);
                          });
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.power_settings_new,
                            size: 20,
                            color: themeFlag
                                ? AppColors.creamColor
                                : AppColors.mirage,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Sign Out',
                            style: TextStyle(
                              fontSize: 15,
                              color: themeFlag
                                  ? AppColors.creamColor
                                  : AppColors.mirage,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createAccountInformation(
      {required BuildContext context,
      required bool themeFlag,
      required File imageFile}) {
    // final userNotifier = Provider.of<UserNotifier>(context, listen: false);
    // var userName = userNotifier.getUserName ?? 'Wait';

    final double profilePictureSize = MediaQuery.of(context).size.width / 4;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: profilePictureSize,
            height: profilePictureSize,
            child: GestureDetector(
              onTap: () {
                if (userName == 'Wait') {
                  SnackUtil.stylishSnackBar(
                      text: 'Session Timeout', context: context);
                  Navigator.of(context)
                      .pushReplacementNamed(AppRouter.loginRoute);
                  DeleteCache.deleteKey(AppKeys.userData);
                } else {
                  Navigator.of(context).pushNamed(AppRouter.accountInfo);
                }
              },
              child: Stack(
                children: [
                  CircleAvatar(
                      radius: profilePictureSize - 4,
                      backgroundColor:
                          themeFlag ? AppColors.creamColor : AppColors.mirage,
                      child: Hero(
                          tag: "profilePicture",
                          child: (imageFile.path.isEmpty)
                              ? ClipOval(
                                  child: SvgPicture.network(
                                  'https://avatars.dicebear.com/api/big-smile/$userName.svg',
                                  semanticsLabel: 'A shark?!',
                                  alignment: Alignment.center,
                                  placeholderBuilder: (BuildContext context) =>
                                      Container(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Center(
                                              child:
                                                  const CircularProgressIndicator())),
                                ))
                              : ClipOval(
                                  child: Image.file(
                                    imageFile,
                                    fit: BoxFit.contain,
                                  ),
                                ))),
                  Positioned(
                    bottom: -3,
                    right: -3,
                    child: CircleAvatar(
                      backgroundColor: Colors
                          .transparent, // Set the background color to transparent
                      // Set the radius of the camera icon
                      child: IconButton(
                          onPressed: () async {
                            _openImagePicker();
                          },
                          icon: const Icon(Icons.camera_alt,
                              size: 30, color: Color(0xFFFFC77D))),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeFlag ? AppColors.creamColor : AppColors.mirage,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    if (userName == 'Wait') {
                      SnackUtil.stylishSnackBar(
                          text: 'Session Timeout', context: context);
                      Navigator.of(context)
                          .pushReplacementNamed(AppRouter.loginRoute);
                      DeleteCache.deleteKey(AppKeys.userData);
                    } else {
                      Navigator.of(context).pushNamed(AppRouter.accountInfo);
                    }
                  },
                  child: Row(
                    children: [
                      // Text(
                      //   'Account Information',
                      //   style: TextStyle(
                      //     fontSize: 14,
                      //     color: themeFlag
                      //         ? AppColors.creamColor
                      //         : AppColors.mirage,
                      //   ),
                      // ),
                      // const SizedBox(
                      //   width: 8,
                      // ),
                      // Icon(
                      //   Icons.chevron_right,
                      //   size: 20,
                      //   color:
                      //       themeFlag ? AppColors.creamColor : AppColors.mirage,
                      // )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
