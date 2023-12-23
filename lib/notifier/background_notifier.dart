import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weaving/common/local_storage.dart';

class BackgroundNotifier extends Notifier<String?> {
  final LocalStorage localStorage = LocalStorage();

  @override
  String? build() {
    final p = localStorage.getBgImagePath();
    return p;
  }

  setPath(String p) async {
    await localStorage.setBgImagePath(p);
    state = p;
  }
}

final backgroundNotifier =
    NotifierProvider<BackgroundNotifier, String?>(() => BackgroundNotifier());
