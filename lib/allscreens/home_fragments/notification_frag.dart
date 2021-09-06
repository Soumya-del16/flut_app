
import 'package:flut_app/allscreens/response_model_classes/notification_data_response.dart';
import 'package:flut_app/allscreens/seperate_classes/clip_board_copy_paste.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyNotificationRecyclerClass extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _MyNotificationRecyclerClassState();
  }
}

class SenderDataViewModel{
  List<SenderDataResponse> senderDataItemslist;
  SenderDataViewModel({ required this.senderDataItemslist});

  getSenderData() =>
      <SenderDataResponse>[
        SenderDataResponse(
          notifyid: 1.00,
          notifyDescription: 'notification1',
          notifyTime: '1:00 pm'
        ),
        SenderDataResponse(
            notifyid: 2.00,
            notifyDescription: 'notification2',
            notifyTime: '2:00 pm'
        ),
        SenderDataResponse(
            notifyid: 3.00,
            notifyDescription: 'notification3',
            notifyTime: '3:00 pm'
        )
      ];
}


class _MyNotificationRecyclerClassState extends State<MyNotificationRecyclerClass>{

  final _postsenderData = SenderDataViewModel(senderDataItemslist: []);
  late List<SenderDataResponse> senderDataItemslist;
  @override
  void initState() {
    super.initState();
    senderDataItemslist =  _postsenderData.getSenderData();
  }

  @override
  Widget build(BuildContext context) {

    void handleClick(String value) {
      switch (value) {
        case 'Logout':
          Navigator.of(context).pop();
          break;
        case 'Settings':

        // Navigator.push(context,MaterialPageRoute(builder: (context) => HomeCopyPage());
          break;
        case 'Copy text' :
         // onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeCopyPage(),
              ),
            );
         // };
          break;
      }
    }



    return Scaffold(
      appBar:  AppBar(
        title: Text('Notification'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings','Copy text'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Card(
              color: Theme.of(context).cardColor,
          //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10.0),
          top: Radius.circular(2.0)),
          ),
            child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 12.0, 12.0, 6.0),
                        child: Text(
                          senderDataItemslist[position].notifyid.toString(),
                          style: TextStyle(
                              fontSize: 22.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(
                          senderDataItemslist[position].notifyDescription,
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          senderDataItemslist[position].notifyTime,
                          style: TextStyle(color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.notifications,
                            size: 35.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
             /* Divider(
                height: 2.0,
                color: Colors.grey,
              )*/
            ],
          ),
          );

        },
        itemCount: senderDataItemslist.length,
      ),
    );

  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<SenderDataResponse>('senderDataItemslist', senderDataItemslist));
  }

}

