import 'package:accordion/accordion.dart';
import 'package:accordion/accordion_section.dart';
import 'package:accordion/controllers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_app/request_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  Widget RequestListView = Container();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  String _email = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 256,
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter your email',
                hintText: 'Enter your email',
              ),
              onChanged: ((value) => _email = value),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
            onPressed: _refreshAction,
            tooltip: 'New joke',
            child: new Icon(Icons.refresh),
          ),
          SizedBox(
            height: 20,
          ),
          Accordion(
            maxOpenSections: 1,
            // headerBackgroundColorOpened: Colors.black54,
            headerPadding:
                const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            sectionOpeningHapticFeedback: SectionHapticFeedback.heavy,
            sectionClosingHapticFeedback: SectionHapticFeedback.light,
            children: [
              AccordionSection(
                paddingBetweenOpenSections: 20,
                paddingBetweenClosedSections: 20,
                headerPadding: EdgeInsets.fromLTRB(20, 10, 10, 10),
                rightIcon: Icon(
                  Icons.remove_circle,
                  color: Color(0xff250543),
                ),
                headerBorderRadius: 25,
                isOpen: true,
                // leftIcon: const Icon(Icons.insights_rounded, color: Colors.white),
                headerBackgroundColor: Colors.white,
                headerBackgroundColorOpened: Colors.white,
                header: Text('Approved requests'),
                content: ListOfItems(),
                contentHorizontalPadding: 20,
                contentBorderWidth: 1,
                contentBorderColor: Colors.white,
                contentBorderRadius: 25,
              ),
            ],
          ),
        ],
      ),
    );
  }

  ListOfItems() {
    return SizedBox(
      height: 128,
      child: RequestListView,
    );
  }

  RequestListFromFirebase() {
    final RequestData = FirebaseFirestore.instance
        .collection('users')
        .where("ReceiverEmail", isEqualTo: _email)
        .snapshots();
    return StreamBuilder(
      stream: RequestData,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView(
          scrollDirection: Axis.horizontal,
          children: snapshot.data!.docs.map((document) {
            return Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 12)],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(12)),
                border: Border.all(color: Colors.black, width: 0.2),
              ),
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text("Sender - ${document['senderEmail']}"),
                  ),
                  Container(
                    child: Text(
                        "Start time - ${document['startTime_Hours']}:${document['startTime_Minutes']}"),
                  ),
                  Container(
                    child: Text(
                        "End time - ${document['endTime_Hours']}:${document['endTime_minutes']}"),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  void _refreshAction() {
    setState(() {
      RequestListView = RequestListFromFirebase();
    });
  }
}
