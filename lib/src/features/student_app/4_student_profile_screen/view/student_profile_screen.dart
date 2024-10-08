import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/core/styles/color_scheme_my.dart';
import 'package:procrastinator/src/features/student_app/4_student_profile_screen/student_profile_screen.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/user_profile_options_component.dart';
import 'package:procrastinator/src/shared/view/components/elements_components/logout_button.dart';

class StudentProfilePageWidget extends StatelessWidget {
  const StudentProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, state) {
        if (state.user != null && state.group != null) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                  right: 16, left: 16, top: 24, bottom: 44),
              primary: true,
              child: Column(
                children: [
                  /////
                  Photo(state.user!.photoURL),

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
                        Text(state.group?.groupName ?? 'Group',
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
          return const Center(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                color: MyAppColorScheme.primary,
              ),
            ),
          );
        }
      },
    );
  }
}

class Photo extends StatelessWidget {
  final String? userPhoto;
  const Photo(this.userPhoto, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 160,
        width: 160,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AppScope.userOf(context).photoURL != null
                ? NetworkImage(AppScope.userOf(context).photoURL!)
                : const NetworkImage(
                    'https://images.unsplash.com/photo-1589652717406-1c69efaf1ff8?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHwzfHxkb2clMjBjb21wdXRlcnxlbnwwfHx8fDE3MDY1Mjk2MDF8MA&ixlib=rb-4.0.3&q=80&w=1080'),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(32)),
        ),
      ),
    );
  }
}

// class UserPhotoWidget extends StatelessWidget {
//   final String? userPhoto;
//   const UserPhotoWidget({super.key, this.userPhoto});

//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//         imageUrl: userPhoto!,
//         imageBuilder: (context, imageProvider) => Container(
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: imageProvider,
//                   fit: BoxFit.cover,
//                   colorFilter: const ColorFilter.mode(
//                     Colors.red,
//                     BlendMode.colorBurn,
//                   ),
//                 ),
//               ),
//             ),
//         placeholder: (context, url) => const CircularProgressIndicator(),
//         errorWidget: (context, url, error) {
//           return const Icon(Icons.error);
//         });
//   }
// }

// class PhotoW extends StatelessWidget {
//   const PhotoW({super.key});

//   @override
//   Widget build(BuildContext context) {
//     print(AppScope.userOf(context).photoURL!);
//     return Image.network(AppScope.userOf(context).photoURL!);
//   }
// }



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
