import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smart_fert/utils/theme/constants/colors.dart';
import 'package:smart_fert/utils/theme/constants/sizes.dart';
import 'package:smart_fert/utils/theme/device/device_utils.dart';
import 'package:smart_fert/utils/theme/helper_functions/helper_functions.dart';




class EAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EAppBar(
      {super.key,
        this.title,
        this.showBackArrow = false,
        this.leadingIcon,
        this.leadingIconColor,
        this.actions,
        this.leadingOnPressed, this.leadingIconSize});

  final Widget? title;
  final bool showBackArrow;
  final Color? leadingIconColor;
  final double? leadingIconSize;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: ESizes.md,
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Iconsax.arrow_left,
              color: dark ? EColors.white : EColors.dark,
            ))
            : leadingIcon != null
            ? IconButton(
          onPressed: leadingOnPressed,
          icon: Icon(leadingIcon, color: leadingIconColor, size: leadingIconSize,),
        )
            : null,

        title: title,
        actions: actions,
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
}
