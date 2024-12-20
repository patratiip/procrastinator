// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:procrastinator/src/core/constant/localization/generated/l10n.dart';
import 'package:procrastinator/src/features/settings/widget/settings_screen.dart';
import 'package:procrastinator/src/features/student_app/features/student_profile_screen/bloc/user_profile_bloc.dart';
import 'package:procrastinator/src/ui_kit/widget/feature_card_component.dart';
import 'package:procrastinator/src/shared/view/widgets/logout_button.dart';
import 'package:procrastinator/src/ui_kit/color/color_scheme_my.dart';
import 'package:procrastinator/src/ui_kit/widget/user_image_widget.dart';

/// {@template student_profile_screen}
/// Widget that shows [StudentProfileScreen]
/// {@endtemplate}
class StudentProfileScreen extends StatelessWidget {
  /// {@macro student_profile_screen}
  const StudentProfileScreen({super.key});

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
                  /// Curent [User] profile image
                  UserImageWidget(
                    userImageUrl: state.user!.photoURL,
                    size: 160,
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
                        Text(state.group?.groupName ?? 'Group',
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      // // Edit profile
                      // FeatureCardComponent(
                      //   title: Localization.of(context).profileEdit,
                      // ),

                      // Settings
                      FeatureCardComponent(
                        title: Localization.of(context).settingsLabelText,
                        route: const SettingsScreen(),
                      ),

                      // // Sick list
                      // FeatureCardComponent(
                      //   title: Localization.of(context).sickList,
                      // ),

                      //Loose report
                      FeatureCardComponent(
                        title: Localization.of(context).looseReport,
                        newFeature: true,
                        route: const SettingsScreen(),
                      ),

                      // // Bug report
                      // FeatureCardComponent(
                      //   title: Localization.of(context).bugReport,
                      // ),

                      // // Documets
                      // FeatureCardComponent(
                      //   title: Localization.of(context).documents,
                      // ),

                      // // Contacts
                      // FeatureCardComponent(
                      //   title: Localization.of(context).contacts,
                      // ),
                      const SizedBox(height: 32),

                      // LogOut button
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
