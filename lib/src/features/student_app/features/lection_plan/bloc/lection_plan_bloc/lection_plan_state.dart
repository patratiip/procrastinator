part of 'lection_plan_bloc.dart';

sealed class LectionPlanState {
  /// The list of lections
  final List<Lection> lectionsList;

  const LectionPlanState({required this.lectionsList});

  /// The list is idle.
  const factory LectionPlanState.idle({required List<Lection> lectionsList}) =
      _IdleLectionPlanState;

  /// The list is loading.
  const factory LectionPlanState.loading(
      {required List<Lection> lectionsList}) = _LoadingLectionPlanState;

  /// The list is loaded.
  const factory LectionPlanState.loaded({required List<Lection> lectionsList}) =
      _LoadedLectionPlanState;

  /// The list have an error.
  const factory LectionPlanState.error(
      {required Object error,
      required List<Lection> lectionsList}) = _ErrorLectionPlanState;

  /// Returns true if the state is idle
  bool get isIdle => switch (this) {
        _IdleLectionPlanState _ => true,
        _ => false,
      };

  /// Returns true if the state is loading
  bool get loading => switch (this) {
        _LoadingLectionPlanState _ => true,
        _ => false,
      };

  /// Returns true if the state is loaded
  bool get loaded => switch (this) {
        _LoadedLectionPlanState _ => true,
        _ => false,
      };

  /// Returns true if the state is error
  bool get errorState => switch (this) {
        _ErrorLectionPlanState _ => true,
        _ => false,
      };
}

final class _IdleLectionPlanState extends LectionPlanState {
  const _IdleLectionPlanState({required super.lectionsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _IdleLectionPlanState && other.lectionsList == lectionsList;
  }

  @override
  int get hashCode => lectionsList.hashCode;

  @override
  String toString() => 'LectionPlanState.idle(lectionsList: $lectionsList)';
}

final class _LoadingLectionPlanState extends LectionPlanState {
  const _LoadingLectionPlanState({required super.lectionsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _LoadingLectionPlanState &&
        other.lectionsList == lectionsList;
  }

  @override
  int get hashCode => lectionsList.hashCode;

  @override
  String toString() => 'LectionPlanState.loading(lectionsList: $lectionsList)';
}

final class _LoadedLectionPlanState extends LectionPlanState {
  const _LoadedLectionPlanState({required super.lectionsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _LoadedLectionPlanState &&
        other.lectionsList == lectionsList;
  }

  @override
  int get hashCode => lectionsList.hashCode;

  @override
  String toString() => 'LectionPlanState.loaded(lectionsList: $lectionsList)';
}

final class _ErrorLectionPlanState extends LectionPlanState {
  /// The error.
  final Object error;

  const _ErrorLectionPlanState(
      {required this.error, required super.lectionsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ErrorLectionPlanState &&
        other.lectionsList == lectionsList &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(lectionsList, error);

  @override
  String toString() =>
      'LectionPlanState.error(lectionsList: $lectionsList, error: $error)';
}
