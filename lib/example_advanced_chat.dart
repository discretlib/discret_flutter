import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'dart:developer' as logger;

import 'discret.dart';
import './messages/discret.pb.dart';

// ignore: constant_identifier_names
const String APPLICATION_KEY =
    "github.com/discretlib/flutter_example_advanced_chat";
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final path = await _localPath;

  String dataPath = '$path/.discret_data';
  String datamodel = """chat {
    Message {
      content: String
    }
  }""";
  await Discret().initialize(APPLICATION_KEY, dataPath, datamodel);

  runApp(
    const ChatApp(),
  );
}

//
// This state contains all the Discret related logic.
//
class ChatState extends ChangeNotifier {
  final List<ChatRoom> chatRooms = [];
  final Map<String, ChatRoom> chatMap = HashMap();
  late ChatRoom currentChatRoom;
  late String privateRoom;
  late String myVerifyingKey;
  late StreamSubscription<Event> eventlistener;
  late StreamSubscription<LogMessage> loglistener;

  //
  // Initialise the state after a successfull login
  //
  Future<void> initialise() async {
    ResultMsg msg = await Discret().privateRoom();
    privateRoom = msg.data;

    currentChatRoom = ChatRoom("You", privateRoom, 0);
    chatRooms.add(currentChatRoom);
    chatMap.addAll({privateRoom: currentChatRoom});

    msg = await Discret().verifyingKey();
    myVerifyingKey = msg.data;

    // Manage events sent by Discret
    eventlistener = Discret().eventStream().listen((event) async {
      switch (event.type) {
        case EventType.dataChanged:
          {
            DataModification modif = event.data as DataModification;
            modif.rooms?.forEach((key, value) {
              if (chatMap.containsKey(key)) {
                ChatRoom chatRoom = chatMap[key]!;
                chatRoom.refresh();
              }
            });
            chatRooms.sort((a, b) => b.mdate.compareTo(a.mdate));
            notifyListeners();
          }
        case EventType.roomModified:
          {
            String roomId = event.data as String;
            await loadRoom(roomId);
            notifyListeners();
          }
        case EventType.peerConnected:
          {
            PeerConnection peer = event.data as PeerConnection;
            var key = peer.verifyingKey;
            logger.log('Peer connected: $key');
          }
        case EventType.peerDisconnected:
          {
            PeerConnection peer = event.data as PeerConnection;
            var key = peer.verifyingKey;
            logger.log('Peer disconnected: $key');
          }

        default:
      }
    }, onDone: () {}, onError: (error) {});

    //Manage logs coming from the Discret library
    loglistener = Discret().logStream().listen((event) async {
      var date = DateTime.fromMillisecondsSinceEpoch(event.date);
      var message = event.message;
      switch (event.type) {
        case LogType.info:
          message = 'INFO: $message';

        case LogType.error:
          var source = event.source;
          message = 'ERROR: source: $source message: $message';
      }
      logger.log(message, time: date);
    });

    await currentChatRoom.refresh();
    await refreshRoomList();
    notifyListeners();
  }

  //
  // Starts Discret with the provided username and password
  //
  Future<ResultMsg> login(String userName, String password) async {
    ResultMsg msg = await Discret().login(userName, password, false);
    if (msg.successful) {
      await initialise();
    }
    return msg;
  }

  //
  // Create a new account
  //
  Future<ResultMsg> createAccount(
      String userName, String password, String displayName) async {
    ResultMsg msg = await Discret().login(userName, password, true);
    if (msg.successful) {
      await initialise();
      String query = """query{
        sys.Peer(verifying_key=\$verifyingKey){
          id
        }
      }""";

      ResultMsg res =
          await Discret().query(query, {"verifyingKey": myVerifyingKey});
      if (!res.successful) {
        logger.log(res.error);
        return res;
      }

      final json = jsonDecode(res.data) as Map<String, dynamic>;
      final msgArray = json["sys.Peer"] as List<dynamic>;
      var result = msgArray[0] as Map<String, dynamic>;
      var id = result["id"];
      String mutate = """mutate {
        sys.Peer{
          id:\$id
          name:\$name
        }
      }""";
      res = await Discret().mutate(mutate, {"id": id, "name": displayName});
      if (!res.successful) {
        logger.log(res.error);
        return res;
      }
      return res;
    }
    return msg;
  }

