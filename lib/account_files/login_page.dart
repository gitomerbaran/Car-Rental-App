import 'package:car_rental_app/account_files/create_account_page.dart';
import 'package:car_rental_app/account_files/account_page_providers.dart';
import 'package:car_rental_app/functions.dart';
import 'package:car_rental_app/home_page_files/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                const MyAppBar(),
                SizedBox(height: 100.h),
                const ThemeText(),
                SizedBox(height: 50.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: const UserNameForm()),
                SizedBox(height: 20.h),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.w),
                    child: const PasswordForm()),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.w),
                  child: const MyRowWidget(),
                ),
                SizedBox(height: 40.h),
                const LoginButton(),
                SizedBox(height: 40.h),
                const CreateAccountButton(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class MyRowWidget extends StatelessWidget {
  const MyRowWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const CheckBox(),
        Padding(
          padding: EdgeInsets.only(left: 5.w),
          child: Text(
            "Beni Hatırla",
            style: GoogleFonts.roboto(
                textStyle: TextStyle(
              fontSize: 14.h,
            )),
          ),
        )
      ],
    );
  }
}

class CreateAccountButton extends StatelessWidget {
  const CreateAccountButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ));
      },
      child: Text(
        "Hesabın yok mu ?",
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          fontSize: 13.h,
          decoration: TextDecoration.underline,
          decorationColor: appBarColor,
          color: appBarColor,
        )),
      ),
    );
  }
}

class CheckBox extends ConsumerWidget {
  const CheckBox({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Checkbox(
      activeColor: appBarColor,
      value: ref.watch(isChecking),
      onChanged: (value) {
        ref.read(isChecking.notifier).state = value!;
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Veritabanı ve doğrulama
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: appBarColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: Text(
            "Giriş Yap",
            style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600)),
          ),
        ),
      ),
    );
  }
}

class PasswordForm extends StatelessWidget {
  const PasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Şifre",
          hintStyle: fonts,
          isCollapsed: false,
          contentPadding: const EdgeInsets.only(left: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: appBarColor, width: 1.5)),
        ),
      ),
    );
  }
}

class UserNameForm extends StatelessWidget {
  const UserNameForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        decoration: InputDecoration(
          hintText: "Kullanıcı adı",
          hintStyle: fonts,
          isCollapsed: false,
          contentPadding: const EdgeInsets.only(left: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(color: appBarColor, width: 1.5)),
        ),
      ),
    );
  }
}

class ThemeText extends StatelessWidget {
  const ThemeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("RentEasy",
        style: GoogleFonts.berkshireSwash(
            textStyle: TextStyle(
          fontSize: 60.h,
          color: Colors.red,
          fontWeight: FontWeight.w600,
        )));
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100.h,
        width: double.infinity,
        decoration: BoxDecoration(color: appBarColor),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 30.h),
            /* child: Text("RentEasy",
                style: GoogleFonts.berkshireSwash(
                    textStyle: TextStyle(
                  fontSize: 40.h,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ))), */
          ),
        ));
  }
}
