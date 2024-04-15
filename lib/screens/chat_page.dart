import 'package:chat/models/mensagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

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
    mensagemRight();
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
          ListView(
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
                              model.mensagem,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              DateFormat('HH:mm').format(model.hora),
                              style: const TextStyle(color: Color(0xFF699c94)),
                            ),
                          ]),
                    ),
                  ),
                ),
              );
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
                      child: textController.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                Mensagem msg = Mensagem(
                                    id: const Uuid().v1(),
                                    mensagem: textController.text,
                                    hora: now);

                                firestore
                                    .collection('divice')
                                    .doc('infoDivice')
                                    .collection('mensagens')
                                    .doc(msg.id)
                                    .set(msg.toMap());

                                mensagemRight();
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

  mensagemRight() async {
    List<Mensagem> temp = [];
    QuerySnapshot<Map<String, dynamic>> snapshot = await firestore
        .collection("divice")
        .doc('infoDivice')
        .collection('mensagens')
        .get();

    for (var doc in snapshot.docs) {
      temp.add(Mensagem.fromMap(doc.data()));
    }

    setState(() {
      mensagens = temp;
    });
  }

  double widthMessage(Mensagem model) {
    double varWidthMessage = 0.20;

    // for (var i = 0; i < model.mensagem.length; i++) {
    //   if (i % 10 == 1) {
    //     varWidthMessage += 0.15;
    //   }
    // }

    return varWidthMessage;
  }
}
