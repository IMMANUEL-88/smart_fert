import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../utils/theme/device/device_utils.dart';
import '../../utils/theme/helper_functions/helper_functions.dart';

class EAppBar extends StatelessWidget implements PreferredSizeWidget {
  const EAppBar({
    super.key,
    this.title,
    this.showBackArrow = false,
    this.leadingIcon,
    this.leadingIconColor,
    this.actions,
    this.leadingOnPressed,
    this.leadingIconSize,
    this.precedingIcon, // Added preceding icon
    this.precedingOnPressed, // Added preceding button action
    this.precedingIconColor,
  });

  final Widget? title;
  final bool showBackArrow;
  final Color? leadingIconColor;
  final double? leadingIconSize;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;

  // New preceding icon and its properties
  final IconData? precedingIcon;
  final VoidCallback? precedingOnPressed;
  final Color? precedingIconColor;

  @override
  Widget build(BuildContext context) {
    final dark = EHelperFunctions.isDarkMode(context);
    return AppBar(
      backgroundColor: Colors.green,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      leading: showBackArrow
          ? IconButton(
        onPressed: (){},
        icon: const Icon(
          Iconsax.arrow_left,
          color: Colors.white,
        ),
      )
          : leadingIcon != null
          ? IconButton(
        onPressed: leadingOnPressed,
        icon: Icon(
          leadingIcon,
          color: leadingIconColor,
          size: leadingIconSize,
        ),
      )
          : null,

      title: title,

      actions: [
        if (actions != null) ...actions!, // Other action buttons (if any)
        if (precedingIcon != null) // Preceding icon on the right
          IconButton(
            onPressed: precedingOnPressed,
            icon: Icon(
              precedingIcon,
              color: precedingIconColor ?? (dark ? Colors.white : Colors.black),
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(EDeviceUtils.getAppBarHeight());
}