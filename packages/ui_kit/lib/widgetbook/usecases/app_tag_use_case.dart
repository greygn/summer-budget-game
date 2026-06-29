import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

import 'package:ui_kit/ui_kit.dart';

@UseCase(
  name: 'Default',
  type: AppTag,
)
Widget defaultTag(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Default',
    ),
  );
}

@UseCase(
  name: 'With icon',
  type: AppTag,
)
Widget iconTag(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Premium',
      icon: Icons.star,
    ),
  );
}

@UseCase(
  name: 'Success',
  type: AppTag,
)
Widget successTag(BuildContext context) {
  return const Center(
    child: AppTag(
      label: 'Success',
      color: Colors.green,
    ),
  );
}
