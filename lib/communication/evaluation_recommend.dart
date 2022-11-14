import 'package:flutter/material.dart';
import '../models/post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class evaluation_recommend extends StatefulWidget {
  const evaluation_recommend({Key? key}) : super(key: key);

  @override
  State<evaluation_recommend> createState() => _evaluation_recommendState();
}

class _evaluation_recommendState extends State<evaluation_recommend> {
  TextEditingController _tec = TextEditingController();
  RefreshController _refreshController = RefreshController(initialRefresh: false);
  void _onReplyRefresh() async{
    await Future.delayed(Duration(microseconds: 100));
    setState(() {
      userTable.sort((a,b)=>a.reply!.compareTo(b.reply!));
    });
    _refreshController.refreshCompleted();
  }
  void _onLikeRefresh() async{
    await Future.delayed(Duration(microseconds: 100));
    setState(() {
      userTable.sort((a,b)=>a.like!.compareTo(b.like!));
    });
    _refreshController.refreshCompleted();
  }
  List<Post> userTable = <Post>[
    Post(
        name: '익명1',
        icons: Icons.account_circle,
        title: '클레멘타인 이 영화 꼭 봐야함',
        comments: "아무내용...",
        like: 1,
        reply: 5),
    Post(
        name: '익명2',
        icons: Icons.account_circle,
        title: '바람둥이왕 신권일 이 영화 꼭 봐야함',
        comments: "아무내용...",
        like: 2,
        reply: 5),
    Post(
        name: '익명3',
        icons: Icons.account_circle,
        title: '잉여왕 이 영화 꼭 봐야함',
        comments: "아무내용...",
        like: 3,
        reply: 6),
    Post(
        name: '익명4',
        icons: Icons.account_circle,
        title: 'last stardust 이 영화 꼭 봐야함',
        comments: "아무내용...",
        like: 5,
        reply: 2),
    Post(
        name: '익명5',
        icons: Icons.account_circle,
        title: '패션왕 이 영화 꼭 보면 안돼',
        comments: "아무내용...",
        like: 4,
        reply: 5),
  ];


  @override

  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: _search(),
        ),
        Container(
          margin: EdgeInsets.only(top: 88),
          child: _postCard(),
        ),
        Container(
          child: _postWrite(),
        ),
        Container(
          margin: EdgeInsets.only(top: 55),
          child: _Sort(),
        ),
      ],
    );
  }

  Widget _Sort() {
    return Container(
        margin: EdgeInsets.only(top: 10, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: GestureDetector(
                  onTap: () {
                    _onReplyRefresh();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.swap_vert,
                        size: 25,
                      ),
                      Text('최신순'),
                    ],
                  )),
            ),
            Container(
              child: GestureDetector(
                  onTap: () {
                    _onLikeRefresh();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.thumb_up,
                        size: 25,
                      ),
                      Text('좋아요순')
                    ],
                  )),
            ),
          ],
        ));
  }

  Widget _postCard() {
    return ListView.separated(
      padding: EdgeInsets.all(8),
      itemCount: userTable.length,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[100],
          margin: EdgeInsets.all(3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 90,
              child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        userTable[index].icons,
                        color: Colors.grey[1],
                        size: 35,
                      ),
                      Text('${userTable[index].name}',
                          style: TextStyle(height: 1.5, fontSize: 13)),
                    ],
                  ),
                  title: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text('제목 : ${userTable[index].title}'),
                  ),
                  subtitle: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text('내용 : ${userTable[index].comments}',
                            style: TextStyle(height: 2)),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 150, top: 20, right: 10),
                        child: Row(
                          children: [
                            Icon(Icons.favorite,
                                size: 20, color: Colors.redAccent),
                            Text('${userTable[index].like}'),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Icon(Icons.chat_bubble_outline, size: 20),
                            Text('${userTable[index].reply}'),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ]),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }

  Widget _postWrite() {
    return Container(
        alignment: Alignment.bottomRight,
        child: GestureDetector(
          onTap: () {
            print('포스팅 업로드');
          },
          child: Container(
            margin: EdgeInsets.all(40),
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1000),
              color: Colors.grey[300],
            ),
            child: Icon(Icons.create, size: 30),
          ),
        ));
  }

  Widget _search() {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Row(
          children: [
            Flexible(
              child: Container(
                alignment: Alignment(0.0, 0.0),
                height: 45,
                margin: EdgeInsets.only(left: 10, right: 5, top: 15),
                padding: EdgeInsets.only(left: 5, right: 10),
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(width: 1, color: Colors.black12)),
                child: Row(children: <Widget>[
                  Flexible(
                    child: Container(
                      child: TextField(
                        controller: _tec,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: '게시물 제목, 내용, 작성자 검색',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            )),
                        cursorColor: Colors.black12,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 7, top: 15),
              child: Icon(Icons.search, size: 35),
            ),
          ],
        )
      ]),
    );
  }
}
