import 'dart:math';

import 'package:WeightApp/Bible/read_page.dart';
import 'package:flutter/material.dart';

import '../Constants.dart';
import '../database.dart';
import '../model.dart';

class ChapterListPage extends StatefulWidget {
  final List<Chapter> chapters;
  final Book book;

  const ChapterListPage({Key key, this.chapters, this.book}) : super(key: key);

  @override
  ChapterListPageState createState() {
    return new ChapterListPageState();
  }
}

class ChapterListPageState extends State<ChapterListPage> {
  final DatabaseProvider db = DatabaseProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constant.appbarColor,
        title: Text(
          '${widget.book.name}',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomLeft,
          colors: [
            Constant.mainColor.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
            Constant.mainColor.withOpacity(0.05),
            Colors.white.withOpacity(0.02),
            Constant.mainColor.withOpacity(0.01),
          ],
        )),
        child: FutureBuilder(
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ChapterList(
                book: widget.book,
                chapters: snapshot.data,
              );
            } else if (snapshot.hasError) {
              return Text('Error');
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
          future: _getChapters(),
        ),
      ),
    );
  }

  Future<List<Chapter>> _getChapters() async {
    await db.openDefault(context);
    return db.getChapters(widget.book);
  }
}

class ChapterList extends StatelessWidget {
  final List<Chapter> chapters;
  final Book book;

  const ChapterList({Key key, this.chapters, this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Color> myColors = [
      Colors.yellow[200],
      Colors.red[200],
      Colors.green[200],
      Colors.deepPurple[200],
      Colors.purple[200],
      Colors.cyan[200],
      Colors.teal[200],
      Colors.tealAccent[200],
      Colors.pink[200],
    ];
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Random random = new Random();
        Color bg = myColors[random.nextInt(4)];
        return AndroidListCard(
          child: ListTile(
            onTap: () => _goToChapter(context, chapters[index]),
            // leading: CircleAvatar(
            //   child: Text(
            //     '${chapters[index].chapter}',
            //     maxLines: 1,
            //     style: TextStyle(fontSize: 13),
            //   ),
            //   backgroundColor: bg,
            // ),
            title: Text(
              '${chapters[index].name} ${chapters[index].chapter}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
      itemCount: this.chapters.length,
    );
  }

  _goToChapter(BuildContext context, Chapter chapter) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ReadPage(
        book: this.book,
        chapter: chapter,
      );
    }));
  }
}

class AndroidListCard extends StatelessWidget {
  final Widget child;

  const AndroidListCard({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: child,
      ),
    );
  }
}
