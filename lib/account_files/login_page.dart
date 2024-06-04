import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:car_rental_app/account_files/create_account_page.dart';
import 'package:car_rental_app/account_files/account_page_providers.dart';
import 'package:car_rental_app/functions.dart';
import 'package:car_rental_app/home_page_files/home_page.dart';
import 'package:car_rental_app/manager_files/manager_page.dart';
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
                    child: const MailForm()),
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

class PasswordForm extends ConsumerWidget {
  const PasswordForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        obscureText: true,
        onChanged: (value) {
          ref.read(passwordProvider.notifier).state = value;
        },
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

class MailForm extends ConsumerWidget {
  const MailForm({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) {
          ref.read(emailProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          counterText: "",
          hintText: "Mail",
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
          ),
        ));
  }
}

class LoginButton extends ConsumerWidget {
  const LoginButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await Future.delayed(const Duration(seconds: 2));
        if (ref.watch(emailProvider) == "admin@admin.com" ||
            ref.watch(passwordProvider) == "admin") {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const ManagerPage(),
              ));
        } else if (await loginMethod(ref, context) == true) {
          debugPrint(ref.watch(tcProvider).toString());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
        }
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

  Future<bool> loginMethod(WidgetRef ref, BuildContext context) async {
    final response = await http.post(
      Uri.parse('http://localhost:3001/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'mail': ref.watch(emailProvider),
        'password': ref.watch(passwordProvider),
      }),
    );

    if (response.statusCode == 200) {
      debugPrint("Başarılı" + response.statusCode.toString());
      final data = jsonDecode(response.body);
      final tc = data['tc'];
      // Örnek olarak 'tc' isminde bir alan varsayıyorum
      ref.read(tcProvider.notifier).state = tc;
      return true;
    } else {
      debugPrint(response.statusCode.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Failed')));
      return false;
    }
  }
}
