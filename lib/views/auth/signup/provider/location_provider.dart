import 'package:flutter_riverpod/flutter_riverpod.dart';

class LocationNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setLocation(String loc) {
    state = loc;
  }
}

final locProvider = NotifierProvider<LocationNotifier, String?>(
  () => LocationNotifier(),
);
