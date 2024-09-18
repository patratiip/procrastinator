import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/logic/composition_root.dart';
import 'package:procrastinator/src/core/di/model/management_dependencies_container.dart';
import 'package:procrastinator/src/core/di/widget/app_dependencies_scope.dart';
import 'package:procrastinator/src/core/utils/refined_logger.dart';

/// {@template management_app_scope}
/// ManagementAppScope widget.
/// {@endtemplate}
class ManagementAppScope extends StatefulWidget {
  /// {@macro management_app_scope}
  const ManagementAppScope({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Get the [_ManagementAppScopeState] instance.
  static _ManagementAppScopeState of(
    BuildContext context, {
    bool listen = true,
  }) {
    final managementScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_ManagementAppScopeScope>()
        : context.getInheritedWidgetOfExactType<_ManagementAppScopeScope>();
    return managementScope!.state;
  }

  @override
  State<ManagementAppScope> createState() => _ManagementAppScopeState();
}

class _ManagementAppScopeState extends State<ManagementAppScope> {
  late final ManagementDependenciesContainer managementDependenciesContainer;

  @override
  void initState() {
    super.initState();

    const config = Config();
    final user = AppDependenciesScope.of(context).currentUser;
    final result = CompositionRoot(config, logger)
        .composeManagementDependencies(user.userId);
    managementDependenciesContainer = result.dependencies;

    // Первичная инициализация виджета
  }

  @override
  void didUpdateWidget(ManagementAppScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Конфигурация виджета изменилась
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Изменилась конфигурация InheritedWidget'ов
    // Также вызывается после initState, но до build'а
  }

  @override
  void dispose() {
    // Перманетное удаление стейта из дерева
    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              '_ManagementAppScopeState State<ManagementAppScope>',
            ),
          ),
      );

  @override
  Widget build(BuildContext context) => _ManagementAppScopeScope(
        state: this,
        child: widget.child,
      );
}

/// {@template management_app_scope_scope}
/// _ManagementAppScopeScope widget.
/// {@endtemplate}
class _ManagementAppScopeScope extends InheritedWidget {
  /// {@macro management_app_scope_scope}
  const _ManagementAppScopeScope({
    required super.child,
    required this.state,
    super.key, // ignore: unused_element
  });

  /// _ManagementAppScopeState instance.
  final _ManagementAppScopeState state;

  @override
  bool updateShouldNotify(_ManagementAppScopeScope oldWidget) =>
      !identical(state, oldWidget.state) || state != oldWidget.state;

      @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Scope of ManagementApp',
            ),
          )
          ..add(
            ObjectFlagProperty<_ManagementAppScopeState>(
              '_ManagementAppScopeState',
              state,
              ifNull: 'none',
            ),
          )
          ..defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.offstage,
      );
}
