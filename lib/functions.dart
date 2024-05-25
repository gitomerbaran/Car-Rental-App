import 'package:car_rental_app/home_page_files/home_page_provider.dart';
import 'package:car_rental_app/home_page_files/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    await Future.delayed(Duration(seconds: 2));
    rentPage(context, ref);
  } catch (e) {
    errorDialog(context);
  } finally {
    ref.read(isLoading.notifier).state = false;
  }

  // İşlem tamamlandığında sonucu göster
}

Future<void> errorDialog(BuildContext context) {
  return showDialog<Future>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 100.w,
          height: 200.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.error_outline,
                color: appBarColor,
                size: 60,
              ),
              Text(
                "Araç Bulunamadı",
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                  fontSize: 25,
                )),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 30.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: appBarColor),
                  child: Text(
                    textAlign: TextAlign.center,
                    "Kapat",
                    style: GoogleFonts.roboto(
                        textStyle:
                            TextStyle(fontSize: 20, color: Colors.white)),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    },
  );

  ;
}

Future<void> rentPage(BuildContext context, WidgetRef ref) {
  return showDialog<Future>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30), color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h, left: 20.w),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          debugPrint(ref.watch(vehicleListProvider).toString());
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: appBarColor,
                          size: 30,
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text("RentEasy",
                              style: GoogleFonts.berkshireSwash(
                                  textStyle: TextStyle(
                                fontSize: 25.h,
                                color: appBarColor,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: ref.watch(vehicleListProvider).length,
                    itemBuilder: (context, index) {
                      final vehicle = ref.watch(vehicleListProvider)[index];
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          children: [
                            SizedBox(height: 15.h),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 247, 239, 239),
                                  boxShadow: [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color.fromARGB(255, 163, 161, 161),
                                      offset: Offset(1, 3),
                                    )
                                  ]),
                              height: 150.h,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 10.w, vertical: 10.h),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              vehicleCardText(
                                                  "Marka", vehicle.vName),
                                              vehicleCardText(
                                                  "Model", vehicle.vYear),
                                              vehicleCardText("Kilometre",
                                                  vehicle.kilometers),
                                            ],
                                          ),
                                          Icon(
                                            Icons.car_rental,
                                            color: appBarColor,
                                            size: 50,
                                          ),
                                        ],
                                      ),
                                      InkWell(
                                        onTap: () {
                                          //Kiralama İşlemi
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: appBarColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: const Color.fromARGB(
                                                        255, 135, 129, 129),
                                                    blurRadius: 5,
                                                    offset: Offset(0, 1))
                                              ]),
                                          child: Center(
                                            child: Text(
                                              textAlign: TextAlign.center,
                                              "Rent",
                                              style: GoogleFonts.roboto(
                                                  textStyle: TextStyle(
                                                      fontSize: 15.h,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Widget vehicleCardText(String title, String data) {
  return Row(
    children: [
      Text(
        title + ": ",
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          fontSize: 15.h,
          fontWeight: FontWeight.w700,
          color: appBarColor,
        )),
      ),
      Text(
        data,
        style: GoogleFonts.roboto(
            textStyle: TextStyle(
          fontSize: 15.h,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        )),
      ),
    ],
  );
}
