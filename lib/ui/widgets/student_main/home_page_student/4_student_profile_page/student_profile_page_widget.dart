import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/fake_data/user_fake_data/user_fake_data.dart';
import 'package:procrastinator/ui/navigation/main_navigation.dart';

import '../../../../../domain/api_client/firebase_service.dart';
import '../../../../../resources/resources.dart';
import '../../../../theme/color_scheme_my.dart';
import '../../../components/elements_components/user_profile_options_component.dart';

class StudentProfilePageWidget extends StatelessWidget {
  StudentProfilePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    String? userDisplayname = user?.displayName;
    String? userEmail = user?.email;

    return Center(
      child: ListView(
        padding:
            const EdgeInsets.only(right: 16, left: 16, top: 24, bottom: 44),
        primary: true,
        children: [
          Center(
            child: Container(
              height: 160,
              width: 160,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Images.userPhoto),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.all(Radius.circular(32)),
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
                  userDisplayname ?? 'Name',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(userEmail ?? 'Name',
                    style: Theme.of(context).textTheme.bodyLarge),
                Text('group', style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
          Column(
            children: [
              UserProfilePageOptionsCardComponent(
                title: 'Profile bearbeiten',
              ),
              UserProfilePageOptionsCardComponent(
                title: 'Krankmeldung',
              ),
              UserProfilePageOptionsCardComponent(
                title: 'Fehlmeldung',
              ),
              UserProfilePageOptionsCardComponent(
                title: 'Bug Report',
              ),
              UserProfilePageOptionsCardComponent(
                title: 'Unterlagen',
              ),
              UserProfilePageOptionsCardComponent(
                title: 'Kontakten',
              ),
              const SizedBox(height: 32),
              _LogOutButton(),
              const SizedBox(height: 16),
              _DeleteProfileButton(),
              const SizedBox(height: 44),
            ],
          ),
        ],
      ),
    );
  }
}

class _LogOutButton extends StatelessWidget {
  const _LogOutButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          onPressed: () {
            FirebaseService().logOut();

            Navigator.of(context)
                .pushReplacementNamed(MainNavigationRoutes.auth);
          },
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(MyAppColorScheme.errorColor)),
          child: Text(
            'Abmelden',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                  //fontWeight: FontWeight.w500
                ),
          )),
    );
  }
}

class _DeleteProfileButton extends StatelessWidget {
  const _DeleteProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
          onPressed: () {
            FirebaseService().deleteProfile();
            FirebaseService().logOut();

            Navigator.of(context)
                .pushReplacementNamed(MainNavigationRoutes.auth);
          },
          style: const ButtonStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 255, 137, 143))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.delete_outline_rounded),
              const SizedBox(width: 8),
              Text(
                'Profile löshen',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      //fontWeight: FontWeight.w500
                    ),
              ),
            ],
          )),
    );
  }
}
