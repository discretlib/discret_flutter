import './discret.pb.dart' as discret;
// ignore_for_file: unused_import

import 'dart:typed_data';
import 'package:rinf/rinf.dart';

final rustSignalHandlers = <int, void Function(Uint8List, Uint8List)>{
12: (Uint8List messageBytes, Uint8List binary) {
  final message = discret.ResultMsg.fromBuffer(messageBytes);
  final rustSignal = RustSignal(
    message,
    binary,
  );
  discret.resultMsgController.add(rustSignal);
},
13: (Uint8List messageBytes, Uint8List binary) {
  final message = discret.EventMsg.fromBuffer(messageBytes);
  final rustSignal = RustSignal(
    message,
    binary,
  );
  discret.eventMsgController.add(rustSignal);
},
14: (Uint8List messageBytes, Uint8List binary) {
  final message = discret.LogMsg.fromBuffer(messageBytes);
  final rustSignal = RustSignal(
    message,
    binary,
  );
  discret.logMsgController.add(rustSignal);
},
};

void assignRustSignal(int messageId, Uint8List messageBytes, Uint8List binary) {
  rustSignalHandlers[messageId]!(messageBytes, binary);
}
