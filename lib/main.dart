import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'URL Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('URL Launcher'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Enter a URL to launch in a WebView:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          TextField(
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter a URL'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Launch URL'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewPage(url: _controller.text),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String url;

  const WebViewPage({required this.url, Key? key}) : super(key: key);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
      ),
      body: WebView(
        initialUrl:
            widget.url.startsWith("http") ? widget.url : "http://${widget.url}",
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController webViewController) {
          setState(() {
            controller = webViewController;
          });
        },
      ),
    );
  }
}
