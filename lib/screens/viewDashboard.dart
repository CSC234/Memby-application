import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
home: DefaultTabController(
  length: choices.length,
  child: Scaffold(
    appBar: AppBar(
    title: const Text('View Dashboard'),
    bottom: TabBar(
      isScrollable: true,
      tabs: choices.map<Widget>((Choice choice){
        return Tab(
          text: choice.title,
        );
      }).toList(),
    ),
  ),
  body: TabBarView(
    children: choices.map((Choice choice){
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: ChoicePage(
          choice: choice,
        )
      );
    }).toList(),
  ),
  ),
),
    );
  }
}

class Choice {
  final String title;
  const Choice({this.title});
}

const List<Choice> choices = <Choice>[
  Choice(title: 'Daily'),
  Choice(title: 'Monthly'),
  Choice(title: 'Yearly'),
];

class ChoicePage extends StatelessWidget {
  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              choice.title,
              style:textStyle,
            )
          ],
        ),
      ),
    );
  }
}
