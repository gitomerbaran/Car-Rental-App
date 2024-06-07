import 'package:auto_size_text/auto_size_text.dart';
import 'package:car_rental_app/functions.dart';
import 'package:car_rental_app/home_page_files/home_page_provider.dart';
import 'package:car_rental_app/home_page_files/models.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const HomePageAppBar(),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Icon(
                        Icons.person,
                        color: appBarColor,
                      ),
                    ),
                    const NameWidget(),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 9,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Container(
                        width: 100.w,
                        height: 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: appBarColor),
                        ),
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
                            const BalanceText(),
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
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: appBarColor,
                          width: 1.3,
                        ),
                      ),
                      height: 150.h,
                      width: double.infinity,
                      child: PageView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return CarouselSlider(
                            options: CarouselOptions(
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              enlargeCenterPage: false,
                              padEnds: false,
                              viewportFraction: 1,
                              aspectRatio: 2.0,
                            ),
                            items: [
                              CommitWidget(
                                rating: 4,
                                name: "Ali K***",
                                text: commits[0],
                              ),
                              CommitWidget(
                                rating: 4.5,
                                name: "Canan T***",
                                text: commits[1],
                              ),
                              CommitWidget(
                                rating: 3.5,
                                name: "Talha B***",
                                text: commits[2],
                              ),
                              CommitWidget(
                                rating: 5,
                                name: "Berkay S***",
                                text: commits[3],
                              ),
                              CommitWidget(
                                rating: 4.5,
                                name: "Selin K***",
                                text: commits[4],
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
                //Şehir seçimi
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 20,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              const SizedBox(height: 5),
                              const FirstCity(),
                            ],
                          )),
                    ),
                    SizedBox(width: 30.w),
                    const ChangeCityButton(),
                    SizedBox(width: 30.w),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 20,

                            offset: const Offset(0, 2), // Gölgenin konumu
                          ),
                        ],
                      ),
                      child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              const SizedBox(height: 5),
                              const SecondCity(),
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Araç modeli ve Marka
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 20,

                            offset: const Offset(0, 2), // Gölgenin konumu
                          ),
                        ],
                      ),
                      child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              const SizedBox(height: 5),
                              const VehicleType(),
                            ],
                          )),
                    ),
                    SizedBox(width: 88.w),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 20,

                            offset: const Offset(0, 2), // Gölgenin konumu
                          ),
                        ],
                      ),
                      child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              const SizedBox(height: 5),
                              const VehicleBrand(),
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Tarih
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 20,

                            offset: const Offset(0, 2), // Gölgenin konumu
                          ),
                        ],
                      ),
                      child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              const SizedBox(height: 5),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RentTime(),
                                  CalendarWidget(),
                                ],
                              ),
                            ],
                          )),
                    ),
                    SizedBox(width: 88.w),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 0,
                            blurRadius: 20,

                            offset: const Offset(0, 2), // Gölgenin konumu
                          ),
                        ],
                      ),
                      child: Container(
                          height: 80,
                          width: 120,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: appBarColor, width: 2),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Model",
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        fontSize: 13, color: appBarColor)),
                              ),
                              const SizedBox(height: 5),
                              const VehicleModel(),
                            ],
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 130.w),
                  child: const FindButton(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class FindButton extends ConsumerWidget {
  const FindButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        await performDatabaseOperation(ref, context);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: appBarColor,
        ),
        child: Center(
            child: ref.watch(isLoading)
                ? const SpinKitFadingCircle(
                    color: Colors.white,
                    size: 30,
                  )
                : Text(
                    "Ara",
                    style: GoogleFonts.roboto(
                        textStyle: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                        fontSize: 20),
                  )),
      ),
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
          child: SizedBox(
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
      "Gün:  ${ref.watch(rentTimeProvider)}",
      style: GoogleFonts.roboto(fontSize: 16),
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
      underline: const DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedVehicleBrand),
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: ref
          .watch(vehicleBrandsListNotifier)
          .map<DropdownMenuItem<String>>((String vehicleType) {
        return DropdownMenuItem<String>(
          value: vehicleType,
          child: Text(
            vehicleType,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 10)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(selectedVehicleBrand.notifier).state = value!;
      },
    );
  }
}

