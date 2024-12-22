part of 'today_lection_bloc.dart';

// sealed class TodayLectionState {
//   const TodayLectionState();
// }

// final class TodayLessonInitial extends TodayLectionState {}

// final class TodayLectionLoading extends TodayLectionState {}

// final class TodayLectionLoaded extends TodayLectionState {
//   final Lection? todayLection;

//   const TodayLectionLoaded({required this.todayLection});
// }

// final class TodayLectionEmpty extends TodayLectionState {}

// final class TodayLectionFailure extends TodayLectionState {
//   final Object exception;

//   const TodayLectionFailure({required this.exception});
// }

sealed class TodayLectionState {
  /// The lection
  final Lection? lection;

  const TodayLectionState({this.lection});

  /// The lection is idle.
  const factory TodayLectionState.idle({Lection? lection}) =
      _IdleTodayLectionState;

  /// The lection is loading.
  const factory TodayLectionState.loading({Lection? lection}) =
      _LoadingTodayLectionState;

  /// The lection is loaded.
  const factory TodayLectionState.loaded({Lection? lection}) =
      _LoadedTodayLectionState;

  /// The lection has an error.
  const factory TodayLectionState.error(
      {required Object error, Lection? lection}) = _ErrorTodayLectionState;

  /// Check if state is idle.
  bool get isIdle => switch (this) {
        _IdleTodayLectionState _ => true,
        _ => false,
      };

  /// Check if state is loading.
  bool get isLoading => switch (this) {
        _LoadingTodayLectionState _ => true,
        _ => false,
      };

  /// Check if state is loaded.
  bool get isLoaded => switch (this) {
        _LoadedTodayLectionState _ => true,
        _ => false,
      };

  /// Check if state is error.
  bool get isError => switch (this) {
        _ErrorTodayLectionState _ => true,
        _ => false,
      };
}

final class _IdleTodayLectionState extends TodayLectionState {
  const _IdleTodayLectionState({super.lection});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _IdleTodayLectionState && other.lection == lection;
  }

  @override
  int get hashCode => lection.hashCode;

  @override
  String toString() => 'TodayLectionState.idle(lection: $lection)';
}

final class _LoadingTodayLectionState extends TodayLectionState {
  const _LoadingTodayLectionState({super.lection});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _LoadingTodayLectionState && other.lection == lection;
  }

  @override
  int get hashCode => lection.hashCode;

  @override
  String toString() => 'TodayLectionState.loading(lection: $lection)';
}

final class _LoadedTodayLectionState extends TodayLectionState {
  const _LoadedTodayLectionState({super.lection});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _LoadedTodayLectionState && other.lection == lection;
  }

  @override
  int get hashCode => lection.hashCode;

  @override
  String toString() => 'TodayLectionState.loaded(lection: $lection)';
}

final class _ErrorTodayLectionState extends TodayLectionState {
  /// The error.
  final Object error;

  const _ErrorTodayLectionState({required this.error, super.lection});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ErrorTodayLectionState &&
        other.lection == lection &&
        other.error == error;
  }

  @override
  int get hashCode => Object.hash(error, lection);

  @override
  String toString() =>
      'TodayLectionState.error(lection: $lection, error: $error)';
}
