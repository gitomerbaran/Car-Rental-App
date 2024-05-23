import 'package:car_rental_app/functions.dart';
import 'package:car_rental_app/home_page_files/home_page_provider.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 820.6),
      minTextAdapt: false,
      splitScreenMode: false,
      builder: (_, child) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              const HomePageAppBar(),
              SizedBox(height: 20.h),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: Icon(
                      Icons.person,
                      color: appBarColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.w),
                    child: const NameWidget(),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 120.w),
                    child: Container(
                      width: 100.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(width: 2, color: appBarColor)),
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 3.w),
                          const BalanceIcon(),
                          SizedBox(width: 10.w),
                          const Text(
                            ":",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 15.w),
                          const BalanceText()
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 5.w,
                    ),
                    child: const AddBalanceButton(),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: appBarColor,
                      width: 3,
                    ),
                  ),
                  height: 150.h, // Sabit yükseklik
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return PageView(
                        children: [
                          CommitWidget(
                            rating: 4,
                            name: "Ali K***",
                          ),
                          CommitWidget(rating: 4.5, name: "Canan T***"),
                          CommitWidget(rating: 3.5, name: "Talha B***"),
                          CommitWidget(rating: 5, name: "Berkay S***"),
                          CommitWidget(rating: 4.5, name: "Selin K***"),
                        ],
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              //Şehir seçimi
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: appBarColor, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Alış Yeri",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 13, color: appBarColor)),
                          ),
                          SizedBox(height: 5),
                          const FirstCity(),
                        ],
                      )),
                  SizedBox(width: 30.w),
                  ChangeCityButton(),
                  SizedBox(width: 30.w),
                  Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: appBarColor, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Varış Yeri",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 13, color: appBarColor)),
                          ),
                          SizedBox(height: 5),
                          const SecondCity(),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 10.h),
              // Araç modeli ve Marka
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: appBarColor, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Araç Türü",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 13, color: appBarColor)),
                          ),
                          SizedBox(height: 5),
                          const VehicleType(),
                        ],
                      )),
                  SizedBox(width: 88.w),
                  Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: appBarColor, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Marka",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 13, color: appBarColor)),
                          ),
                          SizedBox(height: 5),
                          const VehicleBrand(),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 10.h),
              // Tarih
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 80,
                      width: 120,
                      decoration: BoxDecoration(
                          border: Border.all(color: appBarColor, width: 2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Kiralam Süresi",
                            style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                    fontSize: 13, color: appBarColor)),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              RentTime(),
                              CalendarWidget(),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(height: 40.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 130.w),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: appBarColor,
                    ),
                    child: Center(
                        child: Text(
                      "Ara",
                      style: GoogleFonts.roboto(
                          textStyle: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w500),
                          fontSize: 20),
                    )),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class CalendarWidget extends ConsumerWidget {
  const CalendarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () => showDialog(
        builder: (context) => Dialog(
          child: Container(
            height: 300.h,
            width: 100.w,
            child: Material(
              child: RangeDatePicker(
                onRangeSelected: (value) {
                  debugPrint(value.toString());
                  debugPrint(
                      ref.watch(purchaseDate(value.toString())).toString());
                },
                daysOfTheWeekTextStyle: calendarFunction(13, FontWeight.w500),
                enabledCellsTextStyle: calendarFunction(20, FontWeight.w400),
                maxDate: DateTime(2025),
                minDate: DateTime.now(),
              ),
            ),
          ),
        ),
        context: context,
      ),
      child: Icon(
        Icons.calendar_month,
        color: appBarColor,
        size: 18,
      ),
    );
  }
}

class RentTime extends ConsumerWidget {
  const RentTime({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      //ref.watch(rentTimeProvider).toString(),
      "0",
      style: GoogleFonts.roboto(fontSize: 18),
    );
  }
}

class VehicleBrand extends ConsumerWidget {
  const VehicleBrand({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<String>(
      underline: DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedVehicleType),
        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: ref
          .watch(vehicleTypeListP)
          .map<DropdownMenuItem<String>>((String vehicleType) {
        return DropdownMenuItem<String>(
          value: vehicleType,
          child: Text(
            vehicleType,
            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 10)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(selectedVehicleType.notifier).state = value!;
      },
    );
  }
}

class VehicleType extends ConsumerWidget {
  const VehicleType({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<String>(
      underline: DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedVehicleType),
        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: ref
          .watch(vehicleTypeListP)
          .map<DropdownMenuItem<String>>((String vehicleType) {
        return DropdownMenuItem<String>(
          value: vehicleType,
          child: Text(
            vehicleType,
            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 10)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(selectedVehicleType.notifier).state = value!;
      },
    );
  }
}

class ChangeCityButton extends ConsumerWidget {
  const ChangeCityButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      //değişim yapan buton
      onTap: () {},
      child: Icon(
        Icons.change_circle,
        color: appBarColor,
        size: 30.h,
      ),
    );
  }
}

class SecondCity extends ConsumerWidget {
  const SecondCity({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<String>(
      underline: DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selecedSecondCity),
        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: cities.map<DropdownMenuItem<String>>((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            city,
            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 10)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(selecedSecondCity.notifier).state = value!;
      },
    );
  }
}

class FirstCity extends ConsumerWidget {
  const FirstCity({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<String>(
      underline: DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedCity),
        style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: cities.map<DropdownMenuItem<String>>((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            city,
            style: GoogleFonts.roboto(textStyle: TextStyle(fontSize: 10)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(selectedCity.notifier).state = value!;
      },
    );
  }
}

class AddBalanceButton extends StatelessWidget {
  const AddBalanceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //Bakiye yükleme sayfası
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            shape: BoxShape.circle,
            color: appBarColor),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}

class BalanceText extends ConsumerWidget {
  const BalanceText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(balanceProvider),
      style: TextStyle(fontSize: 15.h, fontWeight: FontWeight.w600),
    );
  }
}

class BalanceIcon extends StatelessWidget {
  const BalanceIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 1.5,
        ),
        color: Colors.amber,
      ),
      child: Center(
        child: Icon(
          Icons.attach_money,
          size: 20.h,
        ),
      ),
    );
  }
}

class NameWidget extends ConsumerWidget {
  const NameWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      "Hoşgeldin ${ref.watch(nameProvider)}",
      style: GoogleFonts.roboto(
          textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    );
  }
}

class RentButton extends StatelessWidget {
  const RentButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Araç Kiralama sayfası
      },
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
            color: appBarColor, borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Icon(
                Icons.drive_eta,
                color: Colors.white,
                size: 35,
              ),
              SizedBox(height: 5.h),
              Text(
                "Kirala",
                style: GoogleFonts.roboto(
                    textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageAppBar extends StatelessWidget {
  const HomePageAppBar({
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
            child: Text("RentEasy",
                style: GoogleFonts.berkshireSwash(
                    textStyle: TextStyle(
                  fontSize: 40.h,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ))),
          ),
        ));
  }
}

class CommitWidget extends StatelessWidget {
  double rating;
  String name;
  CommitWidget({super.key, required this.rating, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.person,
                color: appBarColor,
                size: 30,
              ),
              Text(
                name,
                style: GoogleFonts.roboto(
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              RatingBar.builder(
                ignoreGestures: true,
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  null;
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
