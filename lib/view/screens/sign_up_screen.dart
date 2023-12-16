import 'package:chatapp/view/widgets/lottie/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../core/constants/app_color_manger.dart';
import '../../core/constants/app_sizes.dart';
import '../../core/constants/app_strings.dart';
import '../../routes.dart';
import '../widgets/public/my_button.dart';
import '../widgets/text_fields/my_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w02),
          child: Obx(
            () {
              if (authController.isLoading.value) {
                return const MyLottieLoading();
              } else {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: AppSizes.h03),
                      Image.asset(
                        'assets/images/logo.jpg',
                        width: AppSizes.w5,
                        height: AppSizes.h3,
                      ),
                      SizedBox(height: AppSizes.h03),
                      MyTextField(
                        controller: authController.name,
                        sufIcon: const Icon(Icons.person),
                        label: AppStrings.name,
                        hidePassword: false,
                      ),
                      SizedBox(height: AppSizes.h03),
                      MyTextField(
                        controller: authController.email,
                        sufIcon: const Icon(Icons.person),
                        label: AppStrings.userName,
                        hidePassword: false,
                      ),
                      SizedBox(height: AppSizes.h03),
                      GetBuilder<AuthController>(
                        builder: (_) {
                          return MyTextField(
                            controller: authController.password,
                            label: AppStrings.password.tr,
                            hidePassword: authController.isShown.value,
                            sufIcon: Icon(Icons.lock,
                                color: context.theme.primaryColor),
                            preIcon: IconButton(
                              onPressed: () {
                                authController.showPassword();
                              },
                              icon: authController.isShown.value
                                  ? const Icon(
                                      Icons.visibility,
                                      color: AppColorManger.primary,
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: AppColorManger.primary,
                                    ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: AppSizes.h03),
                      MyButton(
                        minWidth: AppSizes.w3,
                        text: AppStrings.signUp,
                        onPressed: () async {
                          await authController.signUpWithEmailAndPassword(
                            name: authController.name.text,
                            email: authController.email.text,
                            password: authController.password.text,
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppStrings.haveAcc,
                            style: context.textTheme.displayMedium!,
                          ),
                          SizedBox(width: AppSizes.h02),
                          TextButton(
                            onPressed: () {
                              Get.toNamed(AppRoutes.loginScreen);
                            },
                            child: Text(
                              AppStrings.login,
                              style: context.textTheme.displayMedium!.copyWith(
                                decoration: TextDecoration.underline,
                                color: AppColorManger.kColor3,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
