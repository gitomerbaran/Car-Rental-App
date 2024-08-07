import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';


final balanceProvider = StateProvider<String>((ref) {
  return "100";
});

List<String> commits = [
  "Mükemmel bir hizmet aldım! Araba temiz ve bakımlıydı, personel çok yardımseverdi. Kesinlikle tekrar kiralarım!",
  "Araç kiralama işlemi çok kolaydı ve araba oldukça konforluydu. Fiyatlar da oldukça makul. Tavsiye ederim!",
  "Çok memnun kaldım, araba beklediğimden daha iyi durumdaydı. Müşteri hizmetleri de harikaydı. Teşekkürler!",
  "Kiraladığım araçla ilgili hiçbir sorun yaşamadım. Teslimat ve iade işlemleri de çok hızlıydı. Herkese tavsiye ederim!",
  "Harika bir deneyimdi! Personel çok profesyoneldi ve araç tertemizdi. Fiyatlar da oldukça uygun. Kesinlikle yeniden tercih ederim.",
];

final selectedCity = StateProvider<String>((ref) {
  return "ISTANBUL";
});

final selectedSecondCity = StateProvider<String>((ref) {
  return "ANKARA";
});

final selectedVehicleType = StateProvider<String>((ref) {
  return "Seçiniz";
});

//ARAÇ MARKALARI

final selectedVehicleBrand = StateProvider<String>((ref) {
  return "Seçiniz";
});

//ARAÇ MODELLERİ

final selectedModel = StateProvider<String>((ref) {
  return "Seçiniz";
});

//

final purchaseDate = StateProviderFamily<int, String>((ref, value) {
  String tarih1 = value.toString().substring(0, 10);
  String tarih2 = value.toString().substring(26, 36);

  DateFormat format = DateFormat('yyyy-MM-dd');

  DateTime date1 = format.parse(tarih1);
  DateTime date2 = format.parse(tarih2);

  Duration difference = date2.difference(date1);

  int differenceInDays = difference.inDays;

  // Gecikmeyi kullanarak rentTimeProvider'ı güncelle
  Future.delayed(Duration.zero, () {
    ref.read(rentTimeProvider.notifier).setRentTime(differenceInDays);
  });

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

final isLoading = StateProvider<bool>((ref) {
  return false;
});
final balanceUpdate = StateProvider<String>((ref) {
  return "";
});
