import 'package:flutter/material.dart';

class UserImageWidget extends StatelessWidget {
  final String? userImageUrl;
  final double size;

  const UserImageWidget({
    Key? key,
    required this.userImageUrl,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: userImageUrl != null
                ? NetworkImage(userImageUrl!)
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
