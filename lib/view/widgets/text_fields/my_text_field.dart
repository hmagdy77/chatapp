import 'package:flutter/material.dart';

import '../../../core/constants/app_color_manger.dart';
import '../../../core/constants/app_sizes.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    this.sufIcon,
    this.label,
    this.hint,
    this.controller,
    required this.hidePassword,
    this.readOnly,
    this.preIcon,
    this.maxLines,
    this.onFieldSubmitted,
  }) : super(key: key);
  final TextEditingController? controller;
  final Widget? sufIcon; //sufIcon
  final Widget? preIcon; //
  final int? maxLines;
  final String? label;
  final String? hint;
  final bool hidePassword;
  final bool? readOnly;
  final Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColorManger.primary,
      autocorrect: true,
      readOnly: readOnly == null ? false : true,
      obscureText: hidePassword,
      textCapitalization: TextCapitalization.sentences,
      maxLines: maxLines ?? 1,
      cursorHeight: AppSizes.h04,
      onFieldSubmitted: onFieldSubmitted,
      style: Theme.of(context)
          .textTheme
          .displayMedium!
          .copyWith(color: AppColorManger.backdark),
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.all(1),
        errorStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AppColorManger.red),
        label: Text(label!,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: AppColorManger.black)),
        floatingLabelStyle: Theme.of(context).textTheme.bodySmall,
        hintText: hint,
        hintStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: AppColorManger.grey),
        suffixIcon: preIcon,
        prefixIcon: sufIcon ?? const Text(''),
        suffixIconColor: AppColorManger.primary,
        prefixIconColor: AppColorManger.primary,
        filled: true,
        fillColor: AppColorManger.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.h02),
          borderSide: const BorderSide(color: AppColorManger.primary, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.h02),
          borderSide: const BorderSide(color: AppColorManger.primary, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.h02),
          borderSide: const BorderSide(color: AppColorManger.primary, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.h02),
          borderSide: const BorderSide(color: AppColorManger.primary, width: 2),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.h02),
          borderSide: const BorderSide(color: AppColorManger.red, width: 2),
        ),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.h02),
          borderSide: const BorderSide(color: AppColorManger.red, width: 2),
        ),
      ),
    );
  }
}
