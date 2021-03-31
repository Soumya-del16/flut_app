import 'package:flut_app/allscreens/home_fragments/notification_data_response.dart';
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

    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, position) {
          return Column(
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
                          "5m",
                          style: TextStyle(color: Colors.grey),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.star_border,
                            size: 35.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(
                height: 2.0,
                color: Colors.grey,
              )
            ],
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

