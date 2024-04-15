import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Chat extends StatefulWidget {
  const Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  TextEditingController textController = TextEditingController();
  final List<String> mensagens = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
          ListView.builder(
              itemCount: mensagens.length,
              itemBuilder: (context, index) {
                return const Column(
                  children: [],
                );
              }),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: EdgeInsets.only(bottom: keyboardHeight),
                color: const Color(0xFF1f2c34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 300,
                      child: TextField(
                        style: const TextStyle(color: Colors.white),
                        controller: textController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Digite algo aqui",
                          prefix: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.emoji_emotions_outlined,
                                color: Colors.white,
                              )),
                          suffix: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.attach_file,
                                  color: Colors.white)),
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                        ),
                        child: textController.text.isNotEmpty
                            ? IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.arrow_right_alt_outlined,
                                    color: Colors.black))
                            : IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.mic, color: Colors.black)))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget minhaMensage() {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: const Text('oi'),
    );
  }
}
