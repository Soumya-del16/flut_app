
class PrivacyPolicyModelResponse {
  final double privacypolicyid;
  final String privacypolicyquestion;
  final String privacypolicyanswer;


  PrivacyPolicyModelResponse({required this.privacypolicyid,required this.privacypolicyquestion,required this.privacypolicyanswer});

  factory PrivacyPolicyModelResponse.fromJson(Map<String, dynamic> json) {
    return new  PrivacyPolicyModelResponse(
      privacypolicyid: json['PRIVACYPOLICYID'],
      privacypolicyquestion: json['PRIVACYPOLICYQUESTION'],
      privacypolicyanswer : json['PRIVACYPOLICYANSWER'],
    );
  }
}