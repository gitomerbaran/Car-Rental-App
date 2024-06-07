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
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: CustomersPage(),
                ),
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
        height: 1200.h,
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
            CustomInputWigdet(provider: plateProvider, head: "Plaka"),
            CustomInputWigdet(provider: cityMng, head: "Alış İli"),
            CustomInputWigdet(provider: modelMng, head: "Model"),
            CustomInputWigdet(provider: carTypeMng, head: "Araç Türü"),
            CustomInputWigdetInt(provider: doorMng, head: "Kapı Adeti"),
            CustomInputWigdetInt(provider: carPiece, head: "Araç Adeti"),
            CustomInputWigdet(provider: colorMng, head: "Renk"),
            CustomInputWigdet(provider: gearMng, head: "Vites Türü"),
            CustomInputWigdet(provider: fuelMng, head: "Yakıt Türü"),
            CustomInputWigdet(provider: kmMng, head: "KM"),
            CustomInputWigdetInt(provider: yearMng, head: "Yıl"),
            CustomInputWigdetInt(provider: priceMng, head: "Fiyat"),
            CustomInputWigdet(provider: brandMng, head: "Marka"),
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

/* class ListviewCustomWidget extends ConsumerWidget {
  const ListviewCustomWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Customer> customers =
        ref.watch(customersList.notifier).state; // Müşteri listesini al

    return ListView.builder(
      itemCount: customers.length,
      itemBuilder: (context, index) {
        final Customer customer = customers[index];
        return _buildCustomerItem(context, customer, ref);
      },
    );
  }

  Widget _buildCustomerItem(
      BuildContext context, Customer customer, WidgetRef ref) {
    return Container(
      height: 100,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TC: ${customer.tc.toString()}'),
              SizedBox(height: 10),
              Text('Plaka: ${customer.plate}'),
            ],
          ),
          ElevatedButton(
            onPressed: () async {
              await dropCustomer(ref, plate: customer.plate, tc: customer.tc);
            },
            child: Text("Sil"),
          ),
        ],
      ),
    );
  }
}
 */
// CustomersPage widget'ı
class CustomersPage extends StatelessWidget {
  const CustomersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
        width: double.infinity,
        height: 1200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(
            color: Colors.blue, // Değişiklik yapılabilir
            width: 1.3,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: 20),
            const PrimaryText2(), // PrimaryText widget'ını eklemeyi unuttuğunuz için değiştirildi
            SizedBox(height: 20),
            Expanded(
              child:
                  CustomListView(), // ListView burada Expanded ile sarılmıştır
            ),
            SizedBox(height: 30),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 100),
              child: ElevatedButton(
                onPressed:
                    () {}, // AddButton widget'ını eklemeyi unuttuğunuz için geçici bir onPressed eklenmiştir
                child: const Text(
                    "Add"), // AddButton widget'ını eklemeyi unuttuğunuz için geçici bir Text eklenmiştir
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}

class CustomListView extends ConsumerWidget {
  const CustomListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customers = ref.watch(customersList); // customersList'ten veri al

    return Expanded(
      child: ListView.builder(
        itemCount: customers.length,
        itemBuilder: (context, index) {
          final keys = customers.keys.toList();
          final values = customers.values.toList();
          final plate = keys[index];
          final tc = values[index];
          return ListTile(
            title: Container(
              height: 50.h,
              color: Color.fromARGB(255, 221, 219, 219),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'PLAKA: $plate',
                        style: TextStyle(
                            color: appBarColor, fontWeight: FontWeight.w600),
                      ),
                      Text('TC: $tc'.toString(),
                          style: TextStyle(
                              color: appBarColor, fontWeight: FontWeight.w600)),
                    ],
                  ),
                  InkWell(
                    onTap: () async {
                      //silme işlemi
                      await dropCustomer(ref, plate: plate, tc: tc);
                    },
                    child: Container(
                      height: 30.h,
                      width: 70.w,
                      decoration: BoxDecoration(
                          color: appBarColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: Center(
                        child: Text(
                          "SİL",
                          style: TextStyle(color: Colors.white, fontSize: 15.h),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),

            // Diğer özellikler veya tıklama işlemleri buraya eklenebilir
          );
        },
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
        await addCarMng(ref,
            plate: ref.watch(plateProvider),
            city: ref.watch(cityMng),
            model: ref.watch(modelMng),
            carType: ref.watch(carTypeMng),
            door: ref.watch(doorMng),
            piece: ref.watch(carPiece),
            color: ref.watch(colorMng),
            gearType: ref.watch(gearMng),
            fuel: ref.watch(fuelMng),
            km: ref.watch(kmMng),
            year: ref.watch(yearMng),
            price: ref.watch(priceMng),
            brand: ref.watch(brandMng));
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

class CustomInputWigdetInt extends ConsumerWidget {
  final StateProvider<int> provider;
  final String head;
  const CustomInputWigdetInt({
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
          ref.read(provider.notifier).state = int.parse(value);
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

class PrimaryText2 extends StatelessWidget {
  const PrimaryText2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Dolu Araçlar",
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
