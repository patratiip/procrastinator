part of 'today_lection_bloc.dart';

sealed class TodayLectionEvent {
  final Lection? lection;
  const TodayLectionEvent({required this.lection});

  const factory TodayLectionEvent.loadLection({Lection? lection}) =
      _LoadLectionEvent;
}

final class _LoadLectionEvent extends TodayLectionEvent {
  const _LoadLectionEvent({super.lection});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _LoadLectionEvent && other.lection == lection;
  }

  @override
  int get hashCode => lection.hashCode;

  @override
  String toString() => 'TodayLectionEvent.loadLection(lection: $lection)';
}
