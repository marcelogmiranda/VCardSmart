import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeState {
  final bool isLoading;
  final String? error;

  const HomeState({
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier() : super(const HomeState());

  Future<void> loadHome() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
