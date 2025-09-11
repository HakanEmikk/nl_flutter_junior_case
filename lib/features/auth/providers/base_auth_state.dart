class BaseAuthState {
  const BaseAuthState({this.isLoading = false, this.error});
  final bool isLoading;
  final String? error;

  BaseAuthState copyWith({bool? isLoading, String? error}) {
    return BaseAuthState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
