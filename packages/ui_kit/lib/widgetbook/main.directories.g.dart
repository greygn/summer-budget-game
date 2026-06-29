// dart format width=80
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_import, prefer_relative_imports, directives_ordering

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AppGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:ui_kit/widgetbook/usecases/action_card_use_case.dart'
    as _ui_kit_widgetbook_usecases_action_card_use_case;
import 'package:ui_kit/widgetbook/usecases/app_tag_use_case.dart'
    as _ui_kit_widgetbook_usecases_app_tag_use_case;
import 'package:ui_kit/widgetbook/usecases/expressive_result_stat_use_case.dart'
    as _ui_kit_widgetbook_usecases_expressive_result_stat_use_case;
import 'package:ui_kit/widgetbook/usecases/menu_button_use_case.dart'
    as _ui_kit_widgetbook_usecases_menu_button_use_case;
import 'package:ui_kit/widgetbook/usecases/mode_item_use_case.dart'
    as _ui_kit_widgetbook_usecases_mode_item_use_case;
import 'package:ui_kit/widgetbook/usecases/time_badge_use_case.dart'
    as _ui_kit_widgetbook_usecases_time_badge_use_case;
import 'package:widgetbook/widgetbook.dart' as _widgetbook;

final directories = <_widgetbook.WidgetbookNode>[
  _widgetbook.WidgetbookFolder(
    name: 'widgets',
    children: [
      _widgetbook.WidgetbookComponent(
        name: 'ActionCard',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _ui_kit_widgetbook_usecases_action_card_use_case
                .defaultActionCard,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'AppTag',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _ui_kit_widgetbook_usecases_app_tag_use_case.defaultTag,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Success',
            builder: _ui_kit_widgetbook_usecases_app_tag_use_case.successTag,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'With icon',
            builder: _ui_kit_widgetbook_usecases_app_tag_use_case.iconTag,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'ExpressiveResultStat',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _ui_kit_widgetbook_usecases_expressive_result_stat_use_case
                .stat,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'MenuButton',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder:
                _ui_kit_widgetbook_usecases_menu_button_use_case.menuButton,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'ModeItem',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Default',
            builder: _ui_kit_widgetbook_usecases_mode_item_use_case.mode,
          ),
        ],
      ),
      _widgetbook.WidgetbookComponent(
        name: 'TimeBadge',
        useCases: [
          _widgetbook.WidgetbookUseCase(
            name: 'Large',
            builder: _ui_kit_widgetbook_usecases_time_badge_use_case.largeBadge,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Medium',
            builder:
                _ui_kit_widgetbook_usecases_time_badge_use_case.mediumBadge,
          ),
          _widgetbook.WidgetbookUseCase(
            name: 'Small',
            builder: _ui_kit_widgetbook_usecases_time_badge_use_case.smallBadge,
          ),
        ],
      ),
    ],
  ),
];
