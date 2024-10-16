import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/logic/composition_root.dart';
import 'package:procrastinator/src/core/di/dependenies_containers/trainer_dependencies_container.dart';
import 'package:procrastinator/src/core/di/scopes/app_dependencies_scope.dart';
import 'package:procrastinator/src/core/utils/refined_logger.dart';

/// {@template trainer_app_scope}
/// TrainerAppScope widget.
/// {@endtemplate}
class TrainerAppScope extends StatefulWidget {
  /// {@macro trainer_app_scope}
  const TrainerAppScope({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Get the [_TrainerAppScopeState] instance.
  static _TrainerAppScopeState of(
    BuildContext context, {
    bool listen = true,
  }) {
    final trainerScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_TrainerAppScopeScope>()
        : context.getInheritedWidgetOfExactType<_TrainerAppScopeScope>();
    return trainerScope!.state;
  }

  @override
  State<TrainerAppScope> createState() => _TrainerAppScopeState();
}

class _TrainerAppScopeState extends State<TrainerAppScope> {
  late final TrainerDependenciesContainer trainerDependenciesContainer;

  @override
  void initState() {
    super.initState();
    const config = Config();
    final user = AppScope.userOf(context, listen: false);
    final result =
        CompositionRoot(config, logger).composeTrainerDependencies(user);
    trainerDependenciesContainer = result.dependencies;
  }

  @override
  void didUpdateWidget(TrainerAppScope oldWidget) {
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
              '_TrainerAppScopeState State<TrainerAppScope>',
            ),
          ),
      );

  @override
  Widget build(BuildContext context) => _TrainerAppScopeScope(
        state: this,
        child: widget.child,
      );
}

/// {@template trainer_app_scope_scope}
/// _TrainerAppScopeScope widget.
/// {@endtemplate}
class _TrainerAppScopeScope extends InheritedWidget {
  /// {@macro trainer_app_scope_scope}
  const _TrainerAppScopeScope({
    required super.child,
    required this.state,
    super.key, // ignore: unused_element
  });

  /// _TrainerAppScopeState instance.
  final _TrainerAppScopeState state;

  @override
  bool updateShouldNotify(_TrainerAppScopeScope oldWidget) =>
      !identical(state, oldWidget.state) || state != oldWidget.state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Scope of TrainerApp',
            ),
          )
          ..add(
            ObjectFlagProperty<_TrainerAppScopeState>(
              '_TrainerAppScopeState',
              state,
              ifNull: 'none',
            ),
          )
          ..defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.offstage,
      );
}
