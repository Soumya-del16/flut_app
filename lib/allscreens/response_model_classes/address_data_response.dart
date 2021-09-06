class AddressDataResponse{
  late final String id;
  late final String addressType;
  late final String addressline1;
  late final String addressline2;
  late  final String addresslandmark;
  late final String addresscity;
  late final String addressdistict;
  late final String addresscountry;
  late final String addressstate;
  late final String addresspincode;
  late final String addressmobile;


  AddressDataResponse({required this.id,required this.addressType,required this.addressline1,required this.addressline2,
    required this.addresslandmark,required this.addresscity,required this.addressdistict, required this.addressstate,
    required this.addresscountry,required this.addresspincode,required this.addressmobile});

  factory AddressDataResponse.fromJson(Map<String, dynamic> json) {
    return new  AddressDataResponse(
        id: json['id'],
        addressType: json['type'],
        addressline1 : json['addressline1'],
        addressline2: json['addressline2'],
        addresslandmark: json['landmark'],
        addresscity: json['city'],
        addressdistict: json['district'],
        addressstate : json['state'],
        addresscountry: json['country'],
        addresspincode: json['pincode'],
      addressmobile: json['mobileno'],
    );
  }

}