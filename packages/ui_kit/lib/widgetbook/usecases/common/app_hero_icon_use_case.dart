import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import '../../../widgets/common/app_hero_icon.dart';


@widgetbook.UseCase(name: 'Event Success', type: AppHeroIcon)
Widget buildAppHeroIconSuccessUseCase(BuildContext context) {
  final theme = Theme.of(context);
  return Center(
    child: AppHeroIcon(
      icon: Icons.auto_awesome_rounded,
      color: theme.colorScheme.primary,
      onColor: theme.colorScheme.onPrimary,
      heroTag: 'success_icon',
    ),
  );
}

@widgetbook.UseCase(name: 'Event Danger', type: AppHeroIcon)
Widget buildAppHeroIconDangerUseCase(BuildContext context) {
  final theme = Theme.of(context);
  return Center(
    child: AppHeroIcon(
      icon: Icons.warning_rounded,
      color: theme.colorScheme.error,
      onColor: theme.colorScheme.onError,
      heroTag: 'danger_icon',
    ),
  );
}