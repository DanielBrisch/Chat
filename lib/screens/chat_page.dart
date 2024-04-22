import 'package:chat/models/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Chat extends StatefulWidget {
  final String deviceId;
  Chat({Key? key, required this.deviceId}) : super(key: key);

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DateTime now = DateTime.now();
  List<Mensagem> mensagens = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Person 2',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'lib/assets/wpp.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 70),
            child: StreamBuilder<List<Mensagem>>(
                stream: messagesStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Mensagem>> snapshot) {
                  if (snapshot.hasData) {
                    mensagens = snapshot.data!;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      if (_scrollController.hasClients) {
                        _scrollController.animateTo(
                          _scrollController.position.maxScrollExtent,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );
                      }
                    });
                  } else if (snapshot.hasError) {
                    return Text('Erro: ${snapshot.error}');
                  }

                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                      controller: _scrollController,
                      itemCount: mensagens.length,
                      itemBuilder: (context, index) {
                        Mensagem model = mensagens[index];

                        if (model.deviceId == widget.deviceId) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: 50,
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.8,
                                ),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF005d4b),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          model.mensagem,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              DateFormat('HH:mm')
                                                  .format(model.hora),
                                              style: const TextStyle(
                                                  color: Color(0xFF699c94),
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }

                        return Container();
                      });
                }),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: size.height * 0.015),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: size.width * 0.83,
                    decoration: BoxDecoration(
                        color: const Color(0xFF1f2c34),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.emoji_emotions_outlined,
                              color: Colors.white,
                            )),
                        Expanded(
                          child: TextField(
                            style: const TextStyle(color: Colors.white),
                            controller: textController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Digite algo aqui",
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.attach_file,
                                color: Colors.white)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.photo_camera,
                                color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      color: Colors.white,
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: textController,
                      builder: (context, TextEditingValue value, _) {
                        return value.text.isNotEmpty
                            ? IconButton(
                                onPressed: () async {
                                  final result = await firestore
                                      .collection("Aplicativo")
                                      .doc('chat')
                                      .collection('mensagens')
                                      .orderBy('id', descending: true)
                                      .limit(1)
                                      .get();

                                  int? numId;
                                  if (result.docs.isEmpty) {
                                    numId = 1;
                                  } else {
                                    numId = int.parse(result.docs.first
                                            .data()['id']
                                            .toString()) +
                                        1;
                                  }

                                  Mensagem msg = Mensagem(
                                      id: numId,
                                      mensagem: value.text,
                                      hora: now,
                                      deviceId: widget.deviceId);

                                  firestore
                                      .collection('Aplicativo')
                                      .doc('chat')
                                      .collection('mensagens')
                                      .doc(const Uuid().v1())
                                      .set(msg.toMap());
                                  textController.clear();
                                },
                                icon: const Icon(Icons.arrow_right_alt_outlined,
                                    color: Colors.black))
                            : IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.mic, color: Colors.black),
                              );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Stream<List<Mensagem>> messagesStream() {
    return firestore
        .collection("Aplicativo")
        .doc('chat')
        .collection('mensagens')
        .orderBy('id', descending: false)
        .snapshots()
        .map((snapshot) {
      var ls =
          snapshot.docs.map((doc) => Mensagem.fromMap(doc.data())).toList();

      ls.sort((a, b) => a.id.compareTo(b.id));

      return ls;
    });
  }
}
