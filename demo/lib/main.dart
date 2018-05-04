import 'package:flutter/material.dart';
import 'package:demo/utils/common.dart';
import 'package:demo/demo/randomwords.dart';
import 'package:demo/demo/netimage.dart';
import 'package:demo/demo/listview_h.dart';
import 'package:demo/demo/listview_tree.dart';
import 'package:demo/demo/gridview_v.dart';
import 'package:demo/demo/AnimatedList.dart';
import 'package:demo/demo/ExpansionTile.dart';
import 'package:demo/demo/TabbedAppBar.dart';
import 'package:demo/demo/FadeAppTest.dart';
import 'package:demo/demo/SignaturePainter.dart';
import 'package:demo/demo/AsyncLoadListView.dart';


void main() => runApp(new MyApp());

final demoNames = <String>[
    '无限滚动列表',
    '显示网上的图片',
    '水平(ListView)',
    '不同类型的子项',
    '格子列表(GridList)',
    '卡片列表(AnimatedList)',
    '多级列表(ExpansionTile)',
    '选项卡式AppBar',
    '动画示例',
    '绘制画布Canvas',
    '异步加载列表',
    '-'
];

//final List<Widget> demoWidgetClass = new List<Widget>.unmodifiable([
//    NetImageDemo,
//    ListViewHDemo,
//    ListViewTreeDemo,
//    GridViewDemo,
//    AnimatedListSample,
//    ExpansionTileSample,
//]);

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'App Title',
      theme: new ThemeData(
          primaryColor: const Color(0xFFfffff8),  // 标题工具栏主题颜色
          //primaryColorLight: Colors.yellow,
          //splashColor: Colors.grey,  // 水波颜色
          //dividerColor: Colors.black,
          //scaffoldBackgroundColor: Colors.white,
          //primaryColorDark: Colors.red,
          //primarySwatch: Colors.blue,
          //cardColor: Colors.yellow,
      ),
      routes: <String, WidgetBuilder>{
          '/1': (BuildContext context) => new NetImageDemo(title: demoNames[1]),
          '/2': (BuildContext context) => new ListViewHDemo(title: demoNames[2]),
          '/3': (BuildContext context) => new ListViewTreeDemo(title: demoNames[3]),
          '/4': (BuildContext context) => new GridViewDemo(title: demoNames[4]),
          '/5': (BuildContext context) => new AnimatedListSample(title: demoNames[5]),
          '/6': (BuildContext context) => new ExpansionTileSample(title: demoNames[6]),
          '/7': (BuildContext context) => new TabbedAppBarSample(title: demoNames[7]),
          '/8': (BuildContext context) => new FadeAppTestSample(title: demoNames[8]),
          '/9': (BuildContext context) => new SignaturePainterSample(title: demoNames[9]),
          '/10': (BuildContext context) => new AsyncLoadListSample(title: demoNames[10]),
      },
      home: new MyHomePage(),
    );
  }

}

class MyHomePage extends StatefulWidget {
  @override
  createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

    void _select(Choice choice) {
        setState(() { // Causes the app to rebuild with the new _selectedChoice.
            Common.toast(choice.title);
        });
    }


    @override
  Widget build(BuildContext context) => new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Demo'),
        automaticallyImplyLeading: false,
        elevation: 0.5,  // 纸墨设计中控件的 z 坐标顺序，默认值为 4，对于可滚动的 SliverAppBar，
                         // 当 SliverAppBar 和内容同级的时候，该值为 0， 当内容滚动 SliverAppBar 变
                         // 为 Toolbar 的时候，修改 elevation 的值
        actions: <Widget>[
            new PopupMenuButton<Choice>( // overflow menu
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                  return choices.skip(2).map((Choice choice) {
                      return new PopupMenuItem<Choice>(
                          value: choice,
                          child: new Text(choice.title),
                      );
                  }).toList();
              },
          ),
        ],
      ),
      body: new ListView.builder(
            itemBuilder: (context, index) {
                if (index < demoNames.length) {
                    final item = demoNames[index];
                    if (item == '-') {
                        return new Divider();
                    }
                    return new ListTile(
                        leading: new Icon(Icons.list),
                        title: new Text(item),
                        onTap: () {
                            if (index == 0)
                                _showRandowWords(context, demoNames[0]);
                            else
                                Navigator.pushNamed(context, '/$index'); // 使用命名导航
                        },
                    );
                } else
                    return null;
            }
          ),
  );

  // 接收页面返回值 demo
  void _showRandowWords(BuildContext context, String _title) async {
      try {
          final result = await Navigator.push(
                  context,
                  new MaterialPageRoute(
                          builder: (context) =>
                          new RandomWords(title: _title))); // 开始新的Page，保留当前page
          //Scaffold.of(context).showSnackBar(new SnackBar(content: new Text("选择了 $result 项。")));
          if (result != null) {
              //Toast.show("选择了 $result 项。");
              Common.toast("选择了 $result 项。");

//              showDialog<Null>(
//                  context: context,
//                  builder: (context) {
//                      return new AlertDialog(
//                              content: new Text("选择了 $result 项。"),
//                              actions: <Widget>[
//                                  // FlatButton：质感设计中的平面按钮
//                                  new FlatButton(
//                                          onPressed: () {
//                                              Navigator.pop(context);
//                                          },
//                                          child: new Text('确定')
//                                  )
//                              ]
//                      );
//                  },
//              );
          }
      } finally  {
      }
  }

}


class Choice {
    const Choice({ this.title, this.icon });
    final String title;
    final IconData icon;
}

const List<Choice> choices = const <Choice>[
    const Choice(title: 'Car', icon: Icons.directions_car),
    const Choice(title: 'Bicycle', icon: Icons.directions_bike),
    const Choice(title: 'Boat', icon: Icons.directions_boat),
    const Choice(title: 'Bus', icon: Icons.directions_bus),
    const Choice(title: 'Train', icon: Icons.directions_railway),
    const Choice(title: 'Walk', icon: Icons.directions_walk),
];
