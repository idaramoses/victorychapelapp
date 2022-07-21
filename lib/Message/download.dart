import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../main.dart';

class Download_details extends StatefulWidget with WidgetsBindingObserver {
  final TargetPlatform platform;

  Download_details({
    Key key,
    this.title,
    this.platform,
    this.topic,
    this.preacher,
    this.campus,
    this.date,
    this.p_code,
  }) : super(key: key);

  final String title;

  final String topic;
  final String preacher;
  final String campus;
  final String date;
  final String p_code;

  @override
  _Download_detailsState createState() => new _Download_detailsState();
}

class _Download_detailsState extends State<Download_details> {
  final _videos = [
    {
      'name': 'Big Buck Bunny',
      'link':
          'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3'
    },
  ];

  List<_TaskInfo> _tasks;
  List<_ItemHolder> _items;
  bool _isLoading;
  bool _permissionReady;
  String _localPath;
  String _path;
  ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();

    _bindBackgroundIsolate();

    FlutterDownloader.registerCallback(downloadCallback);

    _isLoading = true;
    _permissionReady = false;

    _prepare();
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _bindBackgroundIsolate() {
    bool isSuccess = IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    if (!isSuccess) {
      _unbindBackgroundIsolate();
      _bindBackgroundIsolate();
      return;
    }
    _port.listen((dynamic data) {
      if (debug) {
        print('UI Isolate Callback: $data');
      }
      String id = data[0];
      DownloadTaskStatus status = data[1];
      int progress = data[2];

      if (_tasks != null && _tasks.isNotEmpty) {
        final task = _tasks.firstWhere((task) => task.taskId == id);
        if (task != null) {
          setState(() {
            task.status = status;
            task.progress = progress;
          });
        }
      }
    });
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    if (debug) {
      print(
          'Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
    }
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 1080, height: 1920);

    return new Scaffold(
      backgroundColor: Colors.transparent,
      body: Builder(
          builder: (context) => _isLoading
              ? new Center(
                  child: new CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    _permissionReady
                        ? Expanded(child: _buildDownloadList())
                        : Expanded(child: _buildNoPermissionWarning()),
                  ],
                )),
    );
  }

  Widget _buildDownloadList() => Container(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 16.0),
          physics: NeverScrollableScrollPhysics(),
          children: _items
              .map((item) => item.task == null
                  ? Container()
                  : Row(
                      children: [
                        Expanded(
                          child: DownloadItem(
                            topic: widget.topic,
                            data: item,
                            onItemClick: (task) {
                              _openDownloadedFile(task).then((success) {
                                if (!success) {
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Cannot open this file')));
                                }
                              });
                            },
                            onAtionClick: (task) {
                              if (task.status == DownloadTaskStatus.undefined) {
                                _requestDownload(task);
                              } else if (task.status ==
                                  DownloadTaskStatus.running) {
                                _pauseDownload(task);
                              } else if (task.status ==
                                  DownloadTaskStatus.paused) {
                                _resumeDownload(task);
                              } else if (task.status ==
                                  DownloadTaskStatus.complete) {
                                _delete(task);
                              } else if (task.status ==
                                  DownloadTaskStatus.failed) {
                                _retryDownload(task);
                              }
                            },
                          ),
                        ),
                      ],
                    ))
              .toList(),
        ),
      );

  Widget _buildListSection(String title) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 0),
        ),
      );

  Widget _buildNoPermissionWarning() => Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  'Please grant accessing storage permission to continue -_-',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blueGrey, fontSize: 18.0),
                ),
              ),
              SizedBox(
                height: 32.0,
              ),
              FlatButton(
                  onPressed: () {
                    _checkPermission().then((hasGranted) {
                      setState(() {
                        _permissionReady = hasGranted;
                      });
                    });
                  },
                  child: Text(
                    'Retry',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ))
            ],
          ),
        ),
      );

  void _requestDownload(_TaskInfo task) async {
    task.taskId = await FlutterDownloader.enqueue(
        url: task.link,
        headers: {"auth": "test_for_sql_encoding"},
        savedDir: _localPath,
        showNotification: true,
        openFileFromNotification: true);
  }

  void _cancelDownload(_TaskInfo task) async {
    await FlutterDownloader.cancel(taskId: task.taskId);
  }

  void _pauseDownload(_TaskInfo task) async {
    await FlutterDownloader.pause(taskId: task.taskId);
  }

  void _resumeDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.resume(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  void taskid(_TaskInfo task) async {
    final tasks = await FlutterDownloader.loadTasks();
    task.taskId = _path;
  }

  void _retryDownload(_TaskInfo task) async {
    String newTaskId = await FlutterDownloader.retry(taskId: task.taskId);
    task.taskId = newTaskId;
  }

  Future<bool> _openDownloadedFile(_TaskInfo task) {
    return FlutterDownloader.open(taskId: task.taskId);
  }

  void _delete(_TaskInfo task) async {
    await FlutterDownloader.remove(
        taskId: task.taskId, shouldDeleteContent: true);
    await _prepare();
    setState(() {});
  }

  Future<bool> _checkPermission() async {
    if (widget.platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future<Null> _prepare() async {
    final tasks = await FlutterDownloader.loadTasks();

    int count = 0;
    _tasks = [];
    _items = [];

    _tasks.addAll(_videos
        .map((video) => _TaskInfo(name: widget.topic, link: widget.title)));

    _items.add(_ItemHolder(name: 'Videos'));
    for (int i = count; i < _tasks.length; i++) {
      _items.add(_ItemHolder(name: _tasks[i].name, task: _tasks[i]));
      count++;
    }

    tasks?.forEach((task) {
      for (_TaskInfo info in _tasks) {
        if (info.link == task.url) {
          _path = task.taskId;
          info.taskId = task.taskId;
          info.status = task.status;
          info.progress = task.progress;
        }
      }
    });

    _permissionReady = await _checkPermission();

    _localPath = (await _findLocalPath()) + Platform.pathSeparator + 'Victory';

    final savedDir = Directory(_localPath);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<String> _findLocalPath() async {
    final directory = widget.platform == TargetPlatform.android
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory.path;
  }
}

class DownloadItem extends StatelessWidget {
  final _ItemHolder data;
  final String topic;
  final Function(_TaskInfo) onItemClick;
  final Function(_TaskInfo) onAtionClick;

  DownloadItem({this.data, this.onItemClick, this.onAtionClick, this.topic});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: data.task.status == DownloadTaskStatus.complete
            ? () {
                onItemClick(data.task);
              }
            : null,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                width: double.infinity,
                height: 54.0,
                decoration: BoxDecoration(
                    // color: Constant.mainColor,
                    // border: Border.all(
                    //   color: Colors.black,
                    // ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _buildActionForTask(data.task),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            data.task.status == DownloadTaskStatus.running
                ? Container(
                    // height: 10,
                    child: Text(
                      '${data.task.progress} / 100%',
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w300,
                        fontSize: ScreenUtil().setSp(25),
                      ),
                    ),
                  )
                : Container(),
            data.task.status == DownloadTaskStatus.complete
                ? Container(
                    child: Text(
                      'Downloaded',
                      style: TextStyle(
                          fontSize: ScreenUtil().setSp(25),
                          color: Colors.green,
                          fontWeight: FontWeight.w300),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 10,
            ),
          ].where((child) => child != null).toList(),
        ),
      ),
    );
  }

  Widget _buildActionForTask(_TaskInfo task) {
    if (task.status == DownloadTaskStatus.undefined) {
      return InkWell(
        onTap: () {
          onAtionClick(task);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.file_download,
              size: 30,
            )
            // RawMaterialButton(
            //   onPressed: () {
            //     onAtionClick(task);
            //   },
            //   child: Icon(
            //     Icons.file_download,
            //     color: Colors.white,
            //   ),
            //   shape: CircleBorder(),
            //   constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
            // ),
          ],
        ),
      );
    } else if (task.status == DownloadTaskStatus.running) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              onAtionClick(task);
            },
            child: Icon(
              Icons.pause,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          ),
        ],
      );
    } else if (task.status == DownloadTaskStatus.paused) {
      return RawMaterialButton(
        onPressed: () {
          onAtionClick(task);
        },
        child: Icon(
          Icons.play_arrow,
        ),
        shape: CircleBorder(),
        constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
      );
    } else if (task.status == DownloadTaskStatus.complete) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_arrow,
            size: 30,
          )
          // RawMaterialButton(
          //   onPressed: () {
          //     // onAtionClick(task);
          //   },
          //   child: Icon(
          //     Icons.play_arrow,
          //     color: Colors.white,
          //   ),
          //   shape: CircleBorder(),
          //   constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          // )
        ],
      );
    } else if (task.status == DownloadTaskStatus.canceled) {
      return Center(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              onAtionClick(task);
            },
            child: Icon(
              Icons.refresh,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      ));
    } else if (task.status == DownloadTaskStatus.failed) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              onAtionClick(task);
            },
            child: Icon(
              Icons.refresh,
            ),
            shape: CircleBorder(),
            constraints: BoxConstraints(minHeight: 32.0, minWidth: 32.0),
          )
        ],
      );
    } else if (task.status == DownloadTaskStatus.enqueued) {
      return Text(
        'Pending',
      );
    } else {
      return null;
    }
  }
}

class _TaskInfo {
  final String name;
  final String link;

  String taskId;
  int progress = 0;
  DownloadTaskStatus status = DownloadTaskStatus.undefined;

  _TaskInfo({this.name, this.link});
}

class _ItemHolder {
  final String name;
  final _TaskInfo task;

  _ItemHolder({this.name, this.task});
}
