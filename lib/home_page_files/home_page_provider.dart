import 'package:car_rental_app/home_page_files/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

final nameProvider = StateProvider<String>((ref) {
  return "test";
});

final balanceProvider = StateProvider<String>((ref) {
  return "10";
});

final commetList = Provider<List<Commet>>((ref) {
  return [
    Commet('Audi A4', 'Günlük kiralama: \$50'),
    Commet('Ford Mustang', 'Günlük kiralama: \$70'),
    Commet('BMW X5', 'Günlük kiralama: \$80'),
    Commet('Toyota Corolla', 'Günlük kiralama: \$40'),
  ];
});

class Commet {
  final String name;
  final String carName;

  Commet(this.name, this.carName);
}

List<String> cities = [
  "İstanbul",
  "Ankara",
  "İzmir",
  "Antalya",
  "Samsun",
  "Diyarbakır",
  "Erzurum"
];

final selectedCity = StateProvider<String>((ref) {
  return "İstanbul";
});

final selecedSecondCity = StateProvider<String>((ref) {
  return "Ankara";
});

//ARAÇ TÜRÜ
final vehicleTypeListP = StateProvider<List<String>>((ref) {
  return ["Null"];
});

final selectedVehicleType = StateProvider<String>((ref) {
  return "Null";
});

//ARAÇ MARKALARI
final vehicleBrandListP = StateProvider<List<String>>((ref) {
  return ["Null"];
});

final selectedVehicleBrand = StateProvider<String>((ref) {
  return "Null";
});

//ARAÇ MODELLERİ
final vehicleModelListP = StateProvider<List<String>>((ref) {
  return ["Null"];
});

final selectedModel = StateProvider<String>((ref) {
  return "Null";
});

//

final purchaseDate = StateProviderFamily<int, String>((ref, value) {
  String tarih1 = value.toString().substring(0, 10);
  String tarih2 = value
      .toString()
      .substring(26, 36); // değişiklik yaparak internal providerUserCode tari

  DateFormat format = DateFormat('yyyy-MM-dd');

  DateTime date1 = format.parse(tarih1);
  DateTime date2 = format.parse(tarih2);

  Duration difference = date2.difference(date1);

  int differenceInDays = difference.inDays;

  ref.read(rentTimeProvider.notifier).setRentTime(differenceInDays);

  return differenceInDays == 0 ? 1 : differenceInDays;
});

final deliveryDate = StateProvider<String>((ref) {
  return "Null";
});

class RentTimeNotifier extends StateNotifier<int> {
  RentTimeNotifier() : super(0);

  void setRentTime(int days) {
    state = days;
  }
}

final rentTimeProvider = StateNotifierProvider((ref) => RentTimeNotifier());
