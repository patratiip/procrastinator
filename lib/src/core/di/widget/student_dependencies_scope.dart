import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:procrastinator/src/core/di/model/student_dependencies_container.dart';
import 'package:procrastinator/src/core/utils/extensions/context_extension.dart';

/// {@template dependencies_scope}
/// A scope that provides composed [StudentDependenciesContainer].
///
/// **Testing**:
///
/// To use [StudentDependenciesScope] in tests, it is needed to wrap the widget with
/// [StudentDependenciesScope], extend [TestDependenciesContainer] and provide the
/// dependencies that are needed for the test.
///
/// ```dart
/// class AuthDependenciesContainer extends TestDependenciesContainer {
///   // for example, use mocks created by mockito, or pass fake/real implementations
///   // via constructor.
///   @override
///   final MockAuthRepository authRepository = MockAuthRepository();
/// }
/// ```
/// {@endtemplate}
class StudentDependenciesScope extends InheritedWidget {
  /// {@macro dependencies_scope}
  const StudentDependenciesScope({
    required super.child,
    required this.dependencies,
    super.key,
  });

  /// Container with dependencies.
  final StudentDependenciesContainer dependencies;

  /// Get the dependencies from the [context].
  static StudentDependenciesContainer of(BuildContext context) =>
      context.inhOf<StudentDependenciesScope>(listen: false).dependencies;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(
      DiagnosticsProperty<StudentDependenciesContainer>(
          'dependencies', dependencies),
    );
  }

  @override
  bool updateShouldNotify(StudentDependenciesScope oldWidget) => false;
}
