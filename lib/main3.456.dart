import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        "CC": (context) => CCRoute(),
        "new_page": (context) => NewRoute(),
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        "Tips2": (context) => TipRoute(text: ModalRoute.of(context).settings.arguments),
      },
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class NewRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route")
        ),
        body: Center(
          child: Text("This is new route"),
        ),
    );
  }
}

class CCRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("CC route")
        ),
        body: Center(
          // child: Text("This is new route"),
          child: Text(args),
        ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({
    Key key, 
    @required this.text,
  }) : super(key: key);
  final String text;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("提示")),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center (
          child: Column (
            children: <Widget> [
              Text(text),
              RaisedButton(
                onPressed: () => Navigator.pop(context, "我是返回值"),
                child: Text("返回")
              )
            ]
          )
        )
      )
    );
  }
}

class RouterTestRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () async {
          var result = await Navigator.push (
            context,
            MaterialPageRoute(
              builder: (context) {
                return TipRoute(
                  text: "我是提示XXXX"
                  );
              },
            )
          );
          print("路由返回值: $result");
        },
        child: Text("打开提示页"),
      )
    );
  }
}

class Echo extends StatelessWidget {
  const Echo({
    Key key,
    @required this.text,
    this.backgroundColor: Colors.grey,
  }) : super (key: key);

  final String text;
  final Color backgroundColor;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CC Echo")
        ),
        body: Center(
          child: Text(text)
        ),
    );

    // return Center(
    //   child: Container (
    //     color: backgroundColor,
    //     child: Text(text)
    //   )
    // );
  }
}

class ContextRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Context测试")
        ),
      body: Container (
        child: Builder (builder: (context) {
          Scaffold scaffold = context.findAncestorWidgetOfExactType<Scaffold>();

          return (scaffold.appBar as AppBar).title;
        }),
      )
    );
  }
}

class StateRoute extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
              appBar: AppBar(
                title: Text("子树中获取State对象"),
              ),
              body: Center(
                child: Builder(builder: (context) {
                  return RaisedButton(
                    onPressed: () {
                      // 查找父级最近的Scaffold对应的ScaffoldState对象
                      ScaffoldState _state = context.findAncestorStateOfType<ScaffoldState>();
                      //调用ScaffoldState的showSnackBar来弹出SnackBar
                      _state.showSnackBar(
                        SnackBar(
                          content: Text("我是SnackBar"),
                        ),
                      );
                    },
                    child: Text("显示SnackBar"),
                  );
                }),
              ),
            );
  }
}

class CounterWidget extends StatefulWidget {
  const CounterWidget({
    Key key,
    this.initValue: 0
  });

  final int initValue;

  @override
  _CounterWidgetState createState() => new _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {  
  int _counter;

  @override
  void initState() {
    super.initState();
    //初始化状态  
    _counter=widget.initValue;
    print("initState");
  }

  @override
  Widget build(BuildContext context) {
    print("build");
    return Scaffold(
      body: Center(
        child: FlatButton(
          child: Text('$_counter'),
          //点击后计数器自增
          onPressed:()=>setState(()=> ++_counter,
          ),
        ),
      ),
    );
  }

  @override
  void didUpdateWidget(CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactive");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  void reassemble() {
    super.reassemble();
    print("reassemble");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

}

class CupertinoTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text("Cupertino Demo"),
      ),
      child: Center(
        child: CupertinoButton(
            color: CupertinoColors.activeBlue,
            child: Text("Press"),
            onPressed: () {}
        ),
      ),
    );
  }
}

// TapboxA 管理自身状态.

//------------------------- TapboxA ----------------------------------

class TapboxA extends StatefulWidget {
  TapboxA({Key key}) : super(key: key);

  @override
  _TapboxAState createState() => new _TapboxAState();
}

class _TapboxAState extends State<TapboxA> {
  bool _active = false;

