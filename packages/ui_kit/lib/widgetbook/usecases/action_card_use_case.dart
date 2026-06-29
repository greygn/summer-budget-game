import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Default',
  type: ActionCard,
)
Widget defaultActionCard(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  return Center(
    child: SizedBox(
      width: 360,
      height: 180,
      child: ActionCard(
        title: 'Morning Workout',
        subtitle: 'Improve your health and energy.',
        onTap: () {},
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.fitness_center_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
        ),
        trailing: const TimeBadge(
          duration: Duration(hours: 2),
        ),
        tags: const [
          AppTag(
            label: '+200 XP',
            icon: Icons.star_rounded,
            color: Colors.orange,
          ),
          AppTag(
            label: '+15 Energy',
            icon: Icons.bolt_rounded,
            color: Colors.amber,
          ),
          AppTag(
            label: 'Healthy',
            icon: Icons.favorite_rounded,
            color: Colors.red,
          ),
        ],
      ),
    ),
  );
}
