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
  final _formKey = GlobalKey<FormBuilderState>();
  late bool _isLoading = false;

  @override
  void initState() {
    //loadAllCountry();
    super.initState();
  }

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
                      _countryState.selectedCountry == '' ? _nullField(context) : _countryField(context)
                      // FormBuilder(
                      //   key: _formKey,
                      //   enabled: !_isLoading,
                      //   autovalidateMode: AutovalidateMode.disabled,
                      //   onChanged: () {
                      //     _formKey.currentState!.save();
                      //   },
                      //   child: FormBuilderSearchableDropdown<String>(
                      //     popupProps: const PopupProps.menu(showSearchBox: true),
                      //     dropdownSearchDecoration: InputDecoration(
                      //        hintText: 'Search',
                      //       hintStyle: fourteenAss,
                      //     ),
                      //     name: 'country_list',
                      //     filterFn: (country, filter) =>
                      //         country.toLowerCase().contains(filter.toLowerCase()),
                      //     decoration: InputDecoration(
                      //       filled: true,
                      //       fillColor: white,
                      //       contentPadding: const EdgeInsets.all(16),
                      //        hintText: 'Search',
                      //        hintStyle: fourteenDeepAss,
                      //       focusedBorder: outlineBorder,
                      //       enabledBorder: outlineBorder,
                      //       focusColor: Colors.blue,
                      //     ),
                      //     validator: FormBuilderValidators.compose(
                      //         [FormBuilderValidators.required()]),
                      //     items: _countryListDrop,
                      //     valueTransformer: (val) => val,
                      //   ),
                      // ),
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

  Widget _nullField(BuildContext context) {
    return  GestureDetector(
      onTap: (){
Get.to(()=>const CountryPicker());
      },
      child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                  color:  borderColor)),

          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: const [
                Text(
                  'Search',
                  style: fourteenDeepAss,
                ),
                Text(
                  '',
                ),
              ],
            ),
          )
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
              RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text:  _countryState.selectedCountry, style: sixteenBlack),
                    TextSpan(text: ' (${_countryState.phoneCode})',style: sixteenDeepAss),
                  ],
                ),
              )
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
