import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpandNotifier extends StateNotifier<Map<String, bool>> {
  ExpandNotifier() : super({});

  void toggle(String id) {
    state = {...state, id: !(state[id] ?? false)};
  }

  bool isExpanded(String id) => state[id] ?? false;
}

final expandProvider = StateNotifierProvider<ExpandNotifier, Map<String, bool>>(
  (ref) {
    return ExpandNotifier();
  },
);
