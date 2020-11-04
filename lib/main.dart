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
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
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
