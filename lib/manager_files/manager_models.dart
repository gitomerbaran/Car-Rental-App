import 'package:flutter_riverpod/flutter_riverpod.dart';

class VehicleManager {
  String name;
  String year;
  String brand;
  String kilometers;
  String gear;
  String door;
  String color;
  String id;
  String plaka;
  VehicleManager(this.name, this.brand, this.year, this.kilometers, this.gear,
      this.door, this.color, this.id,this.plaka);
}

class VehicleManagerNotifier
    extends StateNotifier<Map<String, VehicleManager>> {
  VehicleManagerNotifier() : super({});

  void addVehicle(VehicleManager newVehicle) {
    state = {...state, newVehicle.id: newVehicle};
  }
}

final vehicleManagerNotifierProvider =
    StateNotifierProvider((ref) => VehicleManagerNotifier());

final vehicleListProvider = Provider<List<VehicleManager>>((ref) {
  final vehicleMap = ref.read(vehicleManagerNotifierProvider.notifier).state;
  return vehicleMap.values.toList();
});
