import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/src/core/constant/config.dart';
import 'package:procrastinator/src/core/di/logic/composition_root.dart';
import 'package:procrastinator/src/core/di/dependenies_containers/student_dependencies_container.dart';
import 'package:procrastinator/src/core/di/scopes/app_dependencies_scope.dart';
import 'package:procrastinator/src/core/utils/refined_logger.dart';

/// {@template student_app_scope}
/// StudentAppScope widget.
/// {@endtemplate}
class StudentAppScope extends StatefulWidget {
  /// {@macro student_app_scope}
  const StudentAppScope({
    required this.child,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Get the [_StudentAppScopeState] instance.
  static _StudentAppScopeState of(
    BuildContext context, {
    bool listen = true,
  }) {
    final studentScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_StudentAppScopeScope>()
        : context.getInheritedWidgetOfExactType<_StudentAppScopeScope>();
    return studentScope!.state;
  }

  /// Get the [StudentDependenciesContainer].
  static StudentDependenciesContainer depConOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final studentScope = listen
        ? context.dependOnInheritedWidgetOfExactType<_StudentAppScopeScope>()
        : context.getInheritedWidgetOfExactType<_StudentAppScopeScope>();
    return studentScope!.state.studentDependenciesContainer;
  }

  @override
  State<StudentAppScope> createState() => _StudentAppScopeState();
}

class _StudentAppScopeState extends State<StudentAppScope> {
  late final StudentDependenciesContainer studentDependenciesContainer;

  @override
  void initState() {
    super.initState();

    const config = Config();
    final user = AppScope.userOf(context, listen: false);
    final result =
        CompositionRoot(config, logger).composeStudentDependencies(user);
    studentDependenciesContainer = result.dependencies;
  }

  @override
  void didUpdateWidget(StudentAppScope oldWidget) {
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
              '_StudentAppScopeState State<StudentAppScope>',
            ),
          ),
      );

  @override
  Widget build(BuildContext context) => _StudentAppScopeScope(
        state: this,
        child: widget.child,
      );
}

/// {@template student_app_scope_scope}
/// _StudentAppScopeScope widget.
/// {@endtemplate}
class _StudentAppScopeScope extends InheritedWidget {
  /// {@macro student_app_scope_scope}
  const _StudentAppScopeScope({
    required super.child,
    required this.state,
    super.key, // ignore: unused_element
  });

  /// _StudentAppScopeState instance.
  final _StudentAppScopeState state;

  @override
  bool updateShouldNotify(_StudentAppScopeScope oldWidget) =>
      !identical(state, oldWidget.state) || state != oldWidget.state;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Scope of StudentApp',
            ),
          )
          ..add(
            ObjectFlagProperty<_StudentAppScopeState>(
              '_StudentAppScopeState',
              state,
              ifNull: 'none',
            ),
          )
          ..defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.offstage,
      );
}
