import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../database.dart';
import '../../model.dart';
import '../chapter_page.dart';
import '../read_page.dart';

class BooksWidget extends StatefulWidget {
  final Book book;

  const BooksWidget({Key key, this.book}) : super(key: key);

  @override
  _BooksWidgetState createState() {
    return _BooksWidgetState(currentBook: this.book);
  }
}

class _BooksWidgetState extends State<BooksWidget> {
  final db = DatabaseProvider();
  Book currentBook;

  _BooksWidgetState({this.currentBook});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: _getBooks(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return BookList(snapshot.data, (book) => _goToBook(book));
          } else {
            return Text('Something is wrong');
          }
        } else if (snapshot.hasError) {
          return Text("""
          Error reading from the database.
          The error is ${snapshot.error}.
          Please try again :-);          
          """);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<Book>> _getBooks() async {
    await db.openDefault(context);
    return db.getBooks();
  }

  _goToBook(Book book) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return ChapterListPage(book: book);
    }));
  }
}

class OpenBible extends StatefulWidget {
  final Book book;

  const OpenBible({Key key, this.book}) : super(key: key);

  @override
  _OpenBibleState createState() {
    return _OpenBibleState(currentBook: this.book);
  }
}

class _OpenBibleState extends State<OpenBible> {
  final db = DatabaseProvider();
  Book currentBook;

  _OpenBibleState({this.currentBook});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: _getBooks(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data != null) {
            return MainBookList(snapshot.data, (book) => _goToBook(book));
          } else {
            return Text('Something is wrong');
          }
        } else if (snapshot.hasError) {
          return Text("""
          Error reading from the database.
          The error is ${snapshot.error}.
          Please try again :-);          
          """);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Future<List<Book>> _getBooks() async {
    await db.openDefault(context);
    return db.getBooks();
  }

  _goToBook(Book book) {
    Navigator.push(context,
        new MaterialPageRoute(builder: (BuildContext context) {
      return ChapterListPage(book: book);
    }));
  }
}

class MainBookList extends StatefulWidget {
  final List<Book> books;
  final callback;

  MainBookList(this.books, this.callback);

  @override
  _MainBookListState createState() => _MainBookListState();
}

class _MainBookListState extends State<MainBookList> {
  SearchDelegate _searchDelegate;
  Book book;

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

  @override
  Widget build(BuildContext context) {
    _searchDelegate = _MainSearchDelegate(_openBook, Theme.of(context));

    return Scaffold(
      appBar: !Platform.isIOS
          ? AppBar(
              backgroundColor: Constant.appbarColor,
              iconTheme: IconThemeData(color: Constant.appiconColor),
              title: _pageTitle,
              actions: <Widget>[
                _buildSearchAction(context),
                // Container(
                //   height: 30,
                //   width: 30,
                //   child: ClipOval(
                //     child: FadeInImage(
                //       image: NetworkImage(
                //         user.photoURL ?? '',
                //       ),
                //       height: 30,
                //       width: 30,
                //       fit: BoxFit.cover,
                //       placeholder: AssetImage('assets/images/avatar.png'),
                //     ),
                //   ),
                // ),
              ],
            )
          : CupertinoNavigationBar(
              backgroundColor: Constant.appbarColor,
              // iconTheme: IconThemeData(color: Colors.white),
              middle: _pageTitle,
              trailing: _buildSearchAction(context),
            ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Random random = new Random();
            Color bg = myColors[random.nextInt(4)];
            String _name = '${widget.books[index].name}';
            _name.length > 2 ? _name.substring(0, 2) : _name;
            return Container(
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
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () => widget.callback(widget.books[index]),
                  leading: CircleAvatar(
                    child: Text(
                      _name.length > 4 ? _name.substring(0, 4) : _name,
                      maxLines: 1,
                      style: TextStyle(fontSize: 13),
                    ),
                    backgroundColor: bg,
                  ),
                  title: Text(
                    '${widget.books[index].name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // subtitle: Text('${books[index].altName}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            );
          },
          itemCount: widget.books.length,
        ),
      ),
    );
  }

  _openBook(Book book) {
    setState(() {
      this.book = book;
    });
  }

  final _pageTitle = Text(
    'Bible',
    style: TextStyle(color: Constant.appiconColor),
  );

  IconButton _buildSearchAction(BuildContext context) {
    return IconButton(
      tooltip: 'Search',
      icon: const Icon(
        Icons.search,
        color: Colors.white,
      ),
      onPressed: () async {
        await showSearch<dynamic>(
          context: context,
          delegate: _searchDelegate,
        );
      },
    );
  }

  _goToBook(Book book) {
    print(book.name);
  }
}

class BookList extends StatelessWidget {
  final List<Book> books;
  final callback;

