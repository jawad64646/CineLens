import 'package:flutter/material.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? back;
  final Widget? title;
  final Widget? trailingIcon;

  const BasicAppBar({super.key, this.back, this.title, this.trailingIcon});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: back,
      title: title,
      actions: [trailingIcon ?? Container()],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
