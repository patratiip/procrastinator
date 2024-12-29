import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:procrastinator/src/platform/app/di/app_dependencies_container.dart';
import 'package:procrastinator/src/platform/auth/bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

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
    bool listen = false,
  }) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_AppScopeInherited>()
        : context.getInheritedWidgetOfExactType<_AppScopeInherited>();
    return scope!.state;
  }

  /// Get the [AppDependenciesContainer] instance.
  static AppDependenciesContainer depConOf(
    BuildContext context, {
    bool listen = false,
  }) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_AppScopeInherited>()
        : context.getInheritedWidgetOfExactType<_AppScopeInherited>();
    return scope!.state.dependenciesContainer;
  }

  /// Get the [MyUser] instance.
  static MyUser userOf(
    BuildContext context, {
    bool listen = false,
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
