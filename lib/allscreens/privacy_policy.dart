import 'package:flut_app/allscreens/response_model_classes/privacy_policy_response.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class MyPrivacyPolicy extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new _MyPrivacyPolicyState();
  }
}

class PrivacyPolicyModel{
  List<PrivacyPolicyModelResponse> privacypolicylist;
  PrivacyPolicyModel({ required this.privacypolicylist});

  getTemsandCond() =>
      <PrivacyPolicyModelResponse>[
        PrivacyPolicyModelResponse(
            privacypolicyid: 1.00,
            privacypolicyquestion: 'privacy and policy',
            privacypolicyanswer: 'privacy and policy'
        ),
        PrivacyPolicyModelResponse(
            privacypolicyid: 2.00,
            privacypolicyquestion: 'privacy and policy2',
            privacypolicyanswer: 'privacy policy 2'
        ),
        PrivacyPolicyModelResponse(
            privacypolicyid: 3.00,
            privacypolicyquestion: 'privacy  and policy 3',
            privacypolicyanswer: 'privacy policy 3'
        )
      ];
}


class _MyPrivacyPolicyState extends State<MyPrivacyPolicy>{

  final _postsenderData = PrivacyPolicyModel(privacypolicylist: []);
  late List<PrivacyPolicyModelResponse> privacypolicylist;
  @override
  void initState() {
    super.initState();
    privacypolicylist =  _postsenderData.getTemsandCond();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:  Text('Privacy Policy'),),
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
                          privacypolicylist[position].privacypolicyquestion.toString(),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 12.0),
                        child: Text(
                          privacypolicylist[position].privacypolicyanswer,
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
        itemCount: privacypolicylist.length,
      ),
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty<PrivacyPolicyModelResponse>('senderDataItemslist', privacypolicylist));
  }

}
