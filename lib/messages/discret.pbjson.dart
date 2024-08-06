//
//  Generated code. Do not modify.
//  source: discret.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use connectDescriptor instead')
const Connect$json = {
  '1': 'Connect',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'key_material', '3': 2, '4': 1, '5': 12, '10': 'keyMaterial'},
    {'1': 'allow_create', '3': 3, '4': 1, '5': 8, '10': 'allowCreate'},
    {'1': 'application_name', '3': 4, '4': 1, '5': 9, '10': 'applicationName'},
    {'1': 'data_path', '3': 5, '4': 1, '5': 9, '10': 'dataPath'},
    {'1': 'data_model', '3': 6, '4': 1, '5': 9, '10': 'dataModel'},
    {'1': 'configuration', '3': 7, '4': 1, '5': 9, '10': 'configuration'},
  ],
};

/// Descriptor for `Connect`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List connectDescriptor = $convert.base64Decode(
    'CgdDb25uZWN0Eg4KAmlkGAEgASgFUgJpZBIhCgxrZXlfbWF0ZXJpYWwYAiABKAxSC2tleU1hdG'
    'VyaWFsEiEKDGFsbG93X2NyZWF0ZRgDIAEoCFILYWxsb3dDcmVhdGUSKQoQYXBwbGljYXRpb25f'
    'bmFtZRgEIAEoCVIPYXBwbGljYXRpb25OYW1lEhsKCWRhdGFfcGF0aBgFIAEoCVIIZGF0YVBhdG'
    'gSHQoKZGF0YV9tb2RlbBgGIAEoCVIJZGF0YU1vZGVsEiQKDWNvbmZpZ3VyYXRpb24YByABKAlS'
    'DWNvbmZpZ3VyYXRpb24=');

@$core.Deprecated('Use loginDescriptor instead')
const Login$json = {
  '1': 'Login',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'username', '3': 2, '4': 1, '5': 9, '10': 'username'},
    {'1': 'password', '3': 3, '4': 1, '5': 9, '10': 'password'},
    {'1': 'allow_create', '3': 4, '4': 1, '5': 8, '10': 'allowCreate'},
    {'1': 'application_name', '3': 5, '4': 1, '5': 9, '10': 'applicationName'},
    {'1': 'data_path', '3': 6, '4': 1, '5': 9, '10': 'dataPath'},
    {'1': 'data_model', '3': 7, '4': 1, '5': 9, '10': 'dataModel'},
    {'1': 'configuration', '3': 8, '4': 1, '5': 9, '10': 'configuration'},
  ],
};

/// Descriptor for `Login`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List loginDescriptor = $convert.base64Decode(
    'CgVMb2dpbhIOCgJpZBgBIAEoBVICaWQSGgoIdXNlcm5hbWUYAiABKAlSCHVzZXJuYW1lEhoKCH'
    'Bhc3N3b3JkGAMgASgJUghwYXNzd29yZBIhCgxhbGxvd19jcmVhdGUYBCABKAhSC2FsbG93Q3Jl'
    'YXRlEikKEGFwcGxpY2F0aW9uX25hbWUYBSABKAlSD2FwcGxpY2F0aW9uTmFtZRIbCglkYXRhX3'
    'BhdGgYBiABKAlSCGRhdGFQYXRoEh0KCmRhdGFfbW9kZWwYByABKAlSCWRhdGFNb2RlbBIkCg1j'
    'b25maWd1cmF0aW9uGAggASgJUg1jb25maWd1cmF0aW9u');

@$core.Deprecated('Use queryDescriptor instead')
const Query$json = {
  '1': 'Query',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    {'1': 'parameters', '3': 3, '4': 1, '5': 9, '10': 'parameters'},
  ],
};

/// Descriptor for `Query`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List queryDescriptor = $convert.base64Decode(
    'CgVRdWVyeRIOCgJpZBgBIAEoBVICaWQSFAoFcXVlcnkYAiABKAlSBXF1ZXJ5Eh4KCnBhcmFtZX'
    'RlcnMYAyABKAlSCnBhcmFtZXRlcnM=');

@$core.Deprecated('Use mutateDescriptor instead')
const Mutate$json = {
  '1': 'Mutate',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    {'1': 'parameters', '3': 3, '4': 1, '5': 9, '10': 'parameters'},
  ],
};

/// Descriptor for `Mutate`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List mutateDescriptor = $convert.base64Decode(
    'CgZNdXRhdGUSDgoCaWQYASABKAVSAmlkEhQKBXF1ZXJ5GAIgASgJUgVxdWVyeRIeCgpwYXJhbW'
    'V0ZXJzGAMgASgJUgpwYXJhbWV0ZXJz');

@$core.Deprecated('Use deleteDescriptor instead')
const Delete$json = {
  '1': 'Delete',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'query', '3': 2, '4': 1, '5': 9, '10': 'query'},
    {'1': 'parameters', '3': 3, '4': 1, '5': 9, '10': 'parameters'},
  ],
};

/// Descriptor for `Delete`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List deleteDescriptor = $convert.base64Decode(
    'CgZEZWxldGUSDgoCaWQYASABKAVSAmlkEhQKBXF1ZXJ5GAIgASgJUgVxdWVyeRIeCgpwYXJhbW'
    'V0ZXJzGAMgASgJUgpwYXJhbWV0ZXJz');