  ///
  /// Select a room from the list
  ///
  void selectRoom(ChatRoom room) {
    currentChatRoom = room;
    notifyListeners();
  }

  //retrieve rooms that have at least two users
  Future<void> refreshRoomList() async {
    String roomQuery = """query{
      sys.Room{
        id
        mdate
        authorisations{
          users{
            verif_key
          }
        }
      }
    }""";
    ResultMsg res = await Discret().query(roomQuery, {});
    if (!res.successful) {
      logger.log(res.error);
      return;
    }
    final json = jsonDecode(res.data) as Map<String, dynamic>;

    await readRoomQueryResult(json);
  }

  //retrieve rooms that have at least two users
  Future<void> loadRoom(String roomId) async {
    String roomQuery = """query{
      sys.Room(id=\$roomId) {
        id
        mdate
        authorisations{
          users{
            verif_key
          }
        }
      }
    }""";
    ResultMsg res = await Discret().query(roomQuery, {"roomId": roomId});
    if (!res.successful) {
      logger.log(res.error);
      return;
    }
    final json = jsonDecode(res.data) as Map<String, dynamic>;

    await readRoomQueryResult(json);
  }

  Future<void> readRoomQueryResult(Map<String, dynamic> json) async {
    String peerQuery = """query{
      sys.Peer(
        verifying_key = \$verifyingKey
      ){
        name
      }
    }""";

    final rooms = json["sys.Room"] as List<dynamic>;
    for (var roomObject in rooms) {
      final room = roomObject as Map<String, dynamic>;
      final String roomId = room["id"];
      if (chatMap.containsKey(roomId)) {
        continue;
      }

      final int mdate = room["mdate"];
      final auths = room["authorisations"] as List<dynamic>;
      final auth = auths[0] as Map<String, dynamic>;
      final users = auth["users"] as List<dynamic>;
      if (users.length > 1) {
        var name = "";
        for (var userObject in users) {
          final user = userObject as Map<String, dynamic>;
          String verifyingKey = user["verif_key"];
          if (myVerifyingKey != verifyingKey) {
            //retrieve the peer name, should probably be cached
            final result = await Discret()
                .query(peerQuery, {"verifyingKey": verifyingKey});

            if (!result.successful) {
              logger.log(result.error);
              return;
            }
            final json = jsonDecode(result.data) as Map<String, dynamic>;
            final userNames = json["sys.Peer"] as List<dynamic>;
            final userName = userNames[0] as Map<String, dynamic>;
            name = userName["name"];
          }
        }
        var chatRoom = ChatRoom(name, roomId, mdate);
        chatRooms.add(chatRoom);
        chatMap.addAll({roomId: chatRoom});
        await chatRoom.refresh();
      }
    }
    chatRooms.sort((a, b) => b.mdate.compareTo(a.mdate));
  }

  ///
  /// Create a new invitation key
  ///
  Future<String> createInvite() async {
    String query = """mutate {
      sys.Room{
        admin: [{
          verif_key:\$verifyingKey
        }]
        authorisations:[{
          name:"chat"
          rights:[{
            entity:"chat.Message"
            mutate_self:true
            mutate_all:false
          }]
          users:[{
              verif_key:\$verifyingKey
          }]
        }]
      }
    }""";

    ResultMsg res =
        await Discret().mutate(query, {"verifyingKey": myVerifyingKey});

    if (!res.successful) {
      logger.log(res.error);
      return "";
    }

    final json = jsonDecode(res.data) as Map<String, dynamic>;
    final msgArray = json["sys.Room"] as Map<String, dynamic>;
    String roomId = msgArray["id"];

    final auths = msgArray["authorisations"] as List<dynamic>;
    final authorisation = auths[0] as Map<String, dynamic>;
    final authId = authorisation["id"];

    ResultMsg invite = await Discret().invite(roomId, authId);
    if (!res.successful) {
      logger.log(res.error);
      return "";
    }
    return invite.data;
  }

