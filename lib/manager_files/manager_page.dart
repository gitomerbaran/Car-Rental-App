import 'package:car_rental_app/functions.dart';
import 'package:car_rental_app/home_page_files/home_page.dart';
import 'package:car_rental_app/home_page_files/models.dart';
import 'package:car_rental_app/manager_files/manager_models.dart';
import 'package:car_rental_app/manager_files/manager_provider.dart';
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
                  child: const VehicleAddingPage(),
                ),
                SizedBox(height: 20.h),
/*                 Padding(
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: appBarColor,
                          width: 1.3,
                        ),
                      ),
                      //Veritabanından gelen veriler burda yazdırılıcak
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          //Veritabanındaki tüm araçlar
                          return Container(
                            child: Row(
                              children: <Widget>[
                                /* Column(
                                  children: <Widget>[VehicleDetails()],
                                ), */
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
               */
              ],
            ),
          ),
        );
      },
    );
  }
}

//  Bu kısım veritabanından gelen herbir araç listesi Class olarak dağıtılıp,
//  İçinde Classlar olan bir id-Class map'inden çekilerek yapılacak
/* class VehicleDetails extends StatelessWidget {
  final String head;
  final 
  const VehicleDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(head + ": " + data);
  }
}
 */
class VehicleAddingPage extends StatelessWidget {
  const VehicleAddingPage({
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
        width: double.infinity,
        height: 700.h,
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
            SizedBox(height: 20.h),
            const PrimaryText(),
            SizedBox(height: 20.h),
            CustomInputWigdet(
              provider: modelMng,
              head: "Marka",
            ),
            CustomInputWigdet(provider: brandMng, head: "Model"),
            CustomInputWigdet(provider: carTypeMng, head: "Araç Türü"),
            CustomInputWigdet(provider: yearMng, head: "Yıl"),
            CustomInputWigdet(provider: kilometersMng, head: "Km"),
            CustomInputWigdet(provider: gearMng, head: "Vites"),
            CustomInputWigdet(provider: doorMng, head: "Kapı Adet"),
            CustomInputWigdet(provider: colorMng, head: "Renk"),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.w),
              child: const AddButton(),
            )
          ],
        ),
      ),
    );
  }
}

class AddButton extends ConsumerWidget {
  const AddButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () async {
        ref.read(vehicleManagerNotifierProvider.notifier).addVehicle(
            VehicleManager(
                ref.watch(modelMng),
                ref.watch(brandMng),
                ref.watch(carTypeMng),
                ref.watch(kilometersMng),
                ref.watch(gearMng),
                ref.watch(doorMng),
                ref.watch(colorMng),
                "null",ref.watch(plakaProvider)));

        ref.invalidate(modelMng); //provider sıfırlama
        debugPrint(ref.watch(modelMng) + "----" + ref.watch(brandMng));
      },
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color.fromARGB(255, 156, 151, 151),
            blurRadius: 10,
            offset: Offset(1, 3),
          )
        ]),
        child: Container(
          height: 50.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: appBarColor, borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Text(
              "Ekle",
              style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                      fontSize: 18.h,
                      color: Colors.white,
                      fontWeight: FontWeight.w700)),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomInputWigdet extends ConsumerWidget {
  final StateProvider<String> provider;
  final String head;
  const CustomInputWigdet({
    super.key,
    required this.provider,
    required this.head,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
      child: Form(
          child: TextFormField(
        onChanged: (value) {
          ref.read(provider.notifier).state = value;
        },
        decoration: InputDecoration(
            hintText: head,
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
