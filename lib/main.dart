import 'dart:async';
import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';

import './messages/discret.pb.dart';
import 'discret.dart';

// The application unique identifier
// ignore: constant_identifier_names
const String APPLICATION_KEY =
    "github.com/discretlib/flutter_example_simple_chat";
void main() async {
  //this will not work on phones, see example_advanced_chat.dart for a working version
  String dataPath = '.discret_data';
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
  List<ChatEntry> chat = [];
  int lastEntryDate = 0;
  String lastId = Discret.zeroUid();
  late String privateRoom;

  late StreamSubscription<Event> eventlistener;

  TextEditingController chatController = TextEditingController();

  //
  // Starts Discret with the provided username and password
  // if 'create' is set to true, it will create the database if it does not exists
  //
  Future<ResultMsg> login(String userName, String password, bool create) async {
    ResultMsg msg = await Discret().login(userName, password, create);
    if (msg.successful) {
      await initialise();
    }
    return msg;
  }

  //
  // Initialise the state after a successfull login
  //
  Future<void> initialise() async {
    ResultMsg msg = await Discret().privateRoom();
    privateRoom = msg.data;

    eventlistener = Discret().eventStream().listen((event) async {
      switch (event.type) {
        case EventType.dataChanged:
          await refreshChat();

        default:
      }
    }, onDone: () {}, onError: (error) {});
    refreshChat();
  }

  //
  // Read chat data from the database
  //
  Future<void> refreshChat() async {
    String query = """query {
            res: chat.Message(
                order_by(mdate asc, id asc), 
                after(\$mdate, \$id),
                room_id = \$room_id
            ) {
                    id
                    mdate
                    content
            }
          }""";
    ResultMsg res = await Discret().query(
        query, {"mdate": lastEntryDate, "id": lastId, "room_id": privateRoom});

    if (!res.successful) {
      print(res.error);
    } else {
      final json = jsonDecode(res.data) as Map<String, dynamic>;
      final msgArray = json["res"] as List<dynamic>;

      for (var msgObject in msgArray) {
        var message = msgObject as Map<String, dynamic>;
        var entry =
            ChatEntry(message["id"], message["mdate"], message["content"]);
        lastEntryDate = entry.date;
        lastId = entry.id;

        chat.add(entry);
      }
      notifyListeners();
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
          query, {"room_id": privateRoom, "content": chatController.text});

      if (!res.successful) {
        print(res.error);
      } else {
        chatController.clear();
      }
    }
  }
}

//Stores a chat message
class ChatEntry {
  String id;
  int date;
  String message;
  ChatEntry(this.id, this.date, this.message);
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = date.difference(now);
  var time = '';

  if (diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays == 1) {
    time = 'one day ago';
  } else {
    time = '${diff.inDays} days ago';
  }

  return time;
}

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
          '/home': (context) => const ChatScreen(),
        },
      ),
    );
  }
}

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
      autofocus: false,
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
                nameController.text, passwordController.text, false);

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
          Navigator.pushNamed(context, '/createAccount');
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

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreen();
}

class _CreateAccountScreen extends State<CreateAccountScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
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

            var result = await chatState.login(
                nameController.text, passwordController.text, true);
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
          Navigator.pushNamed(context, '/login');
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

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<ChatState>();

    final ScrollController scrollCtrl = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollCtrl.animateTo(scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 1),
          curve: Curves.fastOutSlowIn);
    });

    final chatview = ListView(
      controller: scrollCtrl,
      children: [
        for (var chatEntry in appState.chat)
          ListTile(
            leading: Text(readTimestamp(chatEntry.date)),
            title: Text(chatEntry.message),
          ),
      ],
    );
    final FocusNode chatFieldFocus = FocusNode();
    var chatField = TextField(
      autofocus: true,
      controller: appState.chatController,
      focusNode: chatFieldFocus,
      maxLines: null,
      decoration:
          const InputDecoration.collapsed(hintText: "Enter your text here"),
    );

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          title: const Text('Sample Chat'),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: chatview,
            ),
            const Divider(),
            Row(children: [
              Expanded(
                child: Card(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: chatField,
                )),
              ),
              ElevatedButton(
                onPressed: () async {
                  await appState.sendMessage();
                  chatFieldFocus.requestFocus();
                },
                child: const Text('Send'),
              )
            ]),
            const Divider(),
          ],
        ));
  }
}