  ///
  /// Accept the invitations
  ///
  Future<void> acceptInvite(String invite) async {
    ResultMsg msg = await Discret().acceptInvite(invite);
    if (!msg.successful) {
      logger.log(msg.error);
    }
  }
}

class ChatRoom {
  final List<ChatEntry> chat = [];
  String roomId;
  String name;
  int mdate;

  ChatEntry lastEntry = ChatEntry("", "", Discret.zeroUid(), 0, "");

  TextEditingController chatController = TextEditingController();
  ChatRoom(this.name, this.roomId, this.mdate);

  //
  // Read chat data from the database
  //
  Future<void> refresh() async {
    String query = """query {
            res: chat.Message(
                order_by(mdate asc, id asc), 
                after(\$mdate, \$id),
                room_id = \$room_id
            ) {
                id
                sys_peer {
                  name
                }
                mdate
                content
                verifying_key     
            }
          }""";
    ResultMsg res = await Discret()
        .query(query, {"mdate": mdate, "id": lastEntry.id, "room_id": roomId});

    if (!res.successful) {
      logger.log(res.error);
    } else {
      final json = jsonDecode(res.data) as Map<String, dynamic>;
      final msgArray = json["res"] as List<dynamic>;
      for (var msgObject in msgArray) {
        var message = msgObject as Map<String, dynamic>;
        var peer = message["sys_peer"] as Map<String, dynamic>;
        var entry = ChatEntry(message["verifying_key"], peer["name"],
            message["id"], message["mdate"], message["content"]);
        lastEntry = entry;
        mdate = lastEntry.date;
        chat.add(entry);
      }
    }
  }

  //
  // send a message to the chat room
  //
  Future<void> sendMessage() async {
    if (chatController.text != "") {
      String query = """mutate {
        res : chat.Message{
          room_id: \$room_id
          content: \$content
        }
      }""";

      ResultMsg res = await Discret().mutate(
          query, {"room_id": roomId, "content": chatController.text.trim()});

      if (!res.successful) {
        logger.log(res.error);
      } else {
        chatController.clear();
      }
    }
  }
}

//Stores a chat message
class ChatEntry {
  String verifyingKey;
  String name;
  String id;
  int date;
  String message;
  ChatEntry(this.verifyingKey, this.name, this.id, this.date, this.message);
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

String readTimestamp(int timestamp) {
  var format = DateFormat('HH:mm');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  return format.format(date);
}

///
/// Application entry point
///
class ChatApp extends StatelessWidget {
  const ChatApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChatState(),
      child: MaterialApp(
        title: 'Sample Chat',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/createAccount': (context) => const CreateAccountScreen(),
          '/home': (context) => const ResponsiveHome(),
          '/room': (context) => const MobileChatScreen(),
        },
      ),
    );
  }
}

//
// The responsive home page
//
class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    LayoutBuilder buider = LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 650) {
          return const ChatRoomList(false);
        } else {
          return const DeskopChat();
        }
      },
    );
    return ChatScaffold(buider);
  }
}

///
/// The application Scaffold
///
class ChatScaffold extends StatelessWidget {
  final Widget widget;
  const ChatScaffold(this.widget, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text('Discret Chat'),
          actions: [
            TextButton(
              onPressed: () async {
                await showInviteDialog(context);
              },
              child: const Text("Invite"),
            ),
            TextButton(
              onPressed: () {
                showAcceptInviteDialog(context);
              },
              child: const Text("Accept Invite"),
            ),
          ],
        ),
        body: widget);
  }
}

