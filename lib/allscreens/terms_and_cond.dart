import 'file:///D:/flutterapps/flut_app/lib/allscreens/response_model_classes/tems_and_condModel_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyTermsCond extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return new _MyTermsCondState();
  }
}


class TemsandCondModel{
  List<TemsandCondModelResponse> temsandCondItemslist;
  TemsandCondModel({ required this.temsandCondItemslist});

  getTemsandCond() =>
      <TemsandCondModelResponse>[
        TemsandCondModelResponse(
            termid: 1.00,
            termquestion: 'question1',
            termanswer: 'answersing'
        ),
        TemsandCondModelResponse(
            termid: 2.00,
            termquestion: 'question1',
            termanswer: 'answersing'
        ),
        TemsandCondModelResponse(
            termid: 3.00,
            termquestion: 'question1',
            termanswer: 'answersing'
        )
      ];
}


class _MyTermsCondState extends State<MyTermsCond>{

  final _postsenderData = TemsandCondModel(temsandCondItemslist: []);
  late List<TemsandCondModelResponse> temsandCondItemslist;
  @override
  void initState() {
    super.initState();
    temsandCondItemslist =  _postsenderData.getTemsandCond();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:  Text('Terms & Conditions'),),
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
                          temsandCondItemslist[position].termquestion.toString(),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(
                          temsandCondItemslist[position].termanswer,
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                    ],
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
        itemCount: temsandCondItemslist.length,
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<TemsandCondModelResponse>('senderDataItemslist', temsandCondItemslist));
  }

}