import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/composition_root.dart';
import 'package:procrastinator/src/app_management/di/management_dependencies_container.dart';
import 'package:procrastinator/src/platform/app/di/app_scope.dart';
import 'package:procrastinator/src/core/utils/logger.dart';

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
    bool listen = false,
  }) {
    final managementScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_ManagementAppScopeScope>()
        : context.getInheritedWidgetOfExactType<_ManagementAppScopeScope>();
    return managementScope!.state;
  }

  /// Get the [ManagementDependenciesContainer] instance.
  static ManagementDependenciesContainer depOf(
    BuildContext context, {
    bool listen = false,
  }) {
    final managementScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_ManagementAppScopeScope>()
        : context.getInheritedWidgetOfExactType<_ManagementAppScopeScope>();
    return managementScope!.state.managementDependenciesContainer;
  }

  @override
  State<ManagementAppScope> createState() => _ManagementAppScopeState();
}

class _ManagementAppScopeState extends State<ManagementAppScope> {
  late final ManagementDependenciesContainer managementDependenciesContainer;

  @override
  void initState() {
    super.initState();
    final config = AppScope.depConOf(context).config;
    final user = AppScope.userOf(context);
    final result =
        CompositionRoot(config, logger).composeManagementDependencies(user);
    managementDependenciesContainer = result.dependencies;
  }

  @override
  void didUpdateWidget(ManagementAppScope oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
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
