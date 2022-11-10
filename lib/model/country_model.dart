class CountryList {

  final String id, countryName, flag, phoneCode;
  CountryList({required this.id,required this.countryName, required this.flag, required this.phoneCode,});

  factory CountryList.fromJson(Map<String, dynamic> json) {
    return CountryList(
      id: json['country_id'],
      countryName: json['country_name'],
      phoneCode: json['phone_code'], flag: json['image'],
    );
  }

}