///
/// The list of available rooms
///
class ChatRoomList extends StatelessWidget {
  final bool desktop;
  const ChatRoomList(this.desktop, {super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ChatState>();
    return ListView.builder(
        itemCount: appState.chatRooms.length,
        itemBuilder: (BuildContext context, int index) {
          ChatRoom room = appState.chatRooms[index];
          String name = room.lastEntry.name;
          if (room.lastEntry.verifyingKey == appState.myVerifyingKey) {
            name = "You";
          }
          return InkWell(
            onTap: () {
              appState.selectRoom(room);
              if (!desktop) {
                Navigator.pushNamed(context, '/room');
              }
            },
            child: Container(
              color: (room.roomId == appState.currentChatRoom.roomId)
                  ? Colors.blue.withOpacity(0.5)
                  : Colors.transparent,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              room.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            room.mdate != 0
                                ? Text(readTimestamp(room.mdate))
                                : const Text(""),
                          ],
                        ),
                        RichText(
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          text: TextSpan(children: [
                            TextSpan(
                              text: name,
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            name.isNotEmpty
                                ? TextSpan(
                                    text: ": ",
                                    style: GoogleFonts.inter(
                                      color: Colors.black87,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : const TextSpan(text: ""),
                            TextSpan(
                              text: room.lastEntry.message,
                              style: GoogleFonts.inter(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: Colors.grey[400],
                    height: 0.5,
                  ),
                ],
              ),
            ),
          );
        });
  }
}

///
/// The mobile version of the chat screen
///
class MobileChatScreen extends StatelessWidget {
  const MobileChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const ChatScaffold(ChatWidget(false));
  }
}

///
/// The destop chat application
///
class DeskopChat extends StatelessWidget {
  const DeskopChat({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          constraints: const BoxConstraints(minWidth: 100, maxWidth: 350),
          child: const ChatRoomList(true),
        ),
        Container(
          color: Colors.grey[400],
          width: 0.5,
        ),
        const ChatWidget(true)
      ],
    );
  }
}

///
/// the chat widget that returns one version for mobile and one for desktop
///
class ChatWidget extends StatelessWidget {
  final bool desktop;
  const ChatWidget(this.desktop, {super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ChatState>();
    final ScrollController scrollCtrl = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollCtrl.hasClients) {
        final position = scrollCtrl.position.maxScrollExtent;
        scrollCtrl.jumpTo(position);
      }
    });

    var chatview = ListView.builder(
        controller: scrollCtrl,
        itemCount: appState.currentChatRoom.chat.length,
        itemBuilder: (BuildContext context, int index) {
          ChatEntry entry = appState.currentChatRoom.chat[index];
          String name = entry.name;
          if (entry.verifyingKey == appState.myVerifyingKey) {
            name = "You";
          }
          return ListTile(
            visualDensity: VisualDensity.compact,
            leading: Text(
              name,
              style: GoogleFonts.inter(
                color: Colors.black87,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            title: SelectableText(entry.message),
            trailing: Text(readTimestamp(entry.date)),
          );
        });

    final FocusNode chatFieldFocus = FocusNode();
    var chatField = TextField(
      autofocus: true,
      controller: appState.currentChatRoom.chatController,
      focusNode: chatFieldFocus,
      maxLines: null,
      decoration:
          const InputDecoration.collapsed(hintText: "Enter your text here"),
    );
    chatFieldFocus.requestFocus();
    if (desktop) {
      return Expanded(
          child: chatWidget(chatField, appState, chatview, chatFieldFocus));
    } else {
      return chatWidget(chatField, appState, chatview, chatFieldFocus);
    }
  }

  Widget chatWidget(TextField chatField, ChatState appState, ListView chatview,
      FocusNode chatFieldFocus) {
    String roomName = appState.currentChatRoom.name;
    return Column(
      children: [
        Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Chat with $roomName',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Container(
          color: Colors.grey[400],
          height: 0.5,
        ),
        Expanded(
          child: Column(
            children: [Expanded(child: chatview)],
          ),
        ),
        Container(
          color: Colors.grey[400],
          height: 0.5,
        ),
        const SizedBox(height: 10),
        Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: chatField,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await appState.currentChatRoom.sendMessage();
              chatFieldFocus.requestFocus();
            },
            child: const Text('Send'),
          )
        ]),
        const SizedBox(height: 10),
      ],
    );
  }
}

