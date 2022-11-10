import 'package:get/get.dart';

class CountryState extends GetxController{

  String _countryName = '';
  String get selectedCountry => _countryName;

  String _phoneCode = '';
  String get phoneCode => _phoneCode;

  String _imageUrl = '';
  String get imageUrl => _imageUrl;

  void changeCountryData (String name, phone, image){
    _countryName = name;
    update();
    _phoneCode = phone;
    update();
    _imageUrl = image;
    update();
  }

  bool _isNotPulled = true;
  bool get isNotPulled => _isNotPulled;

  void changePullStatus (){
    _isNotPulled = !_isNotPulled;
    var index = 0;
    if (!_isNotPulled) {index = 1;}
    update();
    print('pull value is $_isNotPulled');
  }

}