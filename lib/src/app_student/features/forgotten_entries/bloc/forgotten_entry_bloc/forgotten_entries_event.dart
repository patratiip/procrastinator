part of 'forgotten_entries_bloc.dart';

sealed class ForgottenEntriesEvent {
  const ForgottenEntriesEvent();

  /// The forgotten entries list changed.
  const factory ForgottenEntriesEvent.forgottenEntriesListChanged(
          {required List<ForgottenRequestStudent> forgottenEntriesList}) =
      _ForgottenEntriesListEventChanged;

  /// Delete entry.
  const factory ForgottenEntriesEvent.deleteEntry(
      {required String requestRef}) = _ForgottenEntriesEventDelete;
}

final class _ForgottenEntriesListEventChanged extends ForgottenEntriesEvent {
  /// The changed forgotten entries list
  final List<ForgottenRequestStudent> forgottenEntriesList;
  const _ForgottenEntriesListEventChanged({required this.forgottenEntriesList});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ForgottenEntriesListEventChanged &&
        other.forgottenEntriesList == forgottenEntriesList;
  }

  @override
  int get hashCode => forgottenEntriesList.hashCode;

  @override
  String toString() =>
      'ForgottenEntriesEvent.forgottenEntriesListChanged(forgottenEntriesList: $forgottenEntriesList)';
}

final class _ForgottenEntriesEventDelete extends ForgottenEntriesEvent {
  /// Entry reference to delete
  final String requestRef;
  const _ForgottenEntriesEventDelete({required this.requestRef});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is _ForgottenEntriesEventDelete &&
        other.requestRef == requestRef;
  }

  @override
  int get hashCode => requestRef.hashCode;

  @override
  String toString() =>
      'ForgottenEntriesEvent.deleteEntry( requestRef: $requestRef)';
}
