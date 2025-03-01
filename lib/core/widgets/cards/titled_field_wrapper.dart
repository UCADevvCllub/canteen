import 'package:flutter/material.dart';

class TitledFieldWrapper extends StatelessWidget {
  const TitledFieldWrapper({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
