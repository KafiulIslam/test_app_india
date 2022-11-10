import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:test_app/controller/common/country_flag.dart';
import '../controller/api/api.dart';
import '../model/country_model.dart';

class TrialPage extends StatefulWidget {
  @override
  _TrialPageState createState() => new _TrialPageState();
}

class _TrialPageState extends State<TrialPage> {
  TextEditingController controller = new TextEditingController();

  // Get json result and convert it to model. Then add
  // Future<Null> getUserDetails() async {
  //   Map<String, dynamic> countryData = await getCountryList();
  //   // final Uri uri = 'https://vipankumar.com/SmartHealth/api/getCountries' as Uri;
  //   // final response = await http.get(uri);
  //   // final responseJson = json.decode(response.body);
  //   // print(responseJson);
  //
  //   setState(() {
  //     for (Map<String, dynamic> user in countryData) {
  //       _userDetails.add(UserDetails.fromJson(user));
  //     }
  //
  //   });
  // }

 // late List<CountryModel> _countryListDrop = [];
  Future<void> loadAllCountry() async {
    final countryData = await getCountryList();
    print(countryData);
    countryData['data']['data']['countries'].forEach((element) {
      String countryId = element['country_id'] ?? '';
      String countryName = element['country_name'] ?? '';
      String flagUrl = element['image'] ?? '';
      String phoneCode = element['phone_code'] ?? '';
      setState(() {
        _userDetails.add(UserDetails.fromJson(element));
       // _countryListDrop.add(UserDetails('1',countryName, flagUrl, phoneCode));
      });
    });
  }

  @override
  void initState() {
    super.initState();
   // getUserDetails();
   loadAllCountry();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:   Column(
        children: <Widget>[
          SizedBox(height: 52,),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
                suffixIcon: IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                  controller.clear();
                  onSearchTextChanged('');
                },),
                hintText: 'Search', border: InputBorder.none),
            onChanged: onSearchTextChanged,

          ),
            Expanded(
            child: _searchResult.length != 0 || controller.text.isNotEmpty
                ?   ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, i) {
                return   Card(
                  margin: const EdgeInsets.all(0.0),
                  child:   ListTile(
                    leading: CountryFlag(flagUrl: _searchResult[i].flag),
                    title:   Text('${_searchResult[i].countryName} ${_searchResult[i].phoneCode}'),
                  ),
                );
              },
            )
                :   ListView.builder(
              itemCount: _userDetails.length,
              itemBuilder: (context, index) {
                return   Card(
                  child:   ListTile(
                    leading: CountryFlag(flagUrl: _userDetails[index].flag),
                    title:   Text(_userDetails[index].countryName + ' ' + _userDetails[index].phoneCode),
                  ),
                  margin: const EdgeInsets.all(0.0),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    _userDetails.forEach((userDetail) {
      if (userDetail.countryName.contains(text) || userDetail.phoneCode.contains(text))
        _searchResult.add(userDetail);
    });

    setState(() {});
  }
}

List<UserDetails> _searchResult = [];

List<UserDetails> _userDetails = [];

final String url = 'https://jsonplaceholder.typicode.com/users';
class UserDetails {

  final String id, countryName, flag, phoneCode;
  UserDetails({required this.id,required this.countryName, required this.flag, required this.phoneCode,});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      id: json['country_id'],
      countryName: json['country_name'],
      phoneCode: json['phone_code'], flag: json['image'],
    );
  }

}