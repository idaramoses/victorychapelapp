import 'package:flutter/material.dart';

import '../../model.dart';

class VerseLis extends StatelessWidget {
  final List<Verse> verses;

  const VerseLis({Key key, @required this.verses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text(
            "${index + 1}. ${this.verses[index].text}",
            style: Theme.of(context).textTheme.bodyText1,
          ),
        );
      },
      itemCount: this.verses.length,
    );
  }
}
