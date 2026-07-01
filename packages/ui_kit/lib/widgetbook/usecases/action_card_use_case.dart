import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Adaptive',
  type: ActionCard,
)
Widget adaptiveActionCard(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;

  final screenSize = context.knobs.object.dropdown<String>(
    label: 'Screen size',
    options: const [
      'compact',
      'medium',
      'expanded',
      'large',
      'custom',
    ],
    initialOption: 'compact',
  );

  final width = switch (screenSize) {
    'compact' => 320.0,
    'medium' => 700.0,
    'expanded' => 960.0,
    'large' => 1320.0,
    _ => context.knobs.double.slider(
      label: 'Width',
      initialValue: 360,
      min: 240,
      max: 1600,
      divisions: 68,
    ),
  };

  final showLeading = context.knobs.boolean(
    label: 'Show leading',
    initialValue: true,
  );

  final showTrailing = context.knobs.boolean(
    label: 'Show trailing',
    initialValue: true,
  );

  final showTags = context.knobs.boolean(
    label: 'Show tags',
    initialValue: true,
  );

  final subtitle = context.knobs.string(
    label: 'Subtitle',
    initialValue: 'Improve your health and energy.',
  );

  return Center(
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: width,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: ActionCard(
        title: 'Morning Workout',
        subtitle: subtitle.isEmpty ? null : subtitle,
        onTap: () {},
        leading: showLeading
            ? Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(18),
          ),
          child: Icon(
            Icons.fitness_center_rounded,
            color: colorScheme.onPrimaryContainer,
          ),
        )
            : null,
        trailing: showTrailing
            ? const TimeBadge(
          duration: Duration(hours: 2),
        )
            : null,
        tags: showTags
            ? const [
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
        ]
            : const [],
      ),
    ),
  );
}
