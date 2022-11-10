import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_app/controller/common/country_flag.dart';
import 'package:test_app/controller/constant/color.dart';
import 'package:test_app/controller/constant/typograph.dart';
import 'package:test_app/controller/state/country_state.dart';
import 'package:test_app/view/country_picker/country_picker.dart';
import '../../controller/api/api.dart';
import '../../controller/common/common_widgets.dart';
import '../../controller/common/content_colum.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {

  final CountryState _countryState = Get.put(CountryState());

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        body: SingleChildScrollView(
          child: GetBuilder<CountryState>(builder: (_){
            return Column(
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
                                IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.white,
                                    )),
                                SvgPicture.asset(
                                  'assets/svgs/Share.svg',
                                  color: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height / 7.5,
                            ),
                            _profile(context),
                            SizedBox(
                              height: height / 14,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                ContentColumn(
                                  iconPath: 'assets/svgs/Alert.svg',
                                  title: 'Alert',
                                  number: '6',
                                ),
                                ContentColumn(
                                  iconPath: 'assets/svgs/Places.svg',
                                  title: 'Places',
                                  number: '40',
                                ),
                                ContentColumn(
                                  iconPath: 'assets/svgs/Shots.svg',
                                  title: 'Shots',
                                  number: '60',
                                ),
                                ContentColumn(
                                  iconPath: 'assets/svgs/Friends.svg',
                                  title: 'Friends',
                                  number: '60',
                                ),
                              ],
                            )
                          ],
                        ),
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
                   //   _countryState.selectedCountry == '' ? _nullField(context) : _countryField(context)
                    _inputField(context),
                    ],
                  ),
                ),
              ],
            );
          }),
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
          child: Image.asset(
            'assets/images/Profile.png',
            fit: BoxFit.cover,
          ),
        ),
        Text('Lucile Barrett', style: sixteenWhite),
        Text(
          'New York, NY',
          style: fourteenWhite,
        )
      ],
    );
  }

  Widget _inputField(BuildContext context) {
    return TextFormField(
      onTap: (){
        Get.to(()=> const CountryPicker());
      },
     initialValue: _countryState.selectedCountry,
      readOnly:  true,
      decoration: InputDecoration(
        filled: true,
        fillColor: trans,
        contentPadding: const EdgeInsets.all(16.0),
        hintText: 'Search',
        hintStyle: fourteenDeepAss,
        prefixIcon: _countryState.selectedCountry == '' ? SizedBox.shrink() : CountryFlag(flagUrl: _countryState.imageUrl),
        suffixIcon: _countryState.selectedCountry == '' ? SizedBox.shrink() : TextButton(
            onPressed: () {
              Get.to(()=> const CountryPicker());
            },
            child: Text(
              'Edit',
              style: sixteenBlack,
            )),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: _countryState.selectedCountry == '' ? borderColor : trans),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: _countryState.selectedCountry == '' ? borderColor : trans),
        ),
        focusColor: Colors.blue,
      ),
    );
  }

  Widget _countryField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CountryFlag(flagUrl: _countryState.imageUrl),
              primaryHorizontalSpacer,
             Container(width: MediaQuery.of(context).size.width / 1.8,child:  RichText(
               text: TextSpan(
                 children: <TextSpan>[
                   TextSpan(text:  _countryState.selectedCountry, style: sixteenBlack),
                   TextSpan(text: ' (${_countryState.phoneCode})',style: sixteenDeepAss),
                 ],
               ),
             ),)
            ],
          ),
          TextButton(
              onPressed: () {
                Get.to(()=> const CountryPicker());
              },
              child: Text(
                'Edit',
                style: sixteenBlack,
              ))
        ],
      ),
    );
  }
  
}

