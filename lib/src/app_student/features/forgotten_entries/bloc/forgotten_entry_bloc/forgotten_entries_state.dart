part of 'forgotten_entries_bloc.dart';

sealed class ForgottenEntriesState {
  /// The requestsList
  final List<ForgottenRequestStudent> requestsList;

  const ForgottenEntriesState({required this.requestsList});

  /// The requestsList is idle.
  const factory ForgottenEntriesState.idle(
          {required List<ForgottenRequestStudent> requestsList}) =
      _IdleForgottenEntriesListState;

  /// The requestsList is loading.
  const factory ForgottenEntriesState.loading(
          {required List<ForgottenRequestStudent> requestsList}) =
      _LoadingForgottenEntriesListState;

  /// The requestsList is loaded.
  const factory ForgottenEntriesState.loaded(
          {required List<ForgottenRequestStudent> requestsList}) =
      _LoadedForgottenEntriesListState;

  /// The requestsList has an error.
  const factory ForgottenEntriesState.error(
      {required Object error,
      required List<ForgottenRequestStudent> requestsList,
      String? requestRef}) = _ErrorForgottenEntriesListState;

  /// Check if state is idle.
  bool get isIdle => switch (this) {
        _IdleForgottenEntriesListState _ => true,
        _ => false,
      };

  /// Check if state is loading.
  bool get loading => switch (this) {
        _LoadingForgottenEntriesListState _ => true,
        _ => false,
      };

  /// Check if state is loaded.
  bool get loaded => switch (this) {
        _LoadedForgottenEntriesListState _ => true,
        _ => false,
      };

  /// Check if state is error.
  bool get isError => switch (this) {
        _ErrorForgottenEntriesListState _ => true,
        _ => false,
      };
}

final class _IdleForgottenEntriesListState extends ForgottenEntriesState {
  const _IdleForgottenEntriesListState({required super.requestsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _IdleForgottenEntriesListState &&
        listEquals(other.requestsList, requestsList);
  }

  @override
  int get hashCode => requestsList.hashCode;

  @override
  String toString() =>
      'ForgottenEntriesListState.idle(requestsList: $requestsList)';
}

final class _LoadingForgottenEntriesListState extends ForgottenEntriesState {
  const _LoadingForgottenEntriesListState({required super.requestsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _LoadingForgottenEntriesListState &&
        listEquals(other.requestsList, requestsList);
  }

  @override
  int get hashCode => requestsList.hashCode;

  @override
  String toString() =>
      'ForgottenEntriesListState.loading(requestsList: $requestsList)';
}

final class _LoadedForgottenEntriesListState extends ForgottenEntriesState {
  const _LoadedForgottenEntriesListState({required super.requestsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _LoadedForgottenEntriesListState &&
        listEquals(other.requestsList, requestsList);
  }

  @override
  int get hashCode => requestsList.hashCode;

  @override
  String toString() =>
      'ForgottenEntriesListState.loaded(requestsList: $requestsList)';
}

class _ErrorForgottenEntriesListState extends ForgottenEntriesState {
  /// The error.
  final Object error;

  /// ForgottenRequestStudent reference to delete
  final String? requestRef;

  const _ErrorForgottenEntriesListState({
    required this.error,
    required super.requestsList,
    this.requestRef,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ErrorForgottenEntriesListState &&
        listEquals(other.requestsList, requestsList) &&
        other.requestRef == requestRef &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(error, requestRef, requestsList);

  @override
  String toString() =>
      'ForgottenEntriesListState.error(requestsList: $requestsList, error: $error, requestRef: $requestRef)';
}
