import 'dart:convert';
import 'package:car_rental_app/account_files/account_page_providers.dart';
import 'package:car_rental_app/home_page_files/home_page_provider.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Vehicle {
  String vPlate;
  String vBrand;
  String vType;
  String vModel;
  String vColor;
  String vTransmitter;
  String vFuel;
  int vDoor;
  String vKm;
  int vYear;
  int vPrice;

  Vehicle(
    this.vPlate,
    this.vBrand,
    this.vType,
    this.vModel,
    this.vColor,
    this.vTransmitter,
    this.vFuel,
    this.vDoor,
    this.vKm,
    this.vYear,
    this.vPrice,
  );
}

class VehicleNotifier extends StateNotifier<List<Vehicle>> {
  VehicleNotifier()
      : super([
          Vehicle("34ABC213", "BMW", "SUW", "X5", "SIYAH", "OTOMATIK", "DIZEL",
              4, "0-30.000", 2019, 3500000)
        ]);

  void addVehicle(Vehicle newVehicle) {
    state = [...state, newVehicle];
  }
}

final vehicleNotifierProvider =
    StateNotifierProvider((ref) => VehicleNotifier());

final vehicleListProvider = StateProvider<List<Vehicle>>((ref) {
  final vehicleMap = ref.read(vehicleNotifierProvider.notifier).state;
  return vehicleMap;
});
int cityNo(WidgetRef ref) {
  if (ref.watch(selectedCity) == "ISTANBUL") {
    return 34;
  } else if (ref.watch(selectedCity) == "IZMIR") {
    return 35;
  } else if (ref.watch(selectedCity) == "ANKARA") {
    return 06;
  } else if (ref.watch(selectedCity) == "ANTALYA") {
    return 07;
  } else if (ref.watch(selectedCity) == "SAMSUN") {
    return 55;
  } else if (ref.watch(selectedCity) == "ERZURUM") {
    return 25;
  } else if (ref.watch(selectedCity) == "DIYARBAKIR") {
    return 21;
  } else {
    return 0;
  }
}

Future<void> getCars(WidgetRef ref) async {
  final response = await http.post(
    Uri.parse('http://localhost:3001/getRentCarList'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'city': cityNo(ref),
      'brand': ref.watch(selectedVehicleBrand),
      'type': ref.watch(selectedVehicleType),
      'model': ref.watch(selectedModel)
    }),
  );

  if (response.statusCode == 200) {
    print("çalıştımXD");

    List<dynamic> jsonData = jsonDecode(response.body);
    for (var data in jsonData[0]) {
      Vehicle car = Vehicle(
        data['PLAKA'],
        data['MARKA'],
        data['ARACTUR'],
        data['MODEL'],
        data['RENK'],
        data['VITESTUR'],
        data['YAKIT'],
        data['KAPIADET'],
        data['KM'],
        data['YIL'],
        data['FIYAT'],
      );
      ref.read(vehicleNotifierProvider.notifier).addVehicle(car);
    }
  } else {
    print("ÇALIŞMADIMM");
  }
}

Future<void> sendRentCar(
  WidgetRef ref, {
  required String plate,
  required String destination,
  required String takeTime,
  required String releaseTime,
  required int musteriTc,
}) async {
  final response = await http.post(
    Uri.parse('http://localhost:3001/sendRentCar'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'PLAKA': plate,
      'ILDONUS': ref.watch(selectedSecondCity),
      'ALISTAR': takeTime, // DateTime'ı ISO 8601 formatına çevirin
      'DONUSTAR': releaseTime, // Da
      'MUSTERITC': musteriTc,
    }),
  ); // sendRentCar URL'sini uygun şekilde güncelleyin
}

//
//
// NODE.JS ENDPOINTS AND MODELS
//

Future<void> getBrands(WidgetRef ref) async {
  final response =
      await http.get(Uri.parse('http://localhost:3001/getAllBrands'));

  if (response.statusCode == 200) {
    List<String> brandList = List<String>.from(jsonDecode(response.body));
    print(brandList);
    ref.read(vehicleBrandsListNotifier.notifier).setBrands(brandList);
  } else {
    print('Failed to load city data');
  }
}

class VehicleBrandListProvider extends StateNotifier<List<String>> {
  VehicleBrandListProvider() : super([]);

  void setBrands(List<String> brands) {
    state = brands;
  }
}

final vehicleBrandsListNotifier =
    StateNotifierProvider<VehicleBrandListProvider, List<String>>((ref) {
  return VehicleBrandListProvider();
});

///
// MODEL LIST

Future<void> getModel(WidgetRef ref) async {
  final response =
      await http.get(Uri.parse('http://localhost:3001/getAllModels'));

  if (response.statusCode == 200) {
    List<String> modelList = List<String>.from(jsonDecode(response.body));
    print(modelList);
    ref.read(vehicleModelsNotifier.notifier).setTypes(modelList);
  } else {
    print('Failed to load model data');
  }
}

class VehicleModelListProvider extends StateNotifier<List<String>> {
  VehicleModelListProvider() : super([]);

  void setTypes(List<String> models) {
    state = models;
  }
}

final vehicleModelsNotifier =
    StateNotifierProvider<VehicleModelListProvider, List<String>>((ref) {
  return VehicleModelListProvider();
});

///
// TYPE LIST
///
Future<void> getTypes(WidgetRef ref) async {
  final response =
      await http.get(Uri.parse('http://localhost:3001/getAllTypes'));

  if (response.statusCode == 200) {
    List<String> typeList = List<String>.from(jsonDecode(response.body));
    ref.read(vehicleTypesNotifier.notifier).setTypes(typeList);
  } else {
    print('Failed to load type data');
  }
}

class VehicleTypeListProvider extends StateNotifier<List<String>> {
  VehicleTypeListProvider() : super([]);

  void setTypes(List<String> types) {
    state = types;
  }
}

final vehicleTypesNotifier =
    StateNotifierProvider<VehicleTypeListProvider, List<String>>((ref) {
  return VehicleTypeListProvider();
});

///
// GET CITY
Future<void> getCity(WidgetRef ref) async {
  final response =
      await http.get(Uri.parse('http://localhost:3001/getAllCities'));

  if (response.statusCode == 200) {
    List<String> cityList = List<String>.from(jsonDecode(response.body));
    ref.read(getCityNotifier.notifier).setCity(cityList);
  } else {
    print('Failed to load type data');
  }
}

class GetCityNotifier extends StateNotifier<List<String>> {
  GetCityNotifier() : super([]);

  void setCity(List<String> cities) {
    state = cities;
  }
}

final getCityNotifier =
    StateNotifierProvider<GetCityNotifier, List<String>>((ref) {
  return GetCityNotifier();
});

//