class VehicleModel extends ConsumerWidget {
  const VehicleModel({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DropdownButton<String>(
      underline: const DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedModel),
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: ref
          .watch(vehicleModelsNotifier)
          .map<DropdownMenuItem<String>>((String vehicleModel) {
        return DropdownMenuItem<String>(
          value: vehicleModel,
          child: Text(
            vehicleModel,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 10)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(selectedModel.notifier).state = value!;
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
      underline: const DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedVehicleType),
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: ref
          .watch(vehicleTypesNotifier)
          .map<DropdownMenuItem<String>>((String vehicleType) {
        return DropdownMenuItem<String>(
          value: vehicleType,
          child: Text(
            vehicleType,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 10)),
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
      onTap: () {
        String first = ref.watch(selectedCity);
        String last = ref.watch(selectedSecondCity);
        ref.read(selectedSecondCity.notifier).state = first;
        ref.read(selectedCity.notifier).state = last;
      },
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
      underline: const DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedSecondCity),
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: ref
          .watch(getCityNotifier)
          .map<DropdownMenuItem<String>>((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            city,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 10)),
          ),
        );
      }).toList(),
      onChanged: (value) {
        ref.read(selectedSecondCity.notifier).state = value!;
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
      underline: const DropdownButtonHideUnderline(child: SizedBox()),
      iconDisabledColor: appBarColor,
      iconEnabledColor: appBarColor,
      hint: Text(
        ref.watch(selectedCity),
        style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 12)),
      ),
      borderRadius: BorderRadius.circular(20),
      menuMaxHeight: 200.h,
      style: GoogleFonts.roboto(
        textStyle: const TextStyle(fontSize: 10, color: Colors.black),
      ),
      items: ref
          .watch(getCityNotifier)
          .map<DropdownMenuItem<String>>((String city) {
        return DropdownMenuItem<String>(
          value: city,
          child: Text(
            city,
            style: GoogleFonts.roboto(textStyle: const TextStyle(fontSize: 10)),
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
        addBalanceMethod(context);
      },
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 3), // Gölgenin konumu
              ),
            ],
            border: Border.all(color: Colors.grey),
            shape: BoxShape.circle,
            color: appBarColor),
        child: const Icon(
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
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // Gölgenin konumu
          ),
        ],
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
      "Hoşgeldiniz",
      style: GoogleFonts.roboto(
          textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
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
  final double rating;
  final String name;
  final String text;
  const CommitWidget({
    super.key,
    required this.rating,
    required this.name,
    required this.text,
  });

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
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(width: 20.w),
              RatingBar.builder(
                ignoreGestures: true,
                itemSize: 25,
                initialRating: rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  null;
                },
              ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            child: Center(
              child: AutoSizeText(
                text,
                textAlign: TextAlign.start,
                style: const TextStyle(fontSize: 14),
                maxLines: 6,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BalanceInput extends ConsumerWidget {
  const BalanceInput({
    super.key,
    required TextEditingController balanceController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: SizedBox(
        width: 100.w,
        child: Form(
          child: TextFormField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              ref.read(balanceUpdate.notifier).state = value;
            },
            decoration: InputDecoration(
                counterText: "",
                hintStyle: GoogleFonts.roboto(),
                hintText: "Bakiye",
                isCollapsed: false,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(
                      color: appBarColor,
                    )),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
    );
  }
}

class GetBalanceButton extends ConsumerWidget {
  const GetBalanceButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        int first = int.parse(ref.watch(balanceProvider));
        int second = int.parse(ref.watch(balanceUpdate));

        int last = first + second;
        ref.read(balanceProvider.notifier).state = last.toString();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 100.w),
        child: Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: appBarColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              "Onayla",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 16.h,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ),
          ),
        ),
      ),
    );
  }
}

class BalanceInputs extends StatelessWidget {
  final int maxL;
  final String hintText;
  final TextInputType keyboardType;
  const BalanceInputs({
    super.key,
    required this.maxL,
    required this.hintText,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Form(
        child: TextFormField(
          maxLength: maxL,
          keyboardType: keyboardType,
          decoration: InputDecoration(
              counterText: "",
              hintStyle: GoogleFonts.roboto(),
              hintText: hintText,
              isCollapsed: false,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: appBarColor,
                  )),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
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
    );
  }
}
