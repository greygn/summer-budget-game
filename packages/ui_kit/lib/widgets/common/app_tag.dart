import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class AppTag extends StatelessWidget {
  final String label;
  final Color color;
  final double? fontSize;
  final EdgeInsetsGeometry? padding;

  const AppTag({
    super.key,
    required this.label,
    required this.color,
    this.fontSize,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: fontSize ?? 11,
          fontWeight: FontWeight.w900,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

@widgetbook.UseCase(name: 'Default', type: AppTag)
Widget buildAppTagUseCase(BuildContext context) {
  return Center(
    child: AppTag(
      label: context.knobs.string(label: 'Label', initialValue: 'BASIC'),
      color: context.knobs.color(label: 'Color', initialValue: Colors.blue),
    ),
  );
}
