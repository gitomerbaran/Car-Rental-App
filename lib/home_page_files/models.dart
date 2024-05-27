import 'package:flutter_riverpod/flutter_riverpod.dart';

class Vehicle {
  String vName;
  String vYear;
  String vBrand;
  String kilometers;
  String vehicleId;
  String vehicleGear;
  String vehicleDoor;
  String vehicleColor;
  Vehicle(this.vName, this.vBrand, this.vYear, this.kilometers, this.vehicleId,this.vehicleGear,this.vehicleDoor,this.vehicleColor);
}

class VehicleNotifier extends StateNotifier<Map<String, Vehicle>> {
  VehicleNotifier()
      : super({
          "s": Vehicle("BMW", "520D", "2015", "136.000", "1","Manuel","4","Siyah"),
          "a": Vehicle("AUDI", "A4", "2013", "210.000", "2","Otomatik","4","Beyaz")
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
