import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/styles.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/user_profile_options_component.dart';
import 'package:procrastinator/src/shared/view/components/logout_button.dart';

class StudentProfilePageWidget extends StatelessWidget {
  const StudentProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if (state.status == AuthenticationStatus.authenticated) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 24, bottom: 44),
              primary: true,
              child: Column(
                children: [
                  Center(
                    child: Container(
                      height: 160,
                      width: 160,
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: state.user!.photoURL != null
                              ? NetworkImage(state.user!.photoURL!)
                              : const NetworkImage(
                                  'https://images.unsplash.com/photo-1589652717406-1c69efaf1ff8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxkb2clMjBjb21wdXRlcnxlbnwwfHx8fDE3MDY1Mjk2MDF8MA&ixlib=rb-4.0.3&q=80&w=1080'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 24,
                      bottom: 24,
                    ),
                    child: Column(
                      children: [
                        Text(
                          state.user!.name ?? Localization.of(context).name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        Text(state.user!.email,
                            style: Theme.of(context).textTheme.bodyLarge),
                        Text('group',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      UserProfilePageOptionsCardComponent(
                        title: Localization.of(context).profileEdit,
                      ),
                      UserProfilePageOptionsCardComponent(
                        title: Localization.of(context).sickList,
                      ),
                      UserProfilePageOptionsCardComponent(
                        title: Localization.of(context).looseReport,
                      ),
                      UserProfilePageOptionsCardComponent(
                        title: Localization.of(context).bugReport,
                      ),
                      UserProfilePageOptionsCardComponent(
                        title: Localization.of(context).documents,
                      ),
                      UserProfilePageOptionsCardComponent(
                        title: Localization.of(context).contacts,
                      ),
                      const SizedBox(height: 32),
                      const LogOutButton(),
                      const SizedBox(height: 16),
                      // _DeleteProfileButton(),
                      const SizedBox(height: 44),
                    ],
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}



// class _DeleteProfileButton extends StatelessWidget {
//   const _DeleteProfileButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: const BoxConstraints(maxWidth: 600),
//       height: 60,
//       child: ElevatedButton(
//           onPressed: () {
//             AuthFirebaseService().deleteProfile();
//             AuthFirebaseService().logOut();

//             Navigator.of(context)
//                 .pushReplacementNamed(MainNavigationRoutes.auth);
//           },
//           style: const ButtonStyle(
//               backgroundColor:
//                   MaterialStatePropertyAll(Color.fromARGB(255, 255, 137, 143))),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const Icon(Icons.delete_outline_rounded),
//               const SizedBox(width: 8),
//               Text(
//                 'Profile löshen',
//                 style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                       color: Colors.white,
//                       //fontWeight: FontWeight.w500
//                     ),
//               ),
//             ],
//           )),
//     );
//   }
// }
