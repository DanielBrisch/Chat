import 'package:chat/models/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  @override
  void initState() {
    messageRight();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Person 1',
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
            child: ListView(
              children: List.generate(mensagens.length, (index) {
                Mensagem model = mensagens[index];
                return Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    key: ValueKey<Mensagem>(model),
                    padding: const EdgeInsets.only(top: 5, bottom: 5),
                    child: Container(
                      width: size.width * widthMessage(model),
                      decoration: const BoxDecoration(
                          color: Color(0xFF005d4b),
                          borderRadius: BorderRadius.all(Radius.circular(11))),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 7),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                message(model),
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                DateFormat('HH:mm').format(model.hora),
                                style:
                                    const TextStyle(color: Color(0xFF699c94)),
                              ),
                            ]),
                      ),
                    ),
                  ),
                );
              }),
            ),
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
                      child: textController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () async {
                                Future<String> metodo() async {
                                  if (mensagens.isNotEmpty) {
                                    var docData = mensagens.last.id;
                                    int newId = int.parse(docData);
                                    newId += 1;
                                    return newId.toString();
                                  } else {
                                    return "1";
                                  }
                                }

                                Mensagem msg = Mensagem(
                                    id: await metodo(),
                                    mensagem: textController.text,
                                    hora: now);

                                firestore
                                    .collection('device')
                                    .doc(widget.deviceId)
                                    .collection('mensagens')
                                    .doc(const Uuid().v1())
                                    .set(msg.toMap());

                                messageRight();
                              },
                              icon: const Icon(Icons.arrow_right_alt_outlined,
                                  color: Colors.black))
                          : IconButton(
                              onPressed: () {},
                              icon:
                                  const Icon(Icons.mic, color: Colors.black))),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  messageRight() async {
    List<Mensagem> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("device")
        .doc(widget.deviceId)
        .collection('mensagens')
        .orderBy('id', descending: false)
        .get();

    for (var doc in snapshot.docs) {
      temp.add(Mensagem.fromMap(doc.data()));
    }

    temp.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

    setState(() {
      mensagens = temp;
    });
  }

  double widthMessage(Mensagem model) {
    double varWidthMessage = 0.20;
    var num = message(model).length;
    for (var i = 0; i < num; i++) {
      varWidthMessage += 0.015;
      if (varWidthMessage == 0.8) {
        return varWidthMessage;
      }
    }

    return varWidthMessage;
  }

  String message(Mensagem model) {
    String msg = model.mensagem;
    StringBuffer formatedMessage = StringBuffer();

    for (int i = 0; i < msg.length; i++) {
      formatedMessage.write(msg[i]);

      if ((i + 1) % 30 == 0 && i != msg.length - 1) {
        formatedMessage.write('\n');
      }
    }

    return formatedMessage.toString();
  }
}
