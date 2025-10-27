// @dart=3.6
// ignore_for_file: directives_ordering
// build_runner >=2.4.16
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:retrofit_generator/retrofit_generator.dart' as _i2;
import 'package:freezed/builder.dart' as _i3;
import 'package:json_serializable/builder.dart' as _i4;
import 'package:hive_generator/hive_generator.dart' as _i5;
import 'package:source_gen/builder.dart' as _i6;
import 'package:mockito/src/builder.dart' as _i7;
import 'package:build_config/build_config.dart' as _i8;
import 'package:auto_route_generator/builder.dart' as _i9;
import 'dart:isolate' as _i10;
import 'package:build_runner/src/build_script_generate/build_process_state.dart'
    as _i11;
import 'package:build_runner/build_runner.dart' as _i12;
import 'dart:io' as _i13;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    r'retrofit_generator:retrofit_generator',
    [_i2.retrofitBuilder],
    _i1.toDependentsOf(r'retrofit_generator'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'freezed:freezed',
    [_i3.freezed],
    _i1.toDependentsOf(r'freezed'),
    hideOutput: false,
  ),
  _i1.apply(
    r'json_serializable:json_serializable',
    [_i4.jsonSerializable],
    _i1.toDependentsOf(r'json_serializable'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'hive_generator:hive_generator',
    [_i5.getBuilder],
    _i1.toDependentsOf(r'hive_generator'),
    hideOutput: true,
    appliesBuilders: const [r'source_gen:combining_builder'],
  ),
  _i1.apply(
    r'source_gen:combining_builder',
    [_i6.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'source_gen:part_cleanup'],
  ),
  _i1.apply(
    r'mockito:mockBuilder',
    [_i7.buildMocks],
    _i1.toDependentsOf(r'mockito'),
    hideOutput: false,
    defaultGenerateFor: const _i8.InputSet(include: [r'test/**']),
  ),
  _i1.apply(
    r'auto_route_generator:auto_route_generator',
    [_i9.autoRouteBuilder],
    _i1.toDependentsOf(r'auto_route_generator'),
    hideOutput: true,
  ),
  _i1.apply(
    r'auto_route_generator:auto_router_module_generator',
    [_i9.autoRouterModuleBuilder],
    _i1.toDependentsOf(r'auto_route_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'auto_route_generator:auto_router_generator',
    [_i9.autoRouterBuilder],
    _i1.toDependentsOf(r'auto_route_generator'),
    hideOutput: false,
  ),
  _i1.applyPostProcess(
    r'source_gen:part_cleanup',
    _i6.partCleanup,
  ),
];
void main(
  List<String> args, [
  _i10.SendPort? sendPort,
]) async {
  await _i11.buildProcessState.receive(sendPort);
  _i11.buildProcessState.isolateExitCode = await _i12.run(
    args,
    _builders,
  );
  _i13.exitCode = _i11.buildProcessState.isolateExitCode!;
  await _i11.buildProcessState.send(sendPort);
}
