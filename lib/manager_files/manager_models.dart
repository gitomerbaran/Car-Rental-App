import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
      this.door, this.color, this.id, this.plaka);
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

Future<void> addCarMng(WidgetRef ref,
    {required String plate,
    required String city,
    required String model,
    required String carType,
    required int door,
    required int piece,
    required String color,
    required String gearType,
    required String fuel,
    required String km,
    required int year,
    required int price,
    required String brand}) async {
  final response = await http.post(
    Uri.parse('http://localhost:3001/addCarMng'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'PLAKA': plate,
      'ILALIS': city,
      'MODEL': model, // DateTime'ı ISO 8601 formatına çevirin
      'ARACTUR': carType, // Da
      'KAPIADET': door,
      'ADET': piece,
      'RENK': color, // DateTime'ı ISO 8601 formatına çevirin
      'VITESTUR': gearType, // Da
      'YAKIT': fuel,
      'KM': km,
      'YIL': year,
      'FIYAT ': price,
      'MARKA': brand
    }),
  ); // sendRentCar URL'sini uygun şekilde güncelleyin
}

class Customer {
  final String plate;
  final int tc;

  Customer(this.plate, this.tc);
}

// customersList StateProvider'ı
final customersList = StateProvider<Map<String, int>>((ref) => {});

// dropCustomer fonksiyonu
Future<void> dropCustomer(WidgetRef ref,
    {required String plate, required int tc}) async {
  final response = await http.post(
    Uri.parse('http://localhost:3001/dropCustomer'),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'PLAKA': plate,
      'MUSTERITC': tc,
    }),
  );
}

Future<void> fetchCustomers(WidgetRef ref) async {
  try {
    final response =
        await http.get(Uri.parse('http://localhost:3001/getCustomers'));

    if (response.statusCode == 200) {
      // Sunucudan başarılı bir şekilde yanıt alındı
      final List<dynamic> responseData = json.decode(response.body);

      // Her bir öğenin içindeki verilere erişmek için bir döngü kullanın
      Map<String, int> customers = {};
      for (var rowDataPacket in responseData) {
        // Her bir öğenin 'PLAKA' ve 'MUSTERITC' anahtarlarına göre verileri alın
        String plaka = rowDataPacket['PLAKA'];
        int musteriTc = rowDataPacket['MUSTERITC'];

        // Alınan verileri customers haritasına ekleyin
        customers[plaka] = musteriTc;
      }

      ref.read(customersList.notifier).state = customers;
    } else {
      throw Exception('Failed to load customers');
    }
  } catch (e) {
    // Hata durumunda işlem yapılabilir
    print('Error: $e');
  }
}