///
/// Dialog to accept
///
showAcceptInviteDialog(BuildContext context) {
  var appState = Provider.of<ChatState>(context, listen: false);
  TextEditingController inviteCtrl = TextEditingController();
  final invite = TextFormField(
    controller: inviteCtrl,
    autofocus: true,
    obscureText: false,
    autovalidateMode: AutovalidateMode.always,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return "";
      }
      return null;
    },
    decoration: InputDecoration(
      labelText: 'Invitation Key',
      hintText: 'Paste your invitation key',
      contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () async {
      if (inviteCtrl.text.isNotEmpty) {
        await appState.acceptInvite(inviteCtrl.text);
        if (context.mounted) {
          Navigator.of(context).pop();
        }
      }
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Accept Invite"),
    content: SizedBox(
        height: 100,
        width: 400,
        child: Column(children: [const SizedBox(height: 8.0), invite])),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

///
/// Dialog that creates an invite
///
Future<void> showInviteDialog(BuildContext context) async {
  var appState = Provider.of<ChatState>(context, listen: false);
  String invite = await appState.createInvite();
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget cancelButton = TextButton(
    child: const Text("Copy To Clipboard"),
    onPressed: () {
      Clipboard.setData(ClipboardData(text: invite));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("New Invite Key"),
    content: Column(children: [
      const SizedBox(height: 8.0),
      const Text(
          "Copy the following Invitation key and send it to someone using mail, other chat sotfware, etc. On real system we should use a QR code "),
      const SizedBox(height: 8.0),
      SelectableText(invite)
    ]),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  if (context.mounted) {
    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

//
// Login Screen
//
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var chatState = Provider.of<ChatState>(context);
    final username = TextFormField(
      controller: nameController,
      autofocus: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "* Required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'User Name',
        hintText: 'Enter your user name',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "* Required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            var result = await chatState.login(
                nameController.text, passwordController.text);
            if (result.successful) {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            } else {
              setState(() {
                errorMessage = result.error;
              });
            }
          }
        },
        child: const Text('Login'),
      ),
    );

    final createAccountButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/createAccount');
        },
        child: const Text('Create a new Account'),
      ),
    );

    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Container(
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                const SizedBox(height: 8.0),
                username,
                const SizedBox(height: 8.0),
                password,
                const SizedBox(height: 8.0),
                Text(
                  errorMessage,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                loginButton,
                createAccountButton
              ],
            ),
          )),
        ));
  }
}

//
// Create account Screen
//
class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  String errorMessage = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var chatState = Provider.of<ChatState>(context);

    final username = TextFormField(
      controller: nameController,
      autofocus: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "* Required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'User Name',
        hintText: 'Enter your user name',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );

    final password = TextFormField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "* Required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );

    final confirmPassword = TextFormField(
      controller: passwordConfirmController,
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "* Required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        hintText: 'Confirm your password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );

    final displayName = TextFormField(
      controller: displayNameController,
      autofocus: false,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "* Required";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: 'Displayed Name',
        hintText: 'Enter the Displayed Name',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );

    final createButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (passwordController.text != passwordConfirmController.text) {
              setState(() {
                errorMessage = "The two passwords do not match";
              });
              return;
            }

            var result = await chatState.createAccount(nameController.text,
                passwordController.text, displayNameController.text);
            if (result.successful) {
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/home');
              }
            } else {
              setState(() {
                errorMessage = result.error;
              });
            }
          }
        },
        child: const Text('Create Account'),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/login');
        },
        child: const Text('Return to the login screen'),
      ),
    );

    return Form(
        key: _formKey,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
              child: Container(
            constraints: const BoxConstraints(minWidth: 200, maxWidth: 400),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 24.0, right: 24.0),
              children: <Widget>[
                const SizedBox(height: 8.0),
                username,
                const SizedBox(height: 8.0),
                password,
                const SizedBox(height: 8.0),
                confirmPassword,
                const SizedBox(height: 8.0),
                const Text(
                    "Enter the name that will be displayed to other peers. It should be different from your username"),
                displayName,
                Text(
                  errorMessage,
                  style: const TextStyle(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                createButton,
                loginButton
              ],
            ),
          )),
        ));
  }
}
