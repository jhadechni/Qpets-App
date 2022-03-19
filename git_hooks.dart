import "dart:io";

import "package:dart_pre_commit/dart_pre_commit.dart";
import "package:git_hooks/git_hooks.dart";
import 'package:riverpod/riverpod.dart';

void main(List<String> arguments) {
  final params = {Git.preCommit: _preCommit};
  GitHooks.call(arguments, params);
}

Future<bool> _preCommit() async {
  // optional: create an IoC-Container for easier initialization of the hooks
  final container = ProviderContainer();

  // obtain the hooks instance from the IoC with your custom config
  final hook = await container.read(
    HooksProvider.hookProvider(
      const HooksConfig(),
    ).future,
  );

  // alternatively, you can instanciate Hooks directly:
  // final hook = Hooks(...);

  // run all hooks
  final result = await hook();

  // report the result
  return result.isSuccess;
}
