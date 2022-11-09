import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_app/controller/common/country_flag.dart';
import 'package:test_app/controller/constant/typograph.dart';
import 'package:test_app/controller/state/country_state.dart';
import 'package:test_app/view/onboard/onboard.dart';
import 'package:textfield_search/textfield_search.dart';
import '../../controller/api/api.dart';
import '../../controller/common/common_widgets.dart';
import '../../controller/common/country_tile.dart';
import '../../controller/constant/color.dart';

class CountryPicker extends StatefulWidget {
  const CountryPicker({Key? key}) : super(key: key);

  @override
  State<CountryPicker> createState() => _CountryPickerState();
}

class _CountryPickerState extends State<CountryPicker> {

  final CountryState _countryState = Get.put(CountryState());

  late List<CountryTile> _countryListDrop = [];
  TextEditingController searchFieldController = TextEditingController();

  Future<void> loadAllCountry() async {
    final countryData = await getCountryList();
    countryData['data']['data']['countries'].forEach((element) {
      String countryId = element['country_id'] ?? '';
      String countryName = element['country_name'] ?? '';
      String flagUrl = element['image'] ?? '';
      String phoneCode = element['phone_code'] ?? '';
      setState(() {
        _countryListDrop.add(CountryTile(
          countryName: countryName,
          flagUrl: flagUrl,
          phoneCode: phoneCode,
          onTap: () {
            _countryState.changeCountryData(countryName,phoneCode,flagUrl);
            // if(_countryState.selectedCountry != '' && _countryListDrop.isNotEmpty){
            //   countryDelete();
            // }
          },
        ));
      });
    });
    if(_countryState.selectedCountry != '' && _countryListDrop.isNotEmpty){
      Timer.periodic(Duration(seconds: 10), (timer) {
        setState(() {
          _countryListDrop.removeAt(0);
        });
      });
    }else{
      loadAllCountry();
    }
  }

  void countryDelete() {
    if (_countryListDrop.isNotEmpty) {
      Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          _countryListDrop.removeAt(0);
        });
      });
    } else {
      loadAllCountry();
    }
  }

  @override
  void initState() {
    loadAllCountry();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<CountryState>(builder: (_){
            return Scaffold(
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    _searchField(context),
                    _countryState.selectedCountry == ''
                        ? const SizedBox.shrink()
                        : Container(
                      width: double.infinity,
                      color: deepAss,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                CountryFlag(flagUrl: _countryState.imageUrl),
                                primaryHorizontalSpacer,
                                Text(
                                  _countryState.selectedCountry,
                                  style: sixteenBlack,
                                ),
                              ],
                            ),
                            Text(
                              'Selected',
                              style: sixteenBlack,
                            )
                          ],
                        ),
                      ),
                    ),
                    _countryList(context),
                  ],
                ),
              ),
              floatingActionButton: _countryState.selectedCountry == '' ? SizedBox.shrink() : SizedBox(
                height: 60,
                width: 220,
                child: FloatingActionButton(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.0)),
                  onPressed: () {
                    Get.to(() => const OnBoard());
                  },
                  child: Text(
                    'Continue',
                    style: sixteenWhite,
                  ),
                ),
              ),
              floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
            );
      }),
    );
  }

  Widget _searchField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          primaryVerticalSpacer,
          Row(
            children: [
              const Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              const SizedBox(
                width: 8.0,
              ),
              Text(
                'Search Country',
                style: sixteenBlack,
              ),
            ],
          ),
          primaryVerticalSpacer,
          TextFieldSearch(
            initialList: _countryListDrop,
            controller: searchFieldController,
            label: '',
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
          ),
        ],
      ),
    );
  }

  Widget _countryList(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Container(
      height: height,
      width: double.infinity,
      child: ListView.separated(
        itemCount: _countryListDrop.length,
        separatorBuilder: (BuildContext context, int index) =>
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Divider(),
            ),
        itemBuilder: (BuildContext context, int index) {
          return _countryListDrop[index];
        },
      ),
    );
  }

}
