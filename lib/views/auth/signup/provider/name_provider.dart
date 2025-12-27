import 'package:flutter_riverpod/flutter_riverpod.dart';

class NameNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void setName(String name) {
    state = name;
  }
}

final nameProvider = NotifierProvider<NameNotifier, String?>(
  () => NameNotifier(),
);
