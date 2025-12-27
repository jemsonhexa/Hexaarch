import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhoneNumberNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setPhone(String phone) {
    state = phone;
  }
}

final phoneNumberProvider = NotifierProvider<PhoneNumberNotifier, String?>(
  () => PhoneNumberNotifier(),
);
