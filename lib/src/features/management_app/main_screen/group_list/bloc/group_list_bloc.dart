import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:group_repository/group_repository.dart';

part 'group_list_event.dart';
part 'group_list_state.dart';

class GroupListBloc extends Bloc<GroupListEvent, GroupListState> {
  final IGroupRepository _groupRepository;
  late final StreamSubscription<List<Group>?> _groupListSubscription;
  GroupListBloc({required groupRepository})
      : _groupRepository = groupRepository,
        super(GroupListInitial()) {
    //Subscription
    _groupListSubscription = _groupRepository.getAllGroups().listen(
      (groupsList) {
        add(GroupListChangedEvent(groupsList));
      },
      cancelOnError: false,
    );

    on<GroupListChangedEvent>(
      (event, emit) {
        if (event.groupList != null) {
          final groupList = event.groupList;

          emit(GroupListLoadedState(groupList: groupList));
        } else {
          emit(GroupListLoadingState());
        }
      },
      transformer: sequential(),
    );
  }
  @override
  Future<void> close() {
    _groupListSubscription.cancel();
    log('Groups subscription was cancelled');
    return super.close();
  }
}
