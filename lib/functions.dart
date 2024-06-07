import 'package:car_rental_app/account_files/account_page_providers.dart';
import 'package:car_rental_app/home_page_files/home_page_provider.dart';
import 'package:car_rental_app/home_page_files/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'home_page_files/home_page.dart';

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
    await Future.delayed(const Duration(seconds: 2));

    await getCars(ref);
    await rentPage(context, ref);
    ref.invalidate(vehicleListProvider);
  } catch (e) {
    errorDialog(context, "Araç Bulunamadı", 20.h);
    print("çalışmadı rentpagetarafi");
  } finally {
    ref.read(isLoading.notifier).state = false;
  }

  // İşlem tamamlandığında sonucu göster
}

Future<void> errorDialog(BuildContext context, String text, double size) {
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
              Center(
                child: Text(
                  text,
                  style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                    fontSize: size,
                  )),
                ),
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
                            const TextStyle(fontSize: 20, color: Colors.white)),
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
                          ref.read(vehicleListProvider).clear();

                          Navigator.pop(context);
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
                                  color: Color.fromARGB(255, 245, 242, 242),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Color.fromARGB(255, 163, 161, 161),
                                      offset: Offset(1, 3),
                                    )
                                  ]),
                              height: 400.h,
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
                                                  "Plaka:", vehicle.vPlate),
                                              vehicleCardText(
                                                  "Marka:", vehicle.vBrand),
                                              vehicleCardText(
                                                  "Araç Türü:", vehicle.vType),
                                              vehicleCardText(
                                                  "Model:", vehicle.vModel),
                                              vehicleCardText(
                                                  "Renk:", vehicle.vColor),
                                              vehicleCardText("Vites Türü:",
                                                  vehicle.vTransmitter),
                                              vehicleCardText(
                                                  "Yakıt:", vehicle.vFuel),
                                              vehicleCardText("Kapı Adeti:",
                                                  vehicle.vDoor.toString()),
                                              vehicleCardText(
                                                  "KM:", vehicle.vKm),
                                              vehicleCardText("Yıl:",
                                                  vehicle.vYear.toString()),
                                              vehicleCardText("Fiyat",
                                                  vehicle.vPrice.toString()),
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
                                        onTap: () async {
                                          debugPrint(vehicle.vPlate +
                                              "+" +
                                              ref.watch(tcProvider).toString());
                                          //Kiralama İşlemi
                                          await sendRentCar(ref,
                                              plate: vehicle.vPlate,
                                              destination:
                                                  ref.watch(selectedSecondCity),
                                              takeTime: "2024-08-3",
                                              releaseTime: "2024-12-8",
                                              musteriTc: ref.watch(tcProvider));
                                          debugPrint("çalıştım rent");
                                          ref
                                              .read(
                                                  vehicleListProvider.notifier)
                                              .state = [];

                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: appBarColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              boxShadow: const [
                                                BoxShadow(
                                                    color: Color.fromARGB(
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
        "$title ",
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

Future addBalanceMethod(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  return await showDialog<Future>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 120.h),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
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
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: appBarColor,
                          size: 30,
                        ),
                      ),
                      // SizedBox(width: 80.w),
                      Expanded(
                        child: Center(
                          child: Text("Bakiye Yükleme",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.berkshireSwash(
                                  textStyle: TextStyle(
                                fontSize: 20.h,
                                color: appBarColor,
                                fontWeight: FontWeight.w600,
                              ))),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                const BalanceInputs(
                  maxL: 16,
                  hintText: "Kart Numarası",
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 15.h),
                const BalanceInputs(
                    maxL: 30,
                    hintText: "Adı-Soyadı",
                    keyboardType: TextInputType.name),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 100.w,
                        child: Form(
                          child: TextFormField(
                            controller: controller,
                            onChanged: (value) {
                              if (value.length == 3 && !value.contains('/')) {
                                value =
                                    '${value.substring(0, 2)}/${value.substring(2)}';
                              }
                              controller.value = TextEditingValue(
                                text: value,
                                selection: TextSelection.collapsed(
                                    offset: value.length),
                              );
                            },
                            maxLength: 5,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                counterText: "",
                                hintStyle: GoogleFonts.roboto(),
                                hintText: "Ay/Yıl",
                                isCollapsed: false,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: appBarColor,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: appBarColor)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: appBarColor,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Form(
                          child: TextFormField(
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                counterText: "",
                                hintStyle: GoogleFonts.roboto(),
                                hintText: "CCV",
                                isCollapsed: false,
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: appBarColor,
                                    )),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                disabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: appBarColor)),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: appBarColor,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                BalanceInput(balanceController: balanceController),
                SizedBox(height: 30.h),
                const GetBalanceButton()
              ],
            ),
          ),
        ),
      );
    },
  );
}
