import 'package:flutter/material.dart';
import 'package:docscan/theme.dart';

class Document extends StatefulWidget {
  const Document({Key? key}) : super(key: key);

  @override
  _DocumentState createState() => _DocumentState();
}

class _DocumentState extends State<Document> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, Welcome Back', style: desc),
            Container(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'Your Document \nFiles',
                style: title,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 5, 5, 5),
              margin: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: const Color(0x1a34395E),
                  borderRadius: BorderRadius.circular(50)),
              child: const TextField(
                decoration: InputDecoration(
                    icon: Icon(Icons.search),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Search data",
                    hintStyle: TextStyle(fontSize: 12)),
              ),
            ),
            Image.asset("assets/images/undraw_home.png"),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                ),
                Text(
                  "You don't have any documents!",
                  style: text,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                ),
                Center(
                    child: Text(
                  "Scan now to save your documents and storage efficiency",
                  style: desc,
                  textAlign: TextAlign.center,
                ))
              ],
            ),
          ],
        ),
      ))),
    );
  }
}
