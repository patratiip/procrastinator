part of 'kursplan_bloc.dart';

sealed class KursplanEvent extends Equatable {
  const KursplanEvent();

  @override
  List<Object> get props => [];
}

class LoadLections extends KursplanEvent {}