  void _handleTap() {
    setState(() {
      _active = !_active;
    });
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            _active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: _active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

// ParentWidget 为 TapboxB 管理状态.

//------------------------ ParentWidget --------------------------------

class ParentWidget extends StatefulWidget {
  @override
  _ParentWidgetState createState() => new _ParentWidgetState();
}

class _ParentWidgetState extends State<ParentWidget> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxB(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//------------------------- TapboxB ----------------------------------

class TapboxB extends StatelessWidget {
  TapboxB({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  void _handleTap() {
    onChanged(!active);
  }

  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: _handleTap,
      child: new Container(
        child: new Center(
          child: new Text(
            active ? 'Active' : 'Inactive',
            style: new TextStyle(fontSize: 32.0, color: Colors.white),
          ),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: active ? Colors.lightGreen[700] : Colors.grey[600],
        ),
      ),
    );
  }
}

//---------------------------- ParentWidget ----------------------------

class ParentWidgetC extends StatefulWidget {
  @override
  _ParentWidgetCState createState() => new _ParentWidgetCState();
}

class _ParentWidgetCState extends State<ParentWidgetC> {
  bool _active = false;

  void _handleTapboxChanged(bool newValue) {
    setState(() {
      _active = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new TapboxC(
        active: _active,
        onChanged: _handleTapboxChanged,
      ),
    );
  }
}

//----------------------------- TapboxC ------------------------------

class TapboxC extends StatefulWidget {
  TapboxC({Key key, this.active: false, @required this.onChanged})
      : super(key: key);

  final bool active;
  final ValueChanged<bool> onChanged;

  @override
  _TapboxCState createState() => new _TapboxCState();
}

class _TapboxCState extends State<TapboxC> {
  bool _highlight = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _highlight = true;
    });
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTapCancel() {
    setState(() {
      _highlight = false;
    });
  }

  void _handleTap() {
    widget.onChanged(!widget.active);
  }

  @override
  Widget build(BuildContext context) {
    // 在按下时添加绿色边框，当抬起时，取消高亮  
    return new GestureDetector(
      onTapDown: _handleTapDown, // 处理按下事件
      onTapUp: _handleTapUp, // 处理抬起事件
      onTap: _handleTap,
      onTapCancel: _handleTapCancel,
      child: new Container(
        child: new Center(
          child: new Text(widget.active ? 'Active' : 'Inactive',
              style: new TextStyle(fontSize: 32.0, color: Colors.white)),
        ),
        width: 200.0,
        height: 200.0,
        decoration: new BoxDecoration(
          color: widget.active ? Colors.lightGreen[700] : Colors.grey[600],
          border: _highlight
              ? new Border.all(
                  color: Colors.teal[700],
                  width: 10.0,
                )
              : null,
        ),
      ),
    );
  }
}

// String icons = "";
// // accessible: &#xE914; or 0xE914 or E914
// icons += "\uE914";
// // error: &#xE000; or 0xE000 or E000
// icons += " \uE000";
// // fingerprint: &#xE90D; or 0xE90D or E90D
// icons += " \uE90D";


class SwitchAndCheckBoxTestRoute extends StatefulWidget {
  @override
  _SwitchAndCheckBoxTestRouteState createState() => new _SwitchAndCheckBoxTestRouteState();
}

class _SwitchAndCheckBoxTestRouteState extends State<SwitchAndCheckBoxTestRoute> {
  bool _switchSelected=true; //维护单选开关状态
  bool _checkboxSelected=true;//维护复选框状态
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Switch(
          value: _switchSelected,//当前状态
          onChanged:(value){
            //重新构建页面  
            setState(() {
              _switchSelected=value;
            });
          },
        ),
        Checkbox(
          value: _checkboxSelected,
          activeColor: Colors.red, //选中时的颜色
          onChanged:(value){
            setState(() {
              _checkboxSelected=value;
            });
          } ,
        )
      ],
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(child: Text("RaisedButton normal"), onPressed: () {}),
            FlatButton(child: Text("FlatButton normal"), onPressed: () {}),
            OutlineButton(child: Text("OutlineButton normal"), onPressed: () {}),
            IconButton(icon: Icon(Icons.thumb_up), onPressed: () {}),

SwitchAndCheckBoxTestRoute(),
// Text(icons,
Text("\uE914  \uE000 \uE90D",
  style: TextStyle(
      fontFamily: "MaterialIcons",
      fontSize: 24.0,
      color: Colors.green
  ),
),

RaisedButton.icon(
  icon: Icon(Icons.send),
  label: Text("发送"),
  onPressed: () {},
),
OutlineButton.icon(
  icon: Icon(Icons.add),
  label: Text("添加"),
  onPressed: () {},
),
FlatButton.icon(
  icon: Icon(Icons.info),
  label: Text("详情"),
  onPressed: () {},
),

FlatButton(
  color: Colors.blue,
  highlightColor: Colors.blue[700],
  colorBrightness: Brightness.dark,
  splashColor: Colors.grey,
  child: Text("Submit"),
  shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  onPressed: () {},
),
Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4", width : 100),
Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4", width : 100, color: Colors.blue, colorBlendMode: BlendMode.difference),
Image.network("https://avatars2.githubusercontent.com/u/20411648?s=460&v=4", width : 100, height: 200.0, repeat: ImageRepeat.repeatY ,),


            Text.rich(TextSpan(
    children: [
     TextSpan(
       text: "Home: "
     ),
     TextSpan(
       text: "CCCCCCCCCCCCCCCCCC",
       style: TextStyle(
         color: Colors.blue
       ),  
      //  recognizer: _tapRecognizer
     ),
    ]
)),
            Text("Hello world",
  style: TextStyle(
    color: Colors.blue,
    fontSize: 18.0,
    height: 1.2,  
    fontFamily: "Courier",
    background: new Paint()..color=Colors.yellow,
    decoration:TextDecoration.underline,
    decorationStyle: TextDecorationStyle.dashed
  ),
),
            Text("Hello world",
              textAlign: TextAlign.left,
            ),

            Text("Hello world! I'm Jack. "*4,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            Text("Hello world",
              textScaleFactor: 1.5,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),

            FlatButton(
              child: Text("Open HI CC"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    return Text("HI CC" * 6, textAlign: TextAlign.center);
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open new route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    return NewRoute();
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open RouterTestRoute"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    return RouterTestRoute();
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open register route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.pushNamed(context, "new_page");
                // Navigator.push (context, 
                //   MaterialPageRoute(builder: (context) {
                //     return RouterTestRoute();
                //   })
                // );
              }
            ),

            FlatButton(
              child: Text("Open CC register route"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.of(context).pushNamed("CC", arguments: "Hi CC!");
              }
            ),

            FlatButton(
              child: Text("Open Tips2 route"),
              textColor: Colors.blue,
              onPressed: () {
                // Navigator.of(context).pushNamed("CC", arguments: "Hi CC!");
                Navigator.of(context).pushNamed("Tips2", arguments: "Hi Tips2 CC!");
              }
            ),

            FlatButton(
              child: Text("Open echo"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    return Echo(text: "Hi CC");
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open ContextRoute"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    return ContextRoute();
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open CounterWidget"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                      //移除计数器 
                    return CounterWidget();
                    //随便返回一个Text()
                      // return Text("xxx");
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open StateRoute"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    return StateRoute();
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open CupertinoTestRoute"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    return CupertinoTestRoute();
                  })
                );
              }
            ),

            FlatButton(
              child: Text("Open TapboxA"),
              textColor: Colors.blue,
              onPressed: () {
                Navigator.push (context, 
                  MaterialPageRoute(builder: (context) {
                    // return TapboxA();
                    // return TapboxB();
                    // return ParentWidget();
                    return ParentWidgetC();
                    // return TapboxC();
                  })
                );
              }
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