  BookList(this.books, this.callback);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(
          itemBuilder: (context, index) {
            Random random = new Random();
            Color bg = myColors[random.nextInt(4)];
            String _name = '${books[index].name}';
            _name.length > 2 ? _name.substring(0, 2) : _name;
            return Container(
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
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  onTap: () => callback(books[index]),
                  leading: CircleAvatar(
                    child: Text(
                      _name.length > 4 ? _name.substring(0, 4) : _name,
                      maxLines: 1,
                      style: TextStyle(fontSize: 13),
                    ),
                    backgroundColor: bg,
                  ),
                  title: Text(
                    '${books[index].name}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // subtitle: Text('${books[index].altName}'),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
            );
          },
          itemCount: books.length,
        ),
      ),
    );
  }

  _goToBook(Book book) {
    print(book.name);
  }
}

class _MainSearchDelegate extends SearchDelegate {
  final db = DatabaseProvider();
  final ThemeData theme;
  final void Function(Book) _openBook;

  _MainSearchDelegate(this._openBook, this.theme);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        tooltip: 'Clear',
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  ///This method builds the results for the search query on submit
  ///The results are built first from the list of book, then a full text search.
  ///
  ///todo: search better than this
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: db.openDefault(context).then((_) => db.searchText(query)),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data != null && snapshot.data.length > 0) {
                List<Verse> results = snapshot.data;
                return Column(
                  children: <Widget>[
                    Text(
                      results.length.toString() + ' results',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Expanded(child: _resultList(results))
                  ],
                );
              } else {
                return Text('Nothing.');
              }
            } else if (snapshot.hasError) {
              return Text("""An error has occured,
              ${snapshot.error}
              Please retry.""");
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Waiting for resultss'),
                CircularProgressIndicator(),
              ],
            );
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      child: FutureBuilder<List<Book>>(
        future: db.openDefault(context).then((value) => db.getBooks()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Book> allBooks = snapshot.data.toList();
            List<Book> suggestions = allBooks
                .where((book) =>
                    book.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
            if (suggestions.length > 0) {
              return _suggestionList(suggestions);
            }
          } else if (snapshot.hasError) {
            return Text("""Error
            ${snapshot.error}""");
          }
          return Container();
        },
      ),
    );
  }

  Widget _suggestionList(suggestions) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        String suggestion = suggestions[index].name;
        int indexOfQuery =
            suggestion.toLowerCase().indexOf(query.toLowerCase());
        return ListTile(
          onTap: () {
            Navigator.of(context).pop();
            _goToBook(context, suggestions[index]);
          },
          title: RichText(
            text: TextSpan(
              children: indexOfQuery > 0
                  ? <TextSpan>[
                      TextSpan(
                        text: suggestion.substring(0, indexOfQuery),
                        style: theme.textTheme.bodyText1,
                      ),
                      TextSpan(
                        text: suggestion.substring(
                            indexOfQuery, indexOfQuery + query.length),
                        style: theme.textTheme.bodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: suggestion.substring(indexOfQuery + query.length),
                        style: theme.textTheme.bodyText1,
                      ),
                    ]
                  : <TextSpan>[
                      TextSpan(
                        text: suggestion.substring(0, query.length),
                        style: theme.textTheme.bodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: suggestion.substring(query.length),
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
            ),
          ),
        );
      },
      itemCount: suggestions.length,
    );
  }

  void _goToBook(BuildContext context, Book book) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return ChapterListPage(book: book);
    }));
  }

  Widget _resultList(List<Verse> results) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        Verse verse = results[index];
        String verseText = verse.text;
        int indexOfQuery =
            verse.text.toLowerCase().indexOf(query.toLowerCase());
        return ListTile(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return ReadPage(
                book: Book(id: verse.book, name: verse.bookName),
                chapter: Chapter(
                  id: verse.chapter,
                  book: verse.book,
                  chapter: verse.chapter,
                ),
              );
            }));
          },
          title: Text(
            verse.bookName +
                ' ' +
                verse.chapter.toString() +
                ':' +
                verse.verse.toString(),
          ),
          subtitle: RichText(
            text: TextSpan(
              children: indexOfQuery > 0
                  ? <TextSpan>[
                      TextSpan(
                        text: verseText.substring(0, indexOfQuery),
                        style: theme.textTheme.bodyText1,
                      ),
                      TextSpan(
                        text: verseText.substring(
                            indexOfQuery, indexOfQuery + query.length),
                        style: theme.textTheme.bodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: verseText.substring(indexOfQuery + query.length),
                        style: theme.textTheme.bodyText1,
                      ),
                    ]
                  : <TextSpan>[
                      TextSpan(
                        text: verseText.substring(0, query.length),
                        style: theme.textTheme.bodyText1
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: verseText.substring(query.length),
                        style: theme.textTheme.bodyText1,
                      ),
                    ],
            ),
          ),
        );
      },
      itemCount: results.length,
    );
  }
}
