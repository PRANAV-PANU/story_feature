import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:http/http.dart' as http;

import 'package:story/post.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: Home());
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Post> _posts = List<Post>();

  Future<List<Post>> fetchPost() async {
    var url = "https://jsonplaceholder.typicode.com/todos";
    var response = await http.get(url);

    var post = List<Post>();
    if (response.statusCode == 200) {
      var notesJson = json.decode(response.body);
      for (var noteJson in notesJson) {
        post.add(Post.fromJson(noteJson));
      }
    } else {
      print('Hello');
    }
    return post;
  }

  final StoryController controller = StoryController();

  @override
  void initState() {
    fetchPost().then((value) {
      print('Hello init');
      setState(() {
        print(value.length);
        _posts.addAll(value);
      });
    });
    super.initState();
  }

  List<String> month = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delicious Ghanaian Meals"),
      ),
      body: Container(
        height: 80,
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 12,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MoreStories(_posts,index)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      width: 50,
                      child: Icon(
                        Icons.beenhere,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      month[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
//                child: StoryView(
//                  controller: controller,
//                  storyItems: [
//                    StoryItem.text(
//                      title:
//                      "Hello world!\nHave a look at some great Ghanaian delicacies. I'm sorry if your mouth waters. \n\nTap!",
//                      backgroundColor: Colors.orange,
//                      roundedTop: true,
//                    ),
//                    // StoryItem.inlineImage(
//                    //   NetworkImage(
//                    //       "https://image.ibb.co/gCZFbx/Banku-and-tilapia.jpg"),
//                    //   caption: Text(
//                    //     "Banku & Tilapia. The food to keep you charged whole day.\n#1 Local food.",
//                    //     style: TextStyle(
//                    //       color: Colors.white,
//                    //       backgroundColor: Colors.black54,
//                    //       fontSize: 17,
//                    //     ),
//                    //   ),
//                    // ),
//                    StoryItem.inlineImage(
//                      url:
//                      "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
//                      controller: controller,
//                      caption: Text(
//                        "Omotuo & Nkatekwan; You will love this meal if taken as supper.",
//                        style: TextStyle(
//                          color: Colors.white,
//                          backgroundColor: Colors.black54,
//                          fontSize: 17,
//                        ),
//                      ),
//                    ),
//                    StoryItem.inlineImage(
//                      url:
//                      "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
//                      controller: controller,
//                      caption: Text(
//                        "Hektas, sektas and skatad",
//                        style: TextStyle(
//                          color: Colors.white,
//                          backgroundColor: Colors.black54,
//                          fontSize: 17,
//                        ),
//                      ),
//                    )
//                  ],
//                  onStoryShow: (s) {
//                    print("Showing a story");
//                  },
//                  onComplete: () {
//                    print("Completed a cycle");
//                  },
//                  progressPosition: ProgressPosition.bottom,
//                  repeat: false,
//                  inline: true,
//                ),

//            Material(
//              child: InkWell(
//                onTap: () {
//                  Navigator.of(context).push(
//                      MaterialPageRoute(builder: (context) => MoreStories()));
//                },
//                child: Container(
//                  decoration: BoxDecoration(
//                      color: Colors.black54,
//                      borderRadius:
//                          BorderRadius.vertical(bottom: Radius.circular(8))),
//                  padding: EdgeInsets.symmetric(vertical: 8),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.center,
//                    children: <Widget>[
//                      Icon(
//                        Icons.arrow_forward,
//                        color: Colors.white,
//                      ),
//                      SizedBox(
//                        width: 16,
//                      ),
//                      Text(
//                        "View more stories",
//                        style: TextStyle(fontSize: 16, color: Colors.white),
//                      ),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          ],

class MoreStories extends StatefulWidget {
  final List<Post> userPosts;
  final int index;

  MoreStories(this.userPosts,this.index);

  @override
  _MoreStoriesState createState() => _MoreStoriesState();
}

class _MoreStoriesState extends State<MoreStories> {
  final storyController = StoryController();

  @override
  void dispose() {
    storyController.dispose();
    super.dispose();
  }

  String extractInfo() {
    return "Title :${widget.userPosts[widget.index].title}\n"
        "User Id :${widget.userPosts[widget.index].userId}\n"
        "Id :${widget.userPosts[widget.index].id}\n"
        "Completed :${widget.userPosts[widget.index].completed}\n";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("More"),
      ),
      body: StoryView(
        storyItems: [
          StoryItem.text(
            title: extractInfo(),
            backgroundColor: Colors.redAccent,
          )
        ],
        onStoryShow: (s) {
          print("Showing a story");
        },
        onComplete: () {
          print("Completed a cycle");
        },
        progressPosition: ProgressPosition.top,
        repeat: false,
        controller: storyController,
      ),
    );
  }
}

//      body: StoryView(
//        storyItems: [
//          StoryItem.text(
//            title: "I guess you'd love to see more of our food. That's great.",
//            backgroundColor: Colors.blue,
//          ),
//          StoryItem.text(
//            title: "Nice!\n\nTap to continue.",
//            backgroundColor: Colors.red,
//            textStyle: TextStyle(
//              fontFamily: 'Dancing',
//              fontSize: 40,
//            ),
//          ),
//          StoryItem.pageImage(
//            url:
//                "https://image.ibb.co/cU4WGx/Omotuo-Groundnut-Soup-braperucci-com-1.jpg",
//            caption: "Still sampling",
//            controller: storyController,
//          ),
//          StoryItem.pageImage(
//              url: "https://media.giphy.com/media/5GoVLqeAOo6PK/giphy.gif",
//              caption: "Working with gifs",
//              controller: storyController),
//          StoryItem.pageImage(
//            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
//            caption: "Hello, from the other side",
//            controller: storyController,
//          ),
//          StoryItem.pageImage(
//            url: "https://media.giphy.com/media/XcA8krYsrEAYXKf4UQ/giphy.gif",
//            caption: "Hello, from the other side2",
//            controller: storyController,
//          ),
//        ],
//        onStoryShow: (s) {
//          print("Showing a story");
//        },
//        onComplete: () {
//          print("Completed a cycle");
//        },
//        progressPosition: ProgressPosition.top,
//        repeat: false,
//        controller: storyController,
//      ),
