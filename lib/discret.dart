import 'package:rinf/rinf.dart';
import './messages/generated.dart';
import './messages/discret.pb.dart';

import 'dart:convert';
import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/services.dart' show rootBundle;

part 'discret.g.dart';

class Discret {
  late String applicationName;
  late String dataPath;
  late String baseModel;
  int id = 0;

  static final Discret _inst = Discret._internal();

  Discret._internal();

  factory Discret() {
    return _inst;
  }

  Future<void> initialize(
      String applicationName, String dataPath, String dataModel) async {
    await initializeRust(assignRustSignal);
    _inst.applicationName = applicationName;
    _inst.dataPath = dataPath;
    _inst.baseModel = dataModel;
  }

  int newId() {
    int newId = id;
    id += 1;
    return newId;
  }

  ///
  ///return the smallest possible unique identifier of the Discret database
  ///
  static String zeroUid() {
    return 'AAAAAAAAAAAAAAAAAAAAAA';
  }

  ///
  /// start Discret by using the provided key mapterial
  ///
  Future<ResultMsg> connect(Uint8List keyMaterial, bool create) async {
    int id = newId();
    String configuration = await loadConfiguration();
    print(configuration);
    Connect(
            id: id,
            keyMaterial: keyMaterial,
            allowCreate: create,
            applicationName: applicationName,
            dataPath: dataPath,
            configuration: configuration)
        .sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// start Discret by using a username and password.
  /// it performs a key derivation using the argon2id with the parameters recommended
  /// by OSWAP
  /// this derivation can take a second to perform, so you may to show your user a 'waiting gadget'
  ///
  Future<ResultMsg> login(String username, String password, bool create) async {
    int id = newId();
    String configuration = await loadConfiguration();
    Login(
            id: id,
            username: username,
            password: password,
            allowCreate: create,
            applicationName: applicationName,
            dataPath: dataPath,
            dataModel: baseModel,
            configuration: configuration)
        .sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// perform a query to retrieve data
  ///
  Future<ResultMsg> query(String query, dynamic params) async {
    int id = newId();
    String parameters = jsonEncode(params);
    Query(id: id, query: query, parameters: parameters).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// perform a query to insert or update data
  ///
  Future<ResultMsg> mutate(String query, dynamic params) async {
    int id = newId();
    String parameters = jsonEncode(params);
    Mutate(id: id, query: query, parameters: parameters).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// performs a query to delete data
  ///
  Future<ResultMsg> delete(String query, dynamic params) async {
    int id = newId();
    String parameters = jsonEncode(params);
    Delete(id: id, query: query, parameters: parameters).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// This special room is used internally to store system data.
  /// you are allowed to used it to store any kind of private data that will only be synchronized with your devices.
  ///
  Future<ResultMsg> privateRoom() async {
    int id = newId();
    PrivateRoom(id: id).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// This is is your Public identity.
  ///
  /// It is derived from the provided key_material.
  ///
  /// Every data you create will be signed using the associated signing_key, and
  /// other peers will use this verifying key to ensure the integrity of the data
  ///
  Future<ResultMsg> verifyingKey() async {
    int id = newId();
    VerifyingKey(id: id).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// Create an invitation
  ///
  Future<ResultMsg> invite(String room, String authorisation) async {
    int id = newId();
    Invite(id: id, room: room, authorisation: authorisation).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// Accept an invitation
  ///
  Future<ResultMsg> acceptInvite(String invite) async {
    int id = newId();
    AcceptInvite(id: id, invite: invite).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// Provide a JSON representation of the datamodel
  ///
  /// the JSON contains the model plain text along with the internal datamodel representation
  ///
  /// Can be usefull to create a data model editor
  ///
  Future<ResultMsg> dataModel() async {
    int id = newId();
    DataModel(id: id).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// Update the existing data model definition with a new one
  ///
  /// returns the JSON representation of the updated datamodel
  ///
  /// can be usefull to create a data model editor
  ///
  Future<ResultMsg> updateDataModel(String datamodel) async {
    int id = newId();
    UpdateDataModel(id: id, datamodel: datamodel).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// Set the log level
  ///
  Future<ResultMsg> setLogLevel(String level) async {
    int id = newId();
    SetLogLevel(id: id, level: level).sendSignalToRust();

    await for (final rustSignal in ResultMsg.rustSignalStream) {
      ResultMsg res = rustSignal.message;
      if (res.id == id) {
        return res;
      }
    }
    return ResultMsg(id: id, successful: false);
  }

  ///
  /// Subscribe for the log stream
  ///
  Stream<LogMsg> logStream() async* {
    await for (final rustSignal in LogMsg.rustSignalStream) {
      yield rustSignal.message;
    }
  }

  ///
  /// Subscribe for the event stream
  ///
  Stream<Event> eventStream() async* {
    await for (final rustSignal in EventMsg.rustSignalStream) {
      EventMsg eventMsg = rustSignal.message;
      switch (eventMsg.event) {
        case 'DataChanged':
          final json = jsonDecode(eventMsg.data) as Map<String, dynamic>;
          DataModification modif = DataModification.fromJson(json);
          Event event = Event(EventType.dataChanged);
          event.data = modif;
          yield event;

        case 'RoomModified':
          Event event = Event(EventType.roomModified);
          event.data = eventMsg.data;
          yield event;

        case 'RoomSynchronized':
          Event event = Event(EventType.roomSynchronized);
          event.data = eventMsg.data;
          yield event;

        case 'PeerConnected':
          final json = jsonDecode(eventMsg.data) as Map<String, dynamic>;
          PeerConnection conn = PeerConnection.fromJson(json);
          Event event = Event(EventType.peerConnected);
          event.data = conn;
          yield event;

        case 'PeerDisconnected':
          final json = jsonDecode(eventMsg.data) as Map<String, dynamic>;
          PeerConnection conn = PeerConnection.fromJson(json);
          Event event = Event(EventType.peerDisconnected);
          event.data = conn;
          yield event;

        case 'PendingPeer':
          Event event = Event(EventType.pendingPeer);
          event.data = eventMsg.data;
          yield event;

        case 'PendingHardware':
          Event event = Event(EventType.pendingHardware);
          event.data = eventMsg.data;
          yield event;

        default:
      }
    }
  }

  Future<String> loadConfiguration() async {
    return await rootBundle.loadString('discret.conf.toml');
  }
}

enum LogType { info, error }

@JsonSerializable()
class LogError {
  int date;
  String source;
  String message;
  LogError(this.date, this.source, this.message);
  factory LogError.fromJson(Map<String, dynamic> json) =>
      _$LogErrorFromJson(json);
}

enum EventType {
  dataChanged,
  roomModified,
  roomSynchronized,
  peerConnected,
  peerDisconnected,
  pendingPeer,
  pendingHardware
}

class Event {
  EventType type;
  Object? data;
  Event(this.type);
}

@JsonSerializable()
class PeerConnection {
  String verifyingKey;
  int date;
  String connectionId;
  PeerConnection(this.verifyingKey, this.date, this.connectionId);
  factory PeerConnection.fromJson(Map<String, dynamic> json) =>
      _$PeerConnectionFromJson(json);
}

@JsonSerializable()
class DataModification {
  Map<String, Map<String, List<int>>>? rooms;
  DataModification(this.rooms);
  factory DataModification.fromJson(Map<String, dynamic> json) =>
      _$DataModificationFromJson(json);
}
