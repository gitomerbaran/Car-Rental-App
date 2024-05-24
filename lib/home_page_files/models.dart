import 'package:flutter_riverpod/flutter_riverpod.dart';

class Vehicle {
  String vName;
  String vYear;
  String vBrand;
  String kilometers;
  String vehicleId;
  Vehicle(this.vName, this.vBrand, this.vYear, this.kilometers, this.vehicleId);
}

class VehicleNotifier extends StateNotifier<Map<String, Vehicle>> {
  VehicleNotifier()
      : super({
          "s": Vehicle("deneme", "vBrand", "vYear", "kilometers", "vehicleId"),
          "a": Vehicle("2", "2", "2", "3", "2")
        });

  void addVehicle(Vehicle newVehicle) {
    state = {...state, newVehicle.vehicleId: newVehicle};
  }
}

final vehicleNotifierProvider =
    StateNotifierProvider((ref) => VehicleNotifier());

final vehicleListProvider = Provider<List<Vehicle>>((ref) {
  final vehicleMap = ref.read(vehicleNotifierProvider.notifier).state;
  return vehicleMap.values.toList();
});
