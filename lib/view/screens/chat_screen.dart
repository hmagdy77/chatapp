import 'package:chatapp/core/constants/app_strings.dart';
import 'package:chatapp/view/widgets/lottie/empty.dart';
import 'package:chatapp/view/widgets/public/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../core/constants/app_color_manger.dart';
import '../../core/constants/app_sizes.dart';
import '../widgets/lottie/loading.dart';
import '../widgets/text_fields/my_text_field.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        actions: [
          IconButton(
              onPressed: () {
                authController.logOut();
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.w02),
          child: Obx(
            () {
              if (authController.isLoading.value) {
                return const MyLottieLoading();
              } else {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            StreamBuilder(
                              stream: authController.firestore
                                  .collection('messages')
                                  .orderBy('time')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Align> messageWidgets = [];
                                  final messages = snapshot.data!.docs;
                                  for (var message in messages) {
                                    final messageText = message.get('text');
                                    final messageSender = message.get('sender');

                                    final messageWidget = Align(
                                      alignment:
                                          authController.displayUserEmail ==
                                                  messageSender
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color:
                                                  AppColorManger.instgramColor,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          child: Text('$messageText')),
                                    );
                                    messageWidgets.add(messageWidget);
                                  }
                                  return Column(
                                    children: messageWidgets,
                                  );
                                } else {
                                  return const MyLottieEmpty();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(authController.displayUserEmail.value),
                    Row(
                      children: [
                        Expanded(
                          child: MyTextField(
                            controller: authController.chat,
                            label: '',
                            hint: '',
                            hidePassword: false,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (authController.chat.text.isEmpty) {
                              MySnackBar.snack(
                                  AppStrings.cantBeEmpty, 'message');
                            } else {
                              authController.firestore
                                  .collection('messages')
                                  .add(
                                {
                                  'text': authController.chat.text,
                                  'sender': authController.userProfile!.email,
                                  'time': FieldValue.serverTimestamp()
                                },
                              ).then((value) => authController.chat.clear());
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: CircleAvatar(
                              backgroundColor: AppColorManger.primary,
                              radius: AppSizes.h03,
                              child: const Icon(Icons.send,
                                  color: AppColorManger.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppSizes.h02),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
