
class SenderDataResponse{
 final double notifyid;
  final String notifyDescription;
  final String notifyTime;



 SenderDataResponse({required this.notifyid,required this.notifyDescription,required this.notifyTime});

  factory SenderDataResponse.fromJson(Map<String, dynamic> json) {
    return new  SenderDataResponse(
      notifyid: json['NOTIFYID'],
      notifyDescription: json['NOTIFYDESCR'],
      notifyTime : json['NOTIFYTIME'],
    );
  }

}