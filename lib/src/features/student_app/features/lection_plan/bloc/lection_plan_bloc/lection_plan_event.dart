part of 'lection_plan_bloc.dart';

sealed class LectionPlanEvent {
  final List<Lection> lectionsList;
  const LectionPlanEvent({required this.lectionsList});

  const factory LectionPlanEvent.listChanged(
      {required List<Lection> lectionsList}) = _LectionsListChangedEvent;
}

final class _LectionsListChangedEvent extends LectionPlanEvent {
  const _LectionsListChangedEvent({required super.lectionsList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _LectionsListChangedEvent &&
        other.lectionsList == lectionsList;
  }

  @override
  int get hashCode => lectionsList.hashCode;

  @override
  String toString() =>
      'LectionPlanEvent.listChanged(lectionsList: $lectionsList)';
}
