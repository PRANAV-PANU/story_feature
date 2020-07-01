class Post {
  int userId;
  int id;
  String title;
  bool completed;

  Post({this.userId, this.id, this.title, this.completed});

  Post.fromJson(Map<String, dynamic> json) {
//    if(json['userId']==1){
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  //}
  }
}