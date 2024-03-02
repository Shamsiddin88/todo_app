import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/models/category/category_model.dart';
import 'package:todo_app/models/profile_settings.dart';
import 'package:todo_app/screens/tab/profile/widgets/profile_items.dart';
import 'package:todo_app/utils/colors/app_colors.dart';
import 'package:todo_app/utils/images/app_images.dart';
import 'package:todo_app/utils/pick_image.dart';
import 'package:todo_app/utils/size/size_utils.dart';
import 'package:todo_app/utils/styles/app_text_style.dart';

import '../../routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}


class _ProfileScreenState extends State<ProfileScreen> {


  Uint8List? _image;

  void selectImageGallary ()async{
    Uint8List img=await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void selectImageCamera ()async{
    Uint8List img=await pickImage(ImageSource.camera);
    setState(() {
      _image = img;
    });
  }
 @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.getH(),
            Center(
                child: Column(
              children: [
                Text(
                  "Profile",
                  style: AppTextStyle.latoRegular.copyWith(fontSize: 20.w),
                ),
                  Stack(children: [
                    _image!=null?
                        CircleAvatar(radius: 64,
                        backgroundImage: MemoryImage(_image!),)
                        :
                    CircleAvatar(
                      radius: 64,
                        backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgVUEjaWnHvhNaEy1-Jl6Ljvi7ahounqegSQ&usqp=CAU"),
                    ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(onPressed: selectImagePicker, icon: Icon(Icons.add_a_photo, color: AppColors.white,),))
                  ],),
                Text(
                  "Martha Hays",
                  style: AppTextStyle.latoMedium.copyWith(fontSize: 20.w),
                ),
                20.getH(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 37.w, vertical: 17.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: AppColors.c_363636,
                          ),
                          child: Text(
                            "10 Task left",
                            style: AppTextStyle.latoRegular,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 37.w, vertical: 17.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.w),
                            color: AppColors.c_363636,
                          ),
                          child: Text(
                            "5 Task done",
                            style: AppTextStyle.latoRegular,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )),
            24.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Settings",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.h, color: AppColors.c_AFAFAF),
              ),
            ),
            4.getH(),
            ProfileItems(iconPath: AppImages.settings, title: "Change Category", onTab: (){Navigator.pushNamed(context, RouteNames.addCategory);},),
            16.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Account",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.h, color: AppColors.c_AFAFAF),
              ),
            ),
            ProfileItems(iconPath: AppImages.changeImage, title: "Change account Image", onTab: selectImagePicker),
            ProfileItems(iconPath: AppImages.profile, title: "Change account Name", onTab: (){}),
            16.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Uptodo",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.h, color: AppColors.c_AFAFAF),
              ),
            ),
            TextButton(
              onPressed: (){
                SystemNavigator.pop();
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(children: [
                  SvgPicture.asset(AppImages.logOut, height: 24.h,),
                  26.getW(),
                  Text("Log out", style: AppTextStyle.latoRegular.copyWith(color: AppColors.c_error),)
                ],),
              ),
            ),
            50.getH(),
          ],
        ),
      ),
    );
  }

  selectImagePicker(){
    return showModalBottomSheet(
        backgroundColor: AppColors.c_363636,
        context: context, builder: (context)=>
        Column(mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: AppColors.white,size: 40,),
              title: Text("Pick Camera", style: AppTextStyle.latoMedium,),
              onTap: (){selectImageCamera(); Navigator.pop(context);},
            ),
            ListTile(
              leading: Icon(Icons.image, color: AppColors.white,size: 40,),
              title: Text("Pick Gallery", style: AppTextStyle.latoMedium,),
              onTap: (){selectImageGallary(); Navigator.pop(context);},
            ),
          ],

        ));
  }
}


