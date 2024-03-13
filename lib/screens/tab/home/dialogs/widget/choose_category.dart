import 'package:flutter/material.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/styles/app_text_style.dart';

class ChooseCategory extends StatelessWidget {
  const ChooseCategory(
      {super.key,
      required this.iconPath,
      this.color,
      required this.colorItem,
      required this.name,
      required this.onTap,
      required this.onDoubleTap});

  final String iconPath;
  final Color? color;
  final Color colorItem;
  final String name;
  final VoidCallback onTap;
  final VoidCallback onDoubleTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: onDoubleTap,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.w),
          color: color,
        ),
        child: Column(
          children: [
            10.getH(),
            Container(
              height: 64.h,
              width: 64.w,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.w), color: colorItem),
              child: SvgPicture.asset(iconPath),
            ),
            5.getH(),
            Text(
              name,
              style: AppTextStyle.latoMedium,
            )
          ],
        ),
      ),
    );
  }
}
