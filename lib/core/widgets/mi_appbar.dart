import 'package:flutter/material.dart';

class MiAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final String backgroundImage;
  final bool centerTitle;
  final List<Widget>? actions;
  final PreferredSizeWidget? bottom;

  const MiAppbar({
    super.key,
    required this.title,
    this.backgroundImage = 'assets/images/banner.png',
    this.centerTitle = true,
    this.actions,
    this.bottom,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true, 
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      actions: actions ?? [],
      centerTitle: centerTitle,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.fill,
          ),
        ),
      ),
      backgroundColor: Colors.transparent, 
      elevation: 0,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
