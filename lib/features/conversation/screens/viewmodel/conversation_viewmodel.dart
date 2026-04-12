import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/conversation_provider.dart';

class SelectionState {
  final bool isSelectionMode;
  final Set<String> selectedIds;

  const SelectionState({this.isSelectionMode = false, this.selectedIds = const {}});

  int get count => selectedIds.length;

  SelectionState copyWith({bool? isSelectionMode, Set<String>? selectedIds}) {
    return SelectionState(
      isSelectionMode: isSelectionMode ?? this.isSelectionMode,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }
}

class SelectionViewModel extends Notifier<SelectionState> {
  @override
  SelectionState build() => const SelectionState();

  void toggle(String id) {
    final newSet = {...state.selectedIds};

    if (newSet.contains(id)) {
      newSet.remove(id);
    } else {
      newSet.add(id);
    }

    state = state.copyWith(selectedIds: newSet, isSelectionMode: newSet.isNotEmpty);
  }

  void startSelectionMode(String id) {
    state = SelectionState(isSelectionMode: true, selectedIds: {id});
  }

  void resetSelectionMode() {
    state = const SelectionState();
  }
}

class ConversationActionVM extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() {}

  Future<void> removeUserList({required Set<String> conversationIds, required String memberUid}) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      await ref.read(conversationServiceProvider).removeUserList(conversationIds: conversationIds, memberUid: memberUid);
    });
  }
}

final selectionProvider = NotifierProvider<SelectionViewModel, SelectionState>(() => SelectionViewModel());


final conversationActionVMProvider = AsyncNotifierProvider(() => ConversationActionVM());
