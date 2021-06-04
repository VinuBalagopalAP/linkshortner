import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:clipboard/clipboard.dart';
import 'package:linkshortner/screens/menu.dart';
import 'package:linkshortner/service/network_handler.dart';

class HomeScreen extends StatelessWidget {
  final networkHandling = NetworkHandling();
  final TextEditingController _controller = TextEditingController();

  Future<void> postData(Map<String, String> body) async {
    var res = await networkHandling.post("/v4/shorten", body);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Menu(),
      ),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Link \nShortner!!!",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Name of the link",
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Center(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Paste the link to be shortened",
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color(0xFF0D47A1),
                                  Color(0xFF1976D2),
                                  Color(0xFF42A5F5),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(16.0),
                              primary: Colors.white,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                            child: const Text('Let\'s shorten it!'),
                            onPressed: () async {
                              await postData(
                                {
                                  "group_guid": "Ba1bc23dE4F",
                                  "domain": "bit.ly",
                                  "long_url": "https://dev.bitly.com"
                                },
                              );
                              Fluttertoast.showToast(
                                  msg: "Link Shortened!!!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blueAccent[200],
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    child: TextField(
                      enabled: false,
                      focusNode: FocusNode(),
                      enableInteractiveSelection: false,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        hintText: "Shortened Link",
                        suffixIcon: IconButton(
                          icon: Icon(
                            Icons.content_copy,
                          ),
                          onPressed: () {
                            FlutterClipboard.copy('hello flutter friends')
                                .then((value) => print('copied'));
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
