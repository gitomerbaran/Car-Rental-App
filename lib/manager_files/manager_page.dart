import 'package:car_rental_app/functions.dart';
import 'package:car_rental_app/home_page_files/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 820.6),
      minTextAdapt: false,
      splitScreenMode: false,
      builder: (_, child) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const HomePageAppBar(),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: const ManagerTextWidget(),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                    child: Container(
                      width: double.infinity,
                      height: 800.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: appBarColor,
                          width: 1.3,
                        ),
                      ),
                      child: Column(
                        children: [
                          PrimaryText(),
                          CustomInputWigdet(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class CustomInputWigdet extends ConsumerWidget {
  const CustomInputWigdet({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w),
      child: Form(
          child: TextFormField(
        decoration: InputDecoration(
            hintText: "text",
            hintStyle: fonts,
            isCollapsed: false,
            contentPadding: const EdgeInsets.only(left: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide(color: appBarColor, width: 1.5)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: appBarColor, width: 1.5))),
      )),
    );
  }
}

class PrimaryText extends StatelessWidget {
  const PrimaryText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Araç Ekle",
      style: GoogleFonts.roboto(
          textStyle: TextStyle(
              fontSize: 20.h, color: appBarColor, fontWeight: FontWeight.w500)),
    );
  }
}

class ManagerTextWidget extends StatelessWidget {
  const ManagerTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: const Offset(0, 3),
        ),
      ]),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: appBarColor,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        height: 100.h,
        width: double.infinity,
        child: Center(
          child: Text("Yönetici Paneli",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                fontSize: 30.h,
                color: appBarColor,
                fontWeight: FontWeight.w600,
              ))),
        ),
      ),
    );
  }
}
