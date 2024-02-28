import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import '../../../../utils/colors/app_colors.dart';
import '../../../../utils/styles/app_text_style.dart';

class ProfileItems extends StatelessWidget {
  const ProfileItems({super.key, required this.iconPath, required this.title, required this.onTab});

  final String iconPath;
  final String title;
  final VoidCallback onTab;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 24.w),
        leading: SvgPicture.asset(iconPath),
        title: Text(
          title,
          style: AppTextStyle.latoRegular
              .copyWith(color: AppColors.white.withOpacity(.87)),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.white.withOpacity(.87),
          size: 24.h,
        ),
      ),
    );
  }
}
