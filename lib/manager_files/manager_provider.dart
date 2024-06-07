import 'package:flutter_riverpod/flutter_riverpod.dart';

final modelMng = StateProvider<String>((ref) {
  return "null";
});

final carTypeMng = StateProvider<String>((ref) {
  return "null";
});

final brandMng = StateProvider<String>((ref) {
  return "null";
});

final yearMng = StateProvider<int>((ref) {
  return 0;
});

final kilometersMng = StateProvider<String>((ref) {
  return "null";
});

final gearMng = StateProvider<String>((ref) {
  return "null";
});

final doorMng = StateProvider<int>((ref) {
  return 0;
});

final colorMng = StateProvider<String>((ref) {
  return "null";
});

final plateProvider = StateProvider<String>((ref) {
  return "null";
});

final cityMng = StateProvider<String>((ref) {
  return "null";
});

final carPiece = StateProvider<int>((ref) {
  return 0;
});

final fuelMng = StateProvider<String>((ref) {
  return "";
});

final kmMng = StateProvider<String>((ref) {
  return "null";
});

final priceMng = StateProvider<int>((ref) {
  return 0;
});
