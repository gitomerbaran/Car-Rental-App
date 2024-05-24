import 'package:car_rental_app/home_page_files/home_page_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

Color appBarColor = Colors.red;
TextStyle fonts = GoogleFonts.roboto();
TextStyle calendarFunction(double fontsize, FontWeight fontWeight) {
  return GoogleFonts.roboto(
    textStyle: TextStyle(fontSize: fontsize, fontWeight: fontWeight),
  );
}

Future<void> performDatabaseOperation(
    WidgetRef ref, BuildContext context) async {
  ref.read(isLoading.notifier).state = true;

  try {
    // Veritabanı işlemini burada gerçekleştir
    // Bu kısmı kendi veritabanı sorgunuzla değiştirin
    await Future.delayed(
        Duration(seconds: 4)); // Bu, veritabanı işleminizi temsil ediyor
  } catch (e) {
    // Hata durumunda yapılacak işlemler
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veritabanı işlemi başarısız oldu: $e')));
  } finally {
    ref.read(isLoading.notifier).state = false;
  }

  // İşlem tamamlandığında sonucu göster
  showDialog(
    context: context,
    builder: (context) {
      return Dialog();
    },
  );
}
