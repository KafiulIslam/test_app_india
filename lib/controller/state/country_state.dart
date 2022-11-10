import 'package:get/get.dart';
import 'package:test_app/model/country_model.dart';

class CountryState extends GetxController{

  RxList<CountryModel> countryListDrop = (List<CountryModel>.of([])).obs;
  // List<CountryModel> countryListDrop = [].obs;
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