import 'package:clipboard/clipboard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousLinks extends StatelessWidget {
  void _launchURL(String _url) async {
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Links'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('links').snapshots(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot<Map>> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot<Map> document) {
              return Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    new ListTile(
                      leading: Icon(Icons.link),
                      title: new Text(
                        document.data()!['name'],
                      ),
                      subtitle: new Text(
                        document.data()!['longUrl'],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('COPY'),
                          onPressed: () {
                            FlutterClipboard.copy(
                              document.data()!['url'],
                            ).then(
                              (value) => print('copied'),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        TextButton(
                          child: const Text('OPEN'),
                          onPressed: () {
                            _launchURL(document.data()!['url']);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
      // Column(
      //   children: [
      //     Card(
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: <Widget>[
      //           const ListTile(
      //             leading: Icon(Icons.link),
      //             title: Text('First Shorten Link'),
      //             subtitle: Text('https://www.bing.com/'),
      //           ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: <Widget>[
      //     TextButton(
      //       child: const Text('COPY'),
      //       onPressed: () {/* ... */},
      //     ),
      //     const SizedBox(width: 8),
      //     TextButton(
      //       child: const Text('OPEN'),
      //       onPressed: () {/* ... */},
      //     ),
      //               const SizedBox(width: 8),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ),
      // Card(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: <Widget>[
      //       const ListTile(
      //         leading: Icon(Icons.link),
      //         title: Text('Second Shorten Link'),
      //         subtitle: Text('https://www.google.com/'),
      //       ),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         children: <Widget>[
      //           TextButton(
      //             child: const Text('COPY'),
      //             onPressed: () {/* ... */},
      //           ),
      //           const SizedBox(width: 8),
      //           TextButton(
      //             child: const Text('OPEN'),
      //             onPressed: () {/* ... */},
      //           ),
      //           const SizedBox(width: 8),
      //         ],
      //       ),
      //     ],
      //   ),
      //     ),
      //   ],
      // ),
    );
  }
}
