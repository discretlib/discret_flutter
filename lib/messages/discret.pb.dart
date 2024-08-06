// ignore_for_file: invalid_language_version_override

import 'dart:async';
import 'dart:typed_data';
import 'package:rinf/rinf.dart';

//
//  Generated code. Do not modify.
//  source: discret.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

/// [RINF:DART-SIGNAL]
class Connect extends $pb.GeneratedMessage {
  factory Connect({
    $core.int? id,
    $core.List<$core.int>? keyMaterial,
    $core.bool? allowCreate,
    $core.String? applicationName,
    $core.String? dataPath,
    $core.String? dataModel,
    $core.String? configuration,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (keyMaterial != null) {
      $result.keyMaterial = keyMaterial;
    }
    if (allowCreate != null) {
      $result.allowCreate = allowCreate;
    }
    if (applicationName != null) {
      $result.applicationName = applicationName;
    }
    if (dataPath != null) {
      $result.dataPath = dataPath;
    }
    if (dataModel != null) {
      $result.dataModel = dataModel;
    }
    if (configuration != null) {
      $result.configuration = configuration;
    }
    return $result;
  }
  Connect._() : super();
  factory Connect.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Connect.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Connect', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'keyMaterial', $pb.PbFieldType.OY)
    ..aOB(3, _omitFieldNames ? '' : 'allowCreate')
    ..aOS(4, _omitFieldNames ? '' : 'applicationName')
    ..aOS(5, _omitFieldNames ? '' : 'dataPath')
    ..aOS(6, _omitFieldNames ? '' : 'dataModel')
    ..aOS(7, _omitFieldNames ? '' : 'configuration')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Connect clone() => Connect()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Connect copyWith(void Function(Connect) updates) => super.copyWith((message) => updates(message as Connect)) as Connect;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Connect create() => Connect._();
  Connect createEmptyInstance() => create();
  static $pb.PbList<Connect> createRepeated() => $pb.PbList<Connect>();
  @$core.pragma('dart2js:noInline')
  static Connect getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Connect>(create);
  static Connect? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get keyMaterial => $_getN(1);
  @$pb.TagNumber(2)
  set keyMaterial($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasKeyMaterial() => $_has(1);
  @$pb.TagNumber(2)
  void clearKeyMaterial() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get allowCreate => $_getBF(2);
  @$pb.TagNumber(3)
  set allowCreate($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAllowCreate() => $_has(2);
  @$pb.TagNumber(3)
  void clearAllowCreate() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get applicationName => $_getSZ(3);
  @$pb.TagNumber(4)
  set applicationName($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasApplicationName() => $_has(3);
  @$pb.TagNumber(4)
  void clearApplicationName() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get dataPath => $_getSZ(4);
  @$pb.TagNumber(5)
  set dataPath($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasDataPath() => $_has(4);
  @$pb.TagNumber(5)
  void clearDataPath() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dataModel => $_getSZ(5);
  @$pb.TagNumber(6)
  set dataModel($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDataModel() => $_has(5);
  @$pb.TagNumber(6)
  void clearDataModel() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get configuration => $_getSZ(6);
  @$pb.TagNumber(7)
  set configuration($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasConfiguration() => $_has(6);
  @$pb.TagNumber(7)
  void clearConfiguration() => clearField(7);
}

/// [RINF:DART-SIGNAL]
class Login extends $pb.GeneratedMessage {
  factory Login({
    $core.int? id,
    $core.String? username,
    $core.String? password,
    $core.bool? allowCreate,
    $core.String? applicationName,
    $core.String? dataPath,
    $core.String? dataModel,
    $core.String? configuration,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (username != null) {
      $result.username = username;
    }
    if (password != null) {
      $result.password = password;
    }
    if (allowCreate != null) {
      $result.allowCreate = allowCreate;
    }
    if (applicationName != null) {
      $result.applicationName = applicationName;
    }
    if (dataPath != null) {
      $result.dataPath = dataPath;
    }
    if (dataModel != null) {
      $result.dataModel = dataModel;
    }
    if (configuration != null) {
      $result.configuration = configuration;
    }
    return $result;
  }
  Login._() : super();
  factory Login.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Login.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Login', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'username')
    ..aOS(3, _omitFieldNames ? '' : 'password')
    ..aOB(4, _omitFieldNames ? '' : 'allowCreate')
    ..aOS(5, _omitFieldNames ? '' : 'applicationName')
    ..aOS(6, _omitFieldNames ? '' : 'dataPath')
    ..aOS(7, _omitFieldNames ? '' : 'dataModel')
    ..aOS(8, _omitFieldNames ? '' : 'configuration')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Login clone() => Login()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Login copyWith(void Function(Login) updates) => super.copyWith((message) => updates(message as Login)) as Login;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Login create() => Login._();
  Login createEmptyInstance() => create();
  static $pb.PbList<Login> createRepeated() => $pb.PbList<Login>();
  @$core.pragma('dart2js:noInline')
  static Login getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Login>(create);
  static Login? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get username => $_getSZ(1);
  @$pb.TagNumber(2)
  set username($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUsername() => $_has(1);
  @$pb.TagNumber(2)
  void clearUsername() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get password => $_getSZ(2);
  @$pb.TagNumber(3)
  set password($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPassword() => $_has(2);
  @$pb.TagNumber(3)
  void clearPassword() => clearField(3);

  @$pb.TagNumber(4)
  $core.bool get allowCreate => $_getBF(3);
  @$pb.TagNumber(4)
  set allowCreate($core.bool v) { $_setBool(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasAllowCreate() => $_has(3);
  @$pb.TagNumber(4)
  void clearAllowCreate() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get applicationName => $_getSZ(4);
  @$pb.TagNumber(5)
  set applicationName($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasApplicationName() => $_has(4);
  @$pb.TagNumber(5)
  void clearApplicationName() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get dataPath => $_getSZ(5);
  @$pb.TagNumber(6)
  set dataPath($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasDataPath() => $_has(5);
  @$pb.TagNumber(6)
  void clearDataPath() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get dataModel => $_getSZ(6);
  @$pb.TagNumber(7)
  set dataModel($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasDataModel() => $_has(6);
  @$pb.TagNumber(7)
  void clearDataModel() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get configuration => $_getSZ(7);
  @$pb.TagNumber(8)
  set configuration($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasConfiguration() => $_has(7);
  @$pb.TagNumber(8)
  void clearConfiguration() => clearField(8);
}

/// [RINF:DART-SIGNAL]
class Query extends $pb.GeneratedMessage {
  factory Query({
    $core.int? id,
    $core.String? query,
    $core.String? parameters,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (query != null) {
      $result.query = query;
    }
    if (parameters != null) {
      $result.parameters = parameters;
    }
    return $result;
  }
  Query._() : super();
  factory Query.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Query.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Query', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..aOS(3, _omitFieldNames ? '' : 'parameters')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Query clone() => Query()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Query copyWith(void Function(Query) updates) => super.copyWith((message) => updates(message as Query)) as Query;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Query create() => Query._();
  Query createEmptyInstance() => create();
  static $pb.PbList<Query> createRepeated() => $pb.PbList<Query>();
  @$core.pragma('dart2js:noInline')
  static Query getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Query>(create);
  static Query? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get parameters => $_getSZ(2);
  @$pb.TagNumber(3)
  set parameters($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearParameters() => clearField(3);
}

/// [RINF:DART-SIGNAL]
class Mutate extends $pb.GeneratedMessage {
  factory Mutate({
    $core.int? id,
    $core.String? query,
    $core.String? parameters,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (query != null) {
      $result.query = query;
    }
    if (parameters != null) {
      $result.parameters = parameters;
    }
    return $result;
  }
  Mutate._() : super();
  factory Mutate.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Mutate.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Mutate', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..aOS(3, _omitFieldNames ? '' : 'parameters')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Mutate clone() => Mutate()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Mutate copyWith(void Function(Mutate) updates) => super.copyWith((message) => updates(message as Mutate)) as Mutate;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Mutate create() => Mutate._();
  Mutate createEmptyInstance() => create();
  static $pb.PbList<Mutate> createRepeated() => $pb.PbList<Mutate>();
  @$core.pragma('dart2js:noInline')
  static Mutate getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Mutate>(create);
  static Mutate? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get parameters => $_getSZ(2);
  @$pb.TagNumber(3)
  set parameters($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearParameters() => clearField(3);
}

/// [RINF:DART-SIGNAL]
class Delete extends $pb.GeneratedMessage {
  factory Delete({
    $core.int? id,
    $core.String? query,
    $core.String? parameters,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (query != null) {
      $result.query = query;
    }
    if (parameters != null) {
      $result.parameters = parameters;
    }
    return $result;
  }
  Delete._() : super();
  factory Delete.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Delete.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Delete', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'query')
    ..aOS(3, _omitFieldNames ? '' : 'parameters')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Delete clone() => Delete()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Delete copyWith(void Function(Delete) updates) => super.copyWith((message) => updates(message as Delete)) as Delete;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Delete create() => Delete._();
  Delete createEmptyInstance() => create();
  static $pb.PbList<Delete> createRepeated() => $pb.PbList<Delete>();
  @$core.pragma('dart2js:noInline')
  static Delete getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Delete>(create);
  static Delete? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get query => $_getSZ(1);
  @$pb.TagNumber(2)
  set query($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasQuery() => $_has(1);
  @$pb.TagNumber(2)
  void clearQuery() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get parameters => $_getSZ(2);
  @$pb.TagNumber(3)
  set parameters($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasParameters() => $_has(2);
  @$pb.TagNumber(3)
  void clearParameters() => clearField(3);
}

/// [RINF:DART-SIGNAL]
class VerifyingKey extends $pb.GeneratedMessage {
  factory VerifyingKey({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  VerifyingKey._() : super();
  factory VerifyingKey.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory VerifyingKey.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'VerifyingKey', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  VerifyingKey clone() => VerifyingKey()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  VerifyingKey copyWith(void Function(VerifyingKey) updates) => super.copyWith((message) => updates(message as VerifyingKey)) as VerifyingKey;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static VerifyingKey create() => VerifyingKey._();
  VerifyingKey createEmptyInstance() => create();
  static $pb.PbList<VerifyingKey> createRepeated() => $pb.PbList<VerifyingKey>();
  @$core.pragma('dart2js:noInline')
  static VerifyingKey getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<VerifyingKey>(create);
  static VerifyingKey? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

/// [RINF:DART-SIGNAL]
class PrivateRoom extends $pb.GeneratedMessage {
  factory PrivateRoom({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  PrivateRoom._() : super();
  factory PrivateRoom.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory PrivateRoom.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'PrivateRoom', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  PrivateRoom clone() => PrivateRoom()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  PrivateRoom copyWith(void Function(PrivateRoom) updates) => super.copyWith((message) => updates(message as PrivateRoom)) as PrivateRoom;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static PrivateRoom create() => PrivateRoom._();
  PrivateRoom createEmptyInstance() => create();
  static $pb.PbList<PrivateRoom> createRepeated() => $pb.PbList<PrivateRoom>();
  @$core.pragma('dart2js:noInline')
  static PrivateRoom getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<PrivateRoom>(create);
  static PrivateRoom? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

/// [RINF:DART-SIGNAL]
class Invite extends $pb.GeneratedMessage {
  factory Invite({
    $core.int? id,
    $core.String? room,
    $core.String? authorisation,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (room != null) {
      $result.room = room;
    }
    if (authorisation != null) {
      $result.authorisation = authorisation;
    }
    return $result;
  }
  Invite._() : super();
  factory Invite.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Invite.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Invite', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'room')
    ..aOS(3, _omitFieldNames ? '' : 'authorisation')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Invite clone() => Invite()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Invite copyWith(void Function(Invite) updates) => super.copyWith((message) => updates(message as Invite)) as Invite;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Invite create() => Invite._();
  Invite createEmptyInstance() => create();
  static $pb.PbList<Invite> createRepeated() => $pb.PbList<Invite>();
  @$core.pragma('dart2js:noInline')
  static Invite getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Invite>(create);
  static Invite? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get room => $_getSZ(1);
  @$pb.TagNumber(2)
  set room($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasRoom() => $_has(1);
  @$pb.TagNumber(2)
  void clearRoom() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get authorisation => $_getSZ(2);
  @$pb.TagNumber(3)
  set authorisation($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasAuthorisation() => $_has(2);
  @$pb.TagNumber(3)
  void clearAuthorisation() => clearField(3);
}

/// [RINF:DART-SIGNAL]
class AcceptInvite extends $pb.GeneratedMessage {
  factory AcceptInvite({
    $core.int? id,
    $core.String? invite,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (invite != null) {
      $result.invite = invite;
    }
    return $result;
  }
  AcceptInvite._() : super();
  factory AcceptInvite.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AcceptInvite.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AcceptInvite', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'invite')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AcceptInvite clone() => AcceptInvite()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AcceptInvite copyWith(void Function(AcceptInvite) updates) => super.copyWith((message) => updates(message as AcceptInvite)) as AcceptInvite;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AcceptInvite create() => AcceptInvite._();
  AcceptInvite createEmptyInstance() => create();
  static $pb.PbList<AcceptInvite> createRepeated() => $pb.PbList<AcceptInvite>();
  @$core.pragma('dart2js:noInline')
  static AcceptInvite getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AcceptInvite>(create);
  static AcceptInvite? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get invite => $_getSZ(1);
  @$pb.TagNumber(2)
  set invite($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasInvite() => $_has(1);
  @$pb.TagNumber(2)
  void clearInvite() => clearField(2);
}

/// [RINF:DART-SIGNAL]
class DataModel extends $pb.GeneratedMessage {
  factory DataModel({
    $core.int? id,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    return $result;
  }
  DataModel._() : super();
  factory DataModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory DataModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'DataModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  DataModel clone() => DataModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  DataModel copyWith(void Function(DataModel) updates) => super.copyWith((message) => updates(message as DataModel)) as DataModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static DataModel create() => DataModel._();
  DataModel createEmptyInstance() => create();
  static $pb.PbList<DataModel> createRepeated() => $pb.PbList<DataModel>();
  @$core.pragma('dart2js:noInline')
  static DataModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<DataModel>(create);
  static DataModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);
}

/// [RINF:DART-SIGNAL]
class UpdateDataModel extends $pb.GeneratedMessage {
  factory UpdateDataModel({
    $core.int? id,
    $core.String? datamodel,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (datamodel != null) {
      $result.datamodel = datamodel;
    }
    return $result;
  }
  UpdateDataModel._() : super();
  factory UpdateDataModel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpdateDataModel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'UpdateDataModel', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'datamodel')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  UpdateDataModel clone() => UpdateDataModel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  UpdateDataModel copyWith(void Function(UpdateDataModel) updates) => super.copyWith((message) => updates(message as UpdateDataModel)) as UpdateDataModel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static UpdateDataModel create() => UpdateDataModel._();
  UpdateDataModel createEmptyInstance() => create();
  static $pb.PbList<UpdateDataModel> createRepeated() => $pb.PbList<UpdateDataModel>();
  @$core.pragma('dart2js:noInline')
  static UpdateDataModel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpdateDataModel>(create);
  static UpdateDataModel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get datamodel => $_getSZ(1);
  @$pb.TagNumber(2)
  set datamodel($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasDatamodel() => $_has(1);
  @$pb.TagNumber(2)
  void clearDatamodel() => clearField(2);
}

/// [RINF:DART-SIGNAL]
class SetLogLevel extends $pb.GeneratedMessage {
  factory SetLogLevel({
    $core.int? id,
    $core.String? level,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (level != null) {
      $result.level = level;
    }
    return $result;
  }
  SetLogLevel._() : super();
  factory SetLogLevel.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SetLogLevel.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SetLogLevel', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOS(2, _omitFieldNames ? '' : 'level')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SetLogLevel clone() => SetLogLevel()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SetLogLevel copyWith(void Function(SetLogLevel) updates) => super.copyWith((message) => updates(message as SetLogLevel)) as SetLogLevel;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SetLogLevel create() => SetLogLevel._();
  SetLogLevel createEmptyInstance() => create();
  static $pb.PbList<SetLogLevel> createRepeated() => $pb.PbList<SetLogLevel>();
  @$core.pragma('dart2js:noInline')
  static SetLogLevel getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SetLogLevel>(create);
  static SetLogLevel? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get level => $_getSZ(1);
  @$pb.TagNumber(2)
  set level($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasLevel() => $_has(1);
  @$pb.TagNumber(2)
  void clearLevel() => clearField(2);
}

/// [RINF:RUST-SIGNAL]
class ResultMsg extends $pb.GeneratedMessage {static final rustSignalStream =
    resultMsgController.stream.asBroadcastStream();

  factory ResultMsg({
    $core.int? id,
    $core.bool? successful,
    $core.String? error,
    $core.String? data,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (successful != null) {
      $result.successful = successful;
    }
    if (error != null) {
      $result.error = error;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  ResultMsg._() : super();
  factory ResultMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResultMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResultMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..a<$core.int>(1, _omitFieldNames ? '' : 'id', $pb.PbFieldType.O3)
    ..aOB(2, _omitFieldNames ? '' : 'successful')
    ..aOS(3, _omitFieldNames ? '' : 'error')
    ..aOS(4, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResultMsg clone() => ResultMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResultMsg copyWith(void Function(ResultMsg) updates) => super.copyWith((message) => updates(message as ResultMsg)) as ResultMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResultMsg create() => ResultMsg._();
  ResultMsg createEmptyInstance() => create();
  static $pb.PbList<ResultMsg> createRepeated() => $pb.PbList<ResultMsg>();
  @$core.pragma('dart2js:noInline')
  static ResultMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResultMsg>(create);
  static ResultMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get id => $_getIZ(0);
  @$pb.TagNumber(1)
  set id($core.int v) { $_setSignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.bool get successful => $_getBF(1);
  @$pb.TagNumber(2)
  set successful($core.bool v) { $_setBool(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSuccessful() => $_has(1);
  @$pb.TagNumber(2)
  void clearSuccessful() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get error => $_getSZ(2);
  @$pb.TagNumber(3)
  set error($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasError() => $_has(2);
  @$pb.TagNumber(3)
  void clearError() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get data => $_getSZ(3);
  @$pb.TagNumber(4)
  set data($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasData() => $_has(3);
  @$pb.TagNumber(4)
  void clearData() => clearField(4);
}

/// [RINF:RUST-SIGNAL]
class EventMsg extends $pb.GeneratedMessage {static final rustSignalStream =
    eventMsgController.stream.asBroadcastStream();

  factory EventMsg({
    $core.String? event,
    $core.String? data,
  }) {
    final $result = create();
    if (event != null) {
      $result.event = event;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  EventMsg._() : super();
  factory EventMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory EventMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'EventMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'event')
    ..aOS(2, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  EventMsg clone() => EventMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  EventMsg copyWith(void Function(EventMsg) updates) => super.copyWith((message) => updates(message as EventMsg)) as EventMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static EventMsg create() => EventMsg._();
  EventMsg createEmptyInstance() => create();
  static $pb.PbList<EventMsg> createRepeated() => $pb.PbList<EventMsg>();
  @$core.pragma('dart2js:noInline')
  static EventMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<EventMsg>(create);
  static EventMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get event => $_getSZ(0);
  @$pb.TagNumber(1)
  set event($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasEvent() => $_has(0);
  @$pb.TagNumber(1)
  void clearEvent() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get data => $_getSZ(1);
  @$pb.TagNumber(2)
  set data($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
}

/// [RINF:RUST-SIGNAL]
class LogMsg extends $pb.GeneratedMessage {static final rustSignalStream =
    logMsgController.stream.asBroadcastStream();

  factory LogMsg({
    $core.String? level,
    $core.String? data,
  }) {
    final $result = create();
    if (level != null) {
      $result.level = level;
    }
    if (data != null) {
      $result.data = data;
    }
    return $result;
  }
  LogMsg._() : super();
  factory LogMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LogMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'LogMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'discret'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'level')
    ..aOS(2, _omitFieldNames ? '' : 'data')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  LogMsg clone() => LogMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  LogMsg copyWith(void Function(LogMsg) updates) => super.copyWith((message) => updates(message as LogMsg)) as LogMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static LogMsg create() => LogMsg._();
  LogMsg createEmptyInstance() => create();
  static $pb.PbList<LogMsg> createRepeated() => $pb.PbList<LogMsg>();
  @$core.pragma('dart2js:noInline')
  static LogMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LogMsg>(create);
  static LogMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get level => $_getSZ(0);
  @$pb.TagNumber(1)
  set level($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasLevel() => $_has(0);
  @$pb.TagNumber(1)
  void clearLevel() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get data => $_getSZ(1);
  @$pb.TagNumber(2)
  set data($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');

extension ConnectExtension on Connect{
  void sendSignalToRust() {
    sendDartSignal(
      0,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension LoginExtension on Login{
  void sendSignalToRust() {
    sendDartSignal(
      1,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension QueryExtension on Query{
  void sendSignalToRust() {
    sendDartSignal(
      2,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension MutateExtension on Mutate{
  void sendSignalToRust() {
    sendDartSignal(
      3,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension DeleteExtension on Delete{
  void sendSignalToRust() {
    sendDartSignal(
      4,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension VerifyingKeyExtension on VerifyingKey{
  void sendSignalToRust() {
    sendDartSignal(
      5,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension PrivateRoomExtension on PrivateRoom{
  void sendSignalToRust() {
    sendDartSignal(
      6,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension InviteExtension on Invite{
  void sendSignalToRust() {
    sendDartSignal(
      7,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension AcceptInviteExtension on AcceptInvite{
  void sendSignalToRust() {
    sendDartSignal(
      8,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension DataModelExtension on DataModel{
  void sendSignalToRust() {
    sendDartSignal(
      9,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension UpdateDataModelExtension on UpdateDataModel{
  void sendSignalToRust() {
    sendDartSignal(
      10,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

extension SetLogLevelExtension on SetLogLevel{
  void sendSignalToRust() {
    sendDartSignal(
      11,
      this.writeToBuffer(),
      Uint8List(0),
    );
  }
}

final resultMsgController = StreamController<RustSignal<ResultMsg>>();

final eventMsgController = StreamController<RustSignal<EventMsg>>();

final logMsgController = StreamController<RustSignal<LogMsg>>();
