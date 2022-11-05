import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:test_app/controller/constant/color.dart';
import 'package:test_app/controller/constant/typograph.dart';
import '../../controller/api/api.dart';
import '../../controller/common/common_widgets.dart';
import '../../controller/common/content_colum.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  final _formKey = GlobalKey<FormBuilderState>();
  late bool _isLoading = false;
  late List<String> _countryListDrop = [];

  Future<void> loadAllCountry() async {
    final countryData = await getCountryList();
    countryData['data']['data']['countries'].forEach((element) {
      String countryId = element['country_id'] ?? '';
      String countryName = element['country_name'] ?? '';
      setState(() {
        _countryListDrop.add(countryName);
      });
    });
    countryDelete();
  }

  void countryDelete (){
    if(_countryListDrop.isNotEmpty){
      Timer.periodic(Duration(seconds: 10), (timer){
      setState(() {
        _countryListDrop.removeAt(0);
      });
        });
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('All country is deleted from the country list!'),
      ));
    }
  }

  @override
  void initState() {
    loadAllCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   final double height =  MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: height / 1.5,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/images/back.png',
                      fit: BoxFit.cover,
                      height: height / 1.5,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                         children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(onPressed: (){}, icon: const Icon(Icons.clear,color: Colors.white,)),
                              SvgPicture.asset('assets/svgs/Share.svg',color: Colors.white,),
                            ],),
                           SizedBox(height: height / 7.5,),
                          _profile(context),
                           SizedBox(height: height / 14,),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              ContentColumn(iconPath: 'assets/svgs/Alert.svg',title: 'Alert',number: '6',),
                              ContentColumn(iconPath: 'assets/svgs/Places.svg',title: 'Places',number: '40',),
                              ContentColumn(iconPath: 'assets/svgs/Shots.svg',title: 'Shots',number: '60',),
                              ContentColumn(iconPath: 'assets/svgs/Friends.svg',title: 'Friends',number: '60',),
                            ],)
                        ],),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                      Text(
                      'Select Country',
                      style: sixteenBlack,
                    ),
                    primaryVerticalSpacer,
                    FormBuilder(
                      key: _formKey,
                      enabled: !_isLoading,
                      autovalidateMode: AutovalidateMode.disabled,
                      onChanged: () {
                        _formKey.currentState!.save();
                      },
                      child: FormBuilderSearchableDropdown<String>(
                        popupProps: const PopupProps.menu(showSearchBox: true),
                        dropdownSearchDecoration: InputDecoration(
                           hintText: 'Search',
                          hintStyle: fourteenAss,
                        ),
                        name: 'country_list',
                        filterFn: (country, filter) =>
                            country.toLowerCase().contains(filter.toLowerCase()),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: white,
                          contentPadding: const EdgeInsets.all(16),
                           hintText: 'Search',
                           hintStyle: fourteenDeepAss,
                          focusedBorder: outlineBorder,
                          enabledBorder: outlineBorder,
                          focusColor: Colors.blue,
                        ),
                        validator: FormBuilderValidators.compose(
                            [FormBuilderValidators.required()]),
                        items: _countryListDrop,
                        valueTransformer: (val) => val,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 Widget _profile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
      CircleAvatar(
        backgroundColor: trans,
        radius: 50,
        child: Image.asset('assets/images/Profile.png',fit: BoxFit.cover,),
      ),
        Text('Lucile Barrett',style: sixteenWhite),
        Text('New York, NY',style: fourteenWhite,)
    ],);
 }

}


