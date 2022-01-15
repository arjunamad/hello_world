import 'dart:html';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class post {
  String body;
  String author;
  int likes = 0;
  bool userLiked = false;

  post(this.body, this.author);

  void likedpost() {
    this.userLiked = this.userLiked;
    if (this.userLiked) {
      this.likes += 1;
    } else {
      this.likes -= 1;
    }
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arjuna Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<post> posts = [];

  void newPost(String text) {
    this.setState(() {
      posts.add(new post(text, "Arjuna"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Hello I am Arjuna This is my demo')),
        body: Column(children: <Widget>[
          Expanded(child: PostList(this.posts)),
          TextInputWiget(this.newPost),
        ]));
  }
}

class TextInputWiget extends StatefulWidget {
  final Function(String) callback;

  TextInputWiget(this.callback);

  @override
  _TextinputwigetState createState() => _TextinputwigetState();
}

class _TextinputwigetState extends State<TextInputWiget> {
  final controller = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void click() {
    widget.callback(controller.text);
    controller.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: this.controller,
        decoration: InputDecoration(
            prefixIcon: Icon(Icons.message),
            labelText: "please enter your Comment and press the button:",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue,
              tooltip: "click to save",
              onPressed: this.click,
            )));
  }
}

class PostList extends StatefulWidget {
  final List<post> listItems;

  PostList(this.listItems);

  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  void like(Function callBack) {
    this.setState(() {
      callBack();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.listItems.length,
      itemBuilder: (context, index) {
        var post = this.widget.listItems[index];
        return Card(
            child: Row(children: <Widget>[
          Expanded(
              child: ListTile(
            title: Text(post.body),
            subtitle: Text(post.author),
          )),
          Row(
            children: <Widget>[
              Container(
                child: Text(
                  post.likes.toString(),
                  style: TextStyle(fontSize: 20),
                ),
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              ),
              IconButton(
                  icon: Icon(Icons.thumb_up),
                  onPressed: () => this.like(post.likedpost),
                  color: post.userLiked ? Colors.red : Colors.black)
            ],
          )
        ]));
      },
    );
  }
}
