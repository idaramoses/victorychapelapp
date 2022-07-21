import 'dart:async';
import 'dart:io';

import 'package:WeightApp/Bible/chapter_page.dart';
import 'package:WeightApp/Bible/read_page.dart';
import 'package:WeightApp/Bible/widgets/books_widget.dart';
import 'package:WeightApp/Constants.dart';
import 'package:WeightApp/Message/Mesage.dart';
import 'package:WeightApp/Notification/Notification.dart';
import 'package:WeightApp/UPcoming/upcoming.dart';
import 'package:WeightApp/group/group_info.dart';
import 'package:WeightApp/group/rooms.dart';
import 'package:WeightApp/homepage/Donate.dart';
import 'package:WeightApp/homepage/account.dart';
import 'package:WeightApp/theming/theme_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

import '../application.dart';
import '../database.dart';
import '../model.dart';
import '../theme.dart';
import 'Livestream.dart';
import 'about.dart';
import 'allweight.dart';

class HomePage extends StatefulWidget {
  final int initialIndex;

  const HomePage({Key key, this.initialIndex}) : super(key: key);
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  static final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool searching = false;
  bool dark = false;
  SearchDelegate _searchDelegate;
  ThemeData theme = getAppTheme(theme: "blue");
  Book book;
  TabController tabController;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _bottomNavBarSelectedIndex = widget.initialIndex;
    this.getUser();
    firebaseCloudMessaging_Listeners();
    fcmSubscribe();
    handleDynamicLinks();
  }

  getUser() async {
    User firebaseUser = _auth.currentUser;
    await firebaseUser?.reload();
    firebaseUser = _auth.currentUser;

    if (firebaseUser != null) {
      setState(() {
        this.user = firebaseUser;
      });
    }
  }

  int _bottomNavBarSelectedIndex;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  void _onBottomNavBarItemTapped(int index) {
    setState(() {
      _bottomNavBarSelectedIndex = index;
    });
  }

  void showSuccessNotification(
      BuildContext context, String message, String title, String id) {
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveStreamPage()),
        );
      },
      child: Flushbar(
        backgroundColor: Constant.mainColor.withOpacity(0.5),
        title: title,
        message:
            message.length > 13 ? '${message.substring(0, 13)}...' : message,
        icon: Icon(
          Icons.live_tv,
          color: Colors.white,
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.orange[300],
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }

  void showSuccessNotification2(
      BuildContext context, String message, String title, String id) {
    InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LiveStreamPage()),
        );
      },
      child: Flushbar(
        backgroundColor: Constant.mainColor.withOpacity(0.5),
        title: title,
        message:
            message.length > 40 ? '${message.substring(0, 40)}...' : message,
        icon: Icon(
          Icons.notifications,
          size: 25.0,
          color: Colors.orange[300],
        ),
        duration: Duration(seconds: 3),
        leftBarIndicatorColor: Colors.orange[300],
        flushbarPosition: FlushbarPosition.TOP,
      )..show(context),
    );
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        var view = message['data']['type'];
        Timer(
          Duration(milliseconds: 1),
          () => showSuccessNotification(
              context,
              message['notification']['body'],
              message['notification']['title'],
              message['data']['user_id']),
        );
        // if (view != null) {
        //   // Navigate to the create post view
        //   if (view == 'live_stream') {
        //     Timer(
        //       Duration(milliseconds: 1),
        //       () => showSuccessNotification(
        //           context,
        //           message['notification']['body'],
        //           message['notification']['title'],
        //           message['data']['user_id']),
        //     );
        //   } else if (view == 'article_detail_noti') {
        //     Timer(
        //       Duration(milliseconds: 1),
        //       () => showSuccessNotification2(
        //           context,
        //           message['notification']['body'],
        //           message['notification']['title'],
        //           message['data']['user_id']),
        //     );
        //   } else if (view == 'p-group') {
        //     Timer(
        //       Duration(milliseconds: 1),
        //       () => showSuccessNotification2(
        //           context,
        //           message['notification']['body'],
        //           message['notification']['title'],
        //           message['data']['user_id']),
        //     );
        //   }
        //   // If there's no view it'll just open the app on the first view
        // }
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        Timer(Duration(milliseconds: 1), () => _serialiseAndNavigate(message));
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        Timer(Duration(milliseconds: 1), () => _serialiseAndNavigate(message));
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['type'];
    if (view != null) {
      // Navigate to the create post view
      if (view == 'live_stream') {
        print('private chat');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => LiveStreamPage()),
        // );
      } else if (view == 'radio') {}
      // If there's no view it'll just open the app on the first view
    }
  }

  // Future<void> fcmSubscribe() async {
  //   await _firebaseMessaging.subscribeToTopic('notification');
  // }
  void fcmSubscribe() async {
    try {
      _firebaseMessaging.subscribeToTopic('all');
      print('subscribed to topic');
    } catch (e) {
      print('error is $e');
    }
  }

  Future handleDynamicLinks() async {
    //get initial link if the app is started using link
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    //app brought into foreground using link
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLinkData) async {
      _handleDeepLink(dynamicLinkData);
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    if (deepLink != null) {
      if (deepLink.toString().contains("groups-join")) {
        print("///////////////////////////");
        String groupId = deepLink.queryParameters['groupId'];
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Main_Join(
            groupId: groupId,
            fromDeepLink: true,
          );
        }));
      }
      print('yes');
    }
  }

  @override
  Widget build(BuildContext context) {
    _searchDelegate = _MainSearchDelegate(_openBook, Theme.of(context));
    String Id = FirebaseAuth.instance.currentUser.uid;
    ScreenUtil.init(context, width: 1080, height: 1920);
    final _pageTitle = Text(
      'Victory Chapel',
      style: TextStyle(color: Constant.appiconColor),
    );
    return WillPopScope(
      onWillPop: () => handleWillPop(context),
      child: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .20,
                  decoration: BoxDecoration(
                    image: new DecorationImage(
                      image: new AssetImage("assets/images/victorychapel.jpg"),
                      fit: BoxFit.contain,
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 7.0),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: () => showDialog(
                    context: context,
                    builder: (ctx) => Consumer<ThemeNotifier>(
                        builder: (context, theme, child) => MaterialApp(
                            debugShowCheckedModeBanner: false,
                            theme: theme.getTheme(),
                            home: Container(
                                child: SimpleDialog(
                              title: const Text('CHOOSE THEME'),
                              children: <Widget>[
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    theme.setLightMode();
                                  },
                                  child: const Text('Light Theme'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    theme.setDarkMode();
                                  },
                                  child: const Text('Dark Theme'),
                                ),
                              ],
                            ))))),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                leading: Icon(Icons.brightness_4_outlined),
                title: Text('Change theme'),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => account()));
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                leading: Icon(Icons.account_circle),
                title: Text('Profile'),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Donate()));
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                leading: Icon(Icons.monetization_on_outlined),
                title: Text('Give'),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Upcoming()));
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                leading: Icon(Icons.bookmark_border),
                title: Text('Announcements'),
              ),
              Divider(
                color: Colors.black,
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => About()));
                },
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                leading: Icon(Icons.info),
                title: Text('About us'),
              ),
              Divider(
                color: Colors.black,
              ),
            ],
          ),
        ),
        appBar: !Platform.isIOS
            ? AppBar(
                backgroundColor: Constant.appbarColor,
                iconTheme: IconThemeData(color: Constant.appiconColor),
                elevation: 0,
                title: _pageTitle,
                actions: <Widget>[
                  _buildSearchAction(context),
                  Stack(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NotificationScreen()));
                          },
                          icon: Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                          )),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection("notifications")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection(
                                    FirebaseAuth.instance.currentUser.uid)
                                .where("read", isEqualTo: false)
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null ||
                                  snapshot.data.docs.length == 0) {
                                return SizedBox.shrink();
                              } else
                                return Container(
                                  height: 19,
                                  width: 19,
                                  child: Center(
                                      child: Text(
                                    snapshot.data.docs.length.toString(),
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(30),
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  )),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.red, width: 2),
                                      color: Colors.red,
                                      shape: BoxShape.circle),
                                );
                            }),
                      ),
                    ],
                  ),
                ],
              )
            : CupertinoNavigationBar(
                backgroundColor: Constant.appbarColor,
                // iconTheme: IconThemeData(color: Colors.white),
                middle: _pageTitle,
                trailing: _buildSearchAction(context),
              ),
        body: [
          All_weight(),
          this.book == null ? BooksWidget() : BooksWidget(book: this.book),
          homemesage(),
          groups(),
          // About(),
        ].elementAt(_bottomNavBarSelectedIndex),
        bottomNavigationBar: _buildBottomNavigationBar(context),
      ),
    );
  }

  final snackBar = SnackBar(
    content: Text(
      'Press back again to exit',
      style: TextStyle(color: Colors.white),
    ),
    backgroundColor: Constant.mainColor,
    duration: snackBarDuration,
  );
  static const snackBarDuration = Duration(seconds: 3);
  DateTime backButtonPressTime;
  Future<bool> handleWillPop(BuildContext context) async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        backButtonPressTime == null ||
            now.difference(backButtonPressTime) > snackBarDuration;

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      backButtonPressTime = now;
      Scaffold.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }

  _openBook(Book book) {
    setState(() {
      this.book = book;
    });
  }

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

  _buildTranslateMenu(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(Icons.translate),
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          PopupMenuItem(
            child: ListTile(
              title: Text('Shona'),
              onTap: () {
                application.onLocaleChanged(Locale('sn'));
                Navigator.of(context).pop();
              },
            ),
          ),
          PopupMenuItem(
            child: ListTile(
              title: Text('English'),
              onTap: () {
                application.onLocaleChanged(Locale('en'));
                Navigator.of(context).pop();
              },
            ),
          ),
        ];
      },
    );
  }

  _buildOverflowMenu(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return <PopupMenuEntry>[
          // PopupMenuItem(
          //   child: ListTile(
          //     title: Text('Settings'),
          //     onTap: () {
          //       Navigator.pop(context);
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (BuildContext context) {
          //         return account();
          //       }));
          //     },
          //   ),
          // ),
        ];
      },
    );
  }

  _buildIOSHome() {
    return CupertinoPageScaffold(
      child: Text("Not Text"),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Constant.mainColor,
      unselectedItemColor: Theme.of(context).accentColor,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_library),
          label: 'Bible',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book_outlined),
          label: 'Sermons',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.chat_bubble_outline),
              Positioned(
                top: 0,
                right: 0.0,
                child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("usersChatActivity")
                        .doc(FirebaseAuth.instance.currentUser.uid)
                        .collection('activity')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null ||
                          snapshot.data.docs.length == 0) {
                        return SizedBox.shrink();
                      } else
                        return Container(
                          // height: 15,
                          // width: 15,
                          padding: EdgeInsets.all(1),
                          decoration: new BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: BoxConstraints(
                            minWidth: 15,
                            minHeight: 15,
                          ),
                          child: Center(
                              child: Text(
                            snapshot.data.docs.length.toString(),
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(30),
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        );
                    }),
              ),
            ],
          ),
          label: 'Rooms',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.info),
        //   label: 'About',
        // ),
      ],
      currentIndex: _bottomNavBarSelectedIndex,
      // selectedItemColor: Theme.of(context).accentColor,
      onTap: _onBottomNavBarItemTapped,
    );
  }
}

//TODO: Set the theme for search delegate to match rest of application
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
