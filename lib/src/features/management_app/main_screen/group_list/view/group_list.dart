import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/management_app/main_screen/group_list/group_list.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupListState>(
        builder: (context, state) {
      if (state is GroupListLoadedState) {
        return ListView.builder(
            primary: false,
            shrinkWrap: true,
            itemCount:
                state.groupList!.length < 5 ? state.groupList!.length : 5,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(state.groupList![index].groupName),
                    Text(state.groupList![index].groupID),
                    Text(state.groupList![index].totalDays.toString()),
                  ],
                ),
              );
              // return EntryCardComponent(
              //   visitData: state.userVisits![index],
              // );
            });
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
