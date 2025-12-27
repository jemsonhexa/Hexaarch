import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PicNotifier extends Notifier<File?> {
  @override
  File? build() => null;

  void setPic(File pic) {
    state = pic;
  }
}

final picProvider = NotifierProvider<PicNotifier, File?>(() => PicNotifier());
