import 'dart:convert';
import 'package:todo_app/data/local/storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
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
  Image? _image;

  void selectImageGallery() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {});
  }

  void selectImageCamera() async {
    Uint8List img = await pickImage(ImageSource.camera);
    String base64Img = StorageRepository.base64String(img);
    StorageRepository.setString(key: "image", value: base64Img);
    Uint8List bytes = base64Decode(StorageRepository.getString(key: "image"));
    setState(() {
      _image = Image.memory(bytes);
    });
    debugPrint("Saqlangan $base64Img");

    debugPrint("O'qib olingan ${StorageRepository.getString(key: "image")}");
  }
  String? profileName;
  _init(){
    profileName=StorageRepository.getString(key: "profileName");
    setState(() {
    });
  }
  //
  // @override
  // void initState() {
  //   _init();
  //   super.initState();
  // }


  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            40.getH(),
            Center(
                child: Column(
              children: [
                Text(
                  "Profile",
                  style: AppTextStyle.latoRegular.copyWith(fontSize: 20.w),
                ),
                20.getH(),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 64.w, backgroundImage: _image!.image)
                        : CircleAvatar(
                            radius: 64.w,
                            backgroundImage: const NetworkImage(
                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgVUEjaWnHvhNaEy1-Jl6Ljvi7ahounqegSQ&usqp=CAU"),
                          ),
                    Positioned(
                        bottom: 10.h,
                        left: 80.w,
                        child: IconButton(
                          onPressed: selectImagePicker,
                          icon: Icon(
                            Icons.add_a_photo,
                            color: AppColors.white,
                            size: 40.h,
                          ),
                        ))
                  ],
                ),
                20.getH(),
                Text(
                  profileName?? "Your profile name",
                  style: AppTextStyle.latoMedium.copyWith(fontSize: 20.w),
                ),

              ],
            )),
            24.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Settings",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.w, color: AppColors.c_AFAFAF),
              ),
            ),
            4.getH(),
            ProfileItems(
              iconPath: AppImages.settings,
              title: "Create new Category",
              onTab: () {
                Navigator.pushNamed(context, RouteNames.addCategory);
              },
            ),
            16.getH(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Text(
                "Account",
                style: AppTextStyle.latoRegular
                    .copyWith(fontSize: 14.w, color: AppColors.c_AFAFAF),
              ),
            ),
            ProfileItems(
                iconPath: AppImages.changeImage,
                title: "Change account Image",
                onTab: selectImagePicker),
            ProfileItems(
                iconPath: AppImages.profile,
                title: "Change account Name",
                onTab: () {
                  showModalBottomSheet(isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.w), topRight: Radius.circular(16.w))),
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: (context, setState) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16.w),
                                      topRight: Radius.circular(16.w)),
                                  color: AppColors.c_363636),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Account name",
                                    style: AppTextStyle.latoBold.copyWith(fontSize: 20.w),
                                  ),
                                  14.getH(),
                                  TextField(
                                    style: AppTextStyle.latoBold,
                                    onChanged: (v) {
                                      name=v;
                                      StorageRepository.setString(key: "profileName", value: name);
                                    },
                                    decoration: InputDecoration(

                                        floatingLabelBehavior: FloatingLabelBehavior.always,
                                        fillColor: Colors.transparent,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 14.h),
                                        hintText: "Enter you new profile name",
                                        hintStyle: AppTextStyle.latoRegular
                                            .copyWith(fontSize: 18.w, color: AppColors.c_AFAFAF),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppColors.transparent),
                                            borderRadius: BorderRadius.circular(4.w)),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(color: AppColors.c_AFAFAF),
                                            borderRadius: BorderRadius.circular(4.w))),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 37.w, vertical: 17.h),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.w),
                                              color: AppColors.c_363636,
                                            ),
                                            child: Text(
                                              "Cancel",
                                              style: AppTextStyle.latoRegular
                                                  .copyWith(color: AppColors.c_8687E7),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState((){
                                              _init();

                                            });
                                            Navigator.pop(context);

                                          },
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 37.w, vertical: 17.h),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(4.w),
                                              color: AppColors.c_8687E7,
                                            ),
                                            child: Text(
                                              "Save",
                                              style: AppTextStyle.latoRegular,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )



                                ],
                              ),
                            ),
                          );
                        });
                      } );

                }),
            16.getH(),
            TextButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>AlertDialog(
                      backgroundColor: AppColors.c_272727,
                      content: Text('Are you sure you want to log out', style: AppTextStyle.latoBold.copyWith(fontSize: 22.w),textAlign: TextAlign.center,),
                      actions: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25.w, vertical: 17.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.w),
                                      color: AppColors.c_363636,
                                    ),
                                    child: Text(
                                      "No",
                                      style: AppTextStyle.latoRegular
                                          .copyWith(color: AppColors.c_8687E7),
                                    ),
                                  ),
                                ),
                                15.getW(),
                                TextButton(
                                  onPressed: () {
                                    SystemNavigator.pop();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 25.w, vertical: 17.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.w),
                                      color: AppColors.c_8687E7,
                                    ),
                                    child: Text(
                                      "Yes",
                                      style: AppTextStyle.latoRegular,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ));

              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      AppImages.logOut,
                      height: 24.h,
                    ),
                    26.getW(),
                    Text(
                      "Log out",
                      style: AppTextStyle.latoRegular
                          .copyWith(color: AppColors.c_error),
                    )
                  ],
                ),
              ),
            ),
            50.getH(),
          ],
        ),
      ),
    );
  }

  selectImagePicker() {
    return showModalBottomSheet(
        backgroundColor: AppColors.c_363636,
        context: context,
        builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                20.getH(),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppColors.white,
                    size: 40.w,
                  ),
                  title: Text(
                    "Pick Camera",
                    style: AppTextStyle.latoMedium,
                  ),
                  onTap: () {
                    selectImageCamera();
                    Navigator.pop(context);
                  },
                ),
                20.getH(),
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: AppColors.white,
                    size: 40.w,
                  ),
                  title: Text(
                    "Pick Gallery",
                    style: AppTextStyle.latoMedium,
                  ),
                  onTap: () {
                    selectImageGallery();
                    Navigator.pop(context);
                  },
                ),
                20.getH(),
              ],
            ));
  }
}
