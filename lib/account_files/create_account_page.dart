import 'package:car_rental_app/account_files/account_page_providers.dart';
import 'package:car_rental_app/account_files/login_page.dart';
import 'package:car_rental_app/functions.dart';
import 'package:car_rental_app/home_page_files/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 820.6),
      minTextAdapt: false,
      splitScreenMode: false,
      builder: (context, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 30.h, left: 30.w),
                    child: const BackPageButton(),
                  ),
                  SizedBox(height: 5.h),
                  const Center(
                    child: RegisterThemeText(),
                  ),
                  SizedBox(height: 40.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: const TcForCreateAccount(),
                  ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: const NameForRegister(),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: const SurnameFormRegister(),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: const MailFormRegister(),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: const PasswordFormRegister(),
                  ),
                  SizedBox(height: 5.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: const RePasswordFormRegister(),
                  ),
                  SizedBox(height: 20.h),
                  const Center(child: CreateButton()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class RegisterThemeText extends StatelessWidget {
  const RegisterThemeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text("RentEasy",
        style: GoogleFonts.berkshireSwash(
            textStyle: TextStyle(
          fontSize: 50.h,
          color: Colors.red,
          fontWeight: FontWeight.w600,
        )));
  }
}

class BackPageButton extends ConsumerWidget {
  const BackPageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await resetProviders(ref);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      },
      child: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: appBarColor),
        ),
        child: Icon(
          Icons.arrow_back_sharp,
          color: appBarColor,
        ),
      ),
    );
  }
}

class PasswordFormRegister extends ConsumerWidget {
  const PasswordFormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        enableInteractiveSelection: false,
        onChanged: (value) {
          ref.read(passwordProvider.notifier).state = value;
        },
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

class RePasswordFormRegister extends ConsumerWidget {
  const RePasswordFormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        enableInteractiveSelection: false,
        onChanged: (value) {
          ref.read(rpasswordProvider.notifier).state = value;
        },
        obscureText: true,
        decoration: InputDecoration(
          hintText: "Şifrenizi Doğrulayın",
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

class SurnameFormRegister extends ConsumerWidget {
  const SurnameFormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        enableInteractiveSelection: false,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          ref.read(accountSurnameProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: "Soyad",
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

class NameForRegister extends ConsumerWidget {
  const NameForRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        enableInteractiveSelection: false,
        keyboardType: TextInputType.name,
        onChanged: (value) {
          ref.read(accountNameProvider.notifier).state = value;
        },
        decoration: InputDecoration(
          hintText: "İsim",
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

class TcForCreateAccount extends ConsumerWidget {
  const TcForCreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        maxLength: 11,
        enableInteractiveSelection: false,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          ref.read(tcProvider.notifier).state = int.parse(value);
        },
        inputFormatters: [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        decoration: InputDecoration(
          counterText: "",
          hintText: "TC",
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

class MailFormRegister extends ConsumerWidget {
  const MailFormRegister({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        onChanged: (value) {
          ref.read(emailProvider.notifier).state = value;
        },
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "Email",
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

class CreateButton extends ConsumerWidget {
  const CreateButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        if (validate(ref) == true) {
          ref.read(isLoading.notifier).state = true;
          await Future.delayed(const Duration(seconds: 2));
          try {
            await Future.delayed(const Duration(seconds: 5));
            await _register(ref, context);

            await resetProviders(ref);

            /*   Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginPage()),
            ); */
          } catch (e) {
            debugPrint("hata");
            errorDialog(context, "Sunucu Hatası", 30.h);
          } finally {
            ref.read(isLoading.notifier).state = false;
          }
        } else {
          errorDialog(context, "Girilen Bilgiler Yanlış veya Eksik", 18.h);
        }
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: appBarColor, borderRadius: BorderRadius.circular(30)),
        child: Center(
          child: ref.watch(isLoading)
              ? const SpinKitFadingCircle(
                  color: Colors.white,
                  size: 30,
                )
              : Text(
                  "Kayıt Ol",
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

  Future<void> _register(WidgetRef ref, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:3001/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'tc': ref.watch(tcProvider),
          'ad': ref.watch(accountNameProvider),
          'soyad': ref.watch(accountSurnameProvider),
          'mail': ref.watch(emailProvider),
          'password': ref.watch(passwordProvider)
        }),
      );
      ref.read(statusProvider.notifier).state = response.statusCode;
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Kayıt başarılı!')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Kayıt başarısız!')));
      }
    } catch (e) {
      print('Hata oluştu: $e');
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Bir hata oluştu. Lütfen tekrar deneyin.')));
    }
  }
}

bool validate(WidgetRef ref) {
  final tc = ref.watch(tcProvider);
  final name = ref.watch(accountNameProvider);
  final surname = ref.watch(accountSurnameProvider);
  final email = ref.watch(emailProvider);
  final pw = ref.watch(passwordProvider);
  final rpw = ref.watch(rpasswordProvider);

  if (name.isNotEmpty &&
      surname.isNotEmpty &&
      RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email) &&
      pw == rpw) {
    return true;
  } else {
    return false;
  }
}

Future<void> resetProviders(WidgetRef ref) async {
  ref.invalidate(tcProvider);
  ref.invalidate(accountNameProvider);
  ref.invalidate(accountSurnameProvider);
  ref.invalidate(emailProvider);
  ref.invalidate(passwordProvider);
  ref.invalidate(rpasswordProvider);
}
