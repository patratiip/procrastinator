import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/core/di/dependenies_containers/app_dependencies_container.dart';
import 'package:procrastinator/src/features/app/bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

// /// {@template dependencies_scope}
// /// A scope that provides composed [AppDependenciesContainer].
// ///
// /// **Testing**:
// ///
// /// To use [AppDependenciesScope] in tests, it is needed to wrap the widget with
// /// [AppDependenciesScope], extend [TestDependenciesContainer] and provide the
// /// dependencies that are needed for the test.
// ///
// /// ```dart
// /// class AuthDependenciesContainer extends TestDependenciesContainer {
// ///   // for example, use mocks created by mockito, or pass fake/real implementations
// ///   // via constructor.
// ///   @override
// ///   final MockAuthRepository authRepository = MockAuthRepository();
// /// }
// /// ```
// /// {@endtemplate}
// class AppDependenciesScope extends InheritedWidget {
//   /// {@macro dependencies_scope}
//   const AppDependenciesScope({
//     required super.child,
//     required this.dependencies,
//     super.key,
//   });

//   /// Container with dependencies.
//   final AppDependenciesContainer dependencies;

//   /// Get the dependencies from the [context].
//   static AppDependenciesContainer of(BuildContext context) =>
//       context.inhOf<AppDependenciesScope>(listen: false).dependencies;

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//       DiagnosticsProperty<AppDependenciesContainer>(
//           'dependencies', dependencies),
//     );
//   }

//   @override
//   bool updateShouldNotify(AppDependenciesScope oldWidget) => false;
// }

/// {@template AppScope_scope}
/// AppScopeScope widget.
/// {@endtemplate}
class AppScope extends StatefulWidget {
  /// {@macro AppScope_scope}
  const AppScope({
    required this.child,
    required this.dependencies,
    super.key,
  });

  /// The child widget.
  final Widget child;

  /// Container with dependencies.
  final AppDependenciesContainer dependencies;

  /// Get the [_AppScopeState] instance.
  static _AppScopeState of(
    BuildContext context, {
    bool listen = true,
  }) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_AppScopeInherited>()
        : context.getInheritedWidgetOfExactType<_AppScopeInherited>();
    return scope!.state;
  }

  /// Get the [AppDependenciesContainer] instance.
  static AppDependenciesContainer depConOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_AppScopeInherited>()
        : context.getInheritedWidgetOfExactType<_AppScopeInherited>();
    return scope!.state.dependenciesContainer;
  }

  /// Get the [MyUser] instance.
  static MyUser userOf(
    BuildContext context, {
    bool listen = true,
  }) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_AppScopeInherited>()
        : context.getInheritedWidgetOfExactType<_AppScopeInherited>();
    return scope!.currentUser!;
  }

  @override
  State<AppScope> createState() => _AppScopeState();
}

class _AppScopeState extends State<AppScope> {
  late final AppDependenciesContainer dependenciesContainer;

  @override
  void initState() {
    super.initState();
    dependenciesContainer = widget.dependencies;
    // Initialization of the widget
  }

  @override
  void didUpdateWidget(AppScope oldWidget) {
    super.didUpdateWidget(oldWidget);
    // The configuration of the widget has changed
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // InheritedWidget configuration has changed
    // Also called after initState, but before build
  }

  @override
  void dispose() {
    // Permanent deletion of a state from a tree

    super.dispose();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              '_AppScopeState State<AppScope>',
            ),
          ),
      );

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          return _AppScopeInherited(
            state: this,
            currentUser: state.user,
            child: widget.child,
          );
        },
      );
}

/// {@template AppScope_scope_inherited}
/// _AppScopeScopeInherited widget.
/// {@endtemplate}
class _AppScopeInherited extends InheritedWidget {
  /// {@macro AppScope_scope_inherited}
  const _AppScopeInherited({
    required super.child,
    required this.state,
    required this.currentUser,
    super.key, // ignore: unused_element
  });

  /// _AppScopeScopeState instance.
  final _AppScopeState state;

  final MyUser? currentUser;

  @override
  bool updateShouldNotify(_AppScopeInherited oldWidget) =>
      !identical(state, oldWidget.state) ||
      !identical(currentUser, oldWidget.currentUser) ||
      state != oldWidget.state ||
      currentUser != oldWidget.currentUser;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) =>
      super.debugFillProperties(
        properties
          ..add(
            StringProperty(
              'description',
              'Scope of AppScope',
            ),
          )
          ..add(
            ObjectFlagProperty<_AppScopeState>(
              '_AppScopeState',
              state,
              ifNull: 'none',
            ),
          )
          ..defaultDiagnosticsTreeStyle = DiagnosticsTreeStyle.offstage,
      );
}