@$core.Deprecated('Use verifyingKeyDescriptor instead')
const VerifyingKey$json = {
  '1': 'VerifyingKey',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `VerifyingKey`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List verifyingKeyDescriptor = $convert.base64Decode(
    'CgxWZXJpZnlpbmdLZXkSDgoCaWQYASABKAVSAmlk');

@$core.Deprecated('Use privateRoomDescriptor instead')
const PrivateRoom$json = {
  '1': 'PrivateRoom',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `PrivateRoom`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List privateRoomDescriptor = $convert.base64Decode(
    'CgtQcml2YXRlUm9vbRIOCgJpZBgBIAEoBVICaWQ=');

@$core.Deprecated('Use inviteDescriptor instead')
const Invite$json = {
  '1': 'Invite',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'room', '3': 2, '4': 1, '5': 9, '10': 'room'},
    {'1': 'authorisation', '3': 3, '4': 1, '5': 9, '10': 'authorisation'},
  ],
};

/// Descriptor for `Invite`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List inviteDescriptor = $convert.base64Decode(
    'CgZJbnZpdGUSDgoCaWQYASABKAVSAmlkEhIKBHJvb20YAiABKAlSBHJvb20SJAoNYXV0aG9yaX'
    'NhdGlvbhgDIAEoCVINYXV0aG9yaXNhdGlvbg==');

@$core.Deprecated('Use acceptInviteDescriptor instead')
const AcceptInvite$json = {
  '1': 'AcceptInvite',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'invite', '3': 2, '4': 1, '5': 9, '10': 'invite'},
  ],
};

/// Descriptor for `AcceptInvite`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List acceptInviteDescriptor = $convert.base64Decode(
    'CgxBY2NlcHRJbnZpdGUSDgoCaWQYASABKAVSAmlkEhYKBmludml0ZRgCIAEoCVIGaW52aXRl');

@$core.Deprecated('Use dataModelDescriptor instead')
const DataModel$json = {
  '1': 'DataModel',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
  ],
};

/// Descriptor for `DataModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List dataModelDescriptor = $convert.base64Decode(
    'CglEYXRhTW9kZWwSDgoCaWQYASABKAVSAmlk');

@$core.Deprecated('Use updateDataModelDescriptor instead')
const UpdateDataModel$json = {
  '1': 'UpdateDataModel',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'datamodel', '3': 2, '4': 1, '5': 9, '10': 'datamodel'},
  ],
};

/// Descriptor for `UpdateDataModel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List updateDataModelDescriptor = $convert.base64Decode(
    'Cg9VcGRhdGVEYXRhTW9kZWwSDgoCaWQYASABKAVSAmlkEhwKCWRhdGFtb2RlbBgCIAEoCVIJZG'
    'F0YW1vZGVs');

@$core.Deprecated('Use setLogLevelDescriptor instead')
const SetLogLevel$json = {
  '1': 'SetLogLevel',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'level', '3': 2, '4': 1, '5': 9, '10': 'level'},
  ],
};

/// Descriptor for `SetLogLevel`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List setLogLevelDescriptor = $convert.base64Decode(
    'CgtTZXRMb2dMZXZlbBIOCgJpZBgBIAEoBVICaWQSFAoFbGV2ZWwYAiABKAlSBWxldmVs');

@$core.Deprecated('Use resultMsgDescriptor instead')
const ResultMsg$json = {
  '1': 'ResultMsg',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 5, '10': 'id'},
    {'1': 'successful', '3': 2, '4': 1, '5': 8, '10': 'successful'},
    {'1': 'error', '3': 3, '4': 1, '5': 9, '10': 'error'},
    {'1': 'data', '3': 4, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `ResultMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List resultMsgDescriptor = $convert.base64Decode(
    'CglSZXN1bHRNc2cSDgoCaWQYASABKAVSAmlkEh4KCnN1Y2Nlc3NmdWwYAiABKAhSCnN1Y2Nlc3'
    'NmdWwSFAoFZXJyb3IYAyABKAlSBWVycm9yEhIKBGRhdGEYBCABKAlSBGRhdGE=');

@$core.Deprecated('Use eventMsgDescriptor instead')
const EventMsg$json = {
  '1': 'EventMsg',
  '2': [
    {'1': 'event', '3': 1, '4': 1, '5': 9, '10': 'event'},
    {'1': 'data', '3': 2, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `EventMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List eventMsgDescriptor = $convert.base64Decode(
    'CghFdmVudE1zZxIUCgVldmVudBgBIAEoCVIFZXZlbnQSEgoEZGF0YRgCIAEoCVIEZGF0YQ==');

@$core.Deprecated('Use logMsgDescriptor instead')
const LogMsg$json = {
  '1': 'LogMsg',
  '2': [
    {'1': 'level', '3': 1, '4': 1, '5': 9, '10': 'level'},
    {'1': 'data', '3': 2, '4': 1, '5': 9, '10': 'data'},
  ],
};

/// Descriptor for `LogMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List logMsgDescriptor = $convert.base64Decode(
    'CgZMb2dNc2cSFAoFbGV2ZWwYASABKAlSBWxldmVsEhIKBGRhdGEYAiABKAlSBGRhdGE=');

