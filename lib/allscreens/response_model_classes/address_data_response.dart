class AddressDataResponse{
  late final int addressid;
  late final String addressType;
  late final String addressline1;
  late final String addressline2;
  late  final String addresslandmark;
  late final String addresscity;
  late final String addressstate;
  late final String addresspincode;



  AddressDataResponse({required this.addressid,required this.addressType,required this.addressline1,required this.addressline2,
    required this.addresslandmark,required this.addresscity,required this.addressstate,required this.addresspincode,});

  factory AddressDataResponse.fromJson(Map<String, dynamic> json) {
    return new  AddressDataResponse(
        addressid: json['ADDRESSID'],
        addressType: json['ADDRESSTYPE'],
        addressline1 : json['ADDRESSLINE1'],
        addressline2: json['ADDRESSLINE2'],
        addresslandmark: json['ADDRESSLANDMARK'],
        addresscity: json['ADDRESSCITY'],
        addressstate : json['ADDRESSSTATE'],
        addresspincode: json['ADDRESSPINCODE']
    );
  }

}