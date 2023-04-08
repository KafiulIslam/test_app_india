import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:test_app/controller/common/country_flag.dart';
import 'package:test_app/controller/constant/typograph.dart';
import 'package:test_app/controller/state/country_state.dart';
import 'package:test_app/model/country_model.dart';
import 'package:test_app/view/onboard/onboard.dart';
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
  TextEditingController searchFieldController = TextEditingController();

  Future<void> loadAllCountry() async {
    final countryData = await getCountryList();
    countryData['data']['data']['countries'].forEach((element) {
      setState(() {
        _allCountryList.add(CountryList.fromJson(element));
      });
    });
    if (_countryState.selectedCountry != '' && _countryState.isNotPulled == true) {
      Timer.periodic(const Duration(seconds: 10), (timer) {
        if (_allCountryList.isNotEmpty) {
          setState(() {
            _allCountryList.removeAt(0);
          });
        } else {
          loadAllCountry();
        }
      });
    }else{
      setState(() {
        _allCountryList.removeWhere(
                (element) => element.countryName == 'United Kingdom');
      });
    }
  }

  onSearchTextChanged(String text) async {
    _searchCountryList.clear();
    if (text.isEmpty) {
     // setState(() {});
      return;
    }

    _allCountryList.forEach((country) {
      if (country.countryName.contains(text) ||
          country.phoneCode.contains(text)) {
        _searchCountryList.add(country);
      }
    });

  //  setState(() {});
  }

  @override
  void initState() {
    loadAllCountry();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<CountryState>(builder: (_) {
        return Scaffold(
          body: RefreshIndicator(
            onRefresh: () => Future.sync(() async {
              _countryState.changePullStatus();
              await loadAllCountry();
            }),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          floatingActionButton: _countryState.selectedCountry == ''
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 60,
                  width: 220,
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    onPressed: () {
                      Get.to(() => const OnBoard());
                      _allCountryList.clear();
                      _searchCountryList.clear();
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
              IconButton(
                onPressed: () {
                    Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
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
          TextFormField(
            onChanged: onSearchTextChanged,
            controller: searchFieldController,
            decoration: InputDecoration(
              filled: true,
              fillColor: trans,
              contentPadding: const EdgeInsets.all(16),
              hintText: 'Search',
              hintStyle: fourteenDeepAss,
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.cancel,
                  color: borderColor,
                ),
                onPressed: () {
                  searchFieldController.clear();
                  onSearchTextChanged('');
                },
              ),
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
    return Expanded(
        child: _searchCountryList.isNotEmpty ||
                searchFieldController.text.isNotEmpty
            ? ListView.separated(
                itemCount: _searchCountryList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                itemBuilder: (_, i) {
                  //  var data = _countryListDrop[index];
                  return CountryTile(
                    countryName: _searchCountryList[i].countryName,
                    flagUrl: _searchCountryList[i].flag,
                    phoneCode: _searchCountryList[i].phoneCode,
                    onTap: () {
                      _countryState.changeCountryData(
                          _searchCountryList[i].countryName,
                          _searchCountryList[i].phoneCode,
                          _searchCountryList[i].flag);
                    },
                  );
                },
              )
            : ListView.separated(
                itemCount: _allCountryList.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Divider(),
                ),
                itemBuilder: (_, i) {
                  //  var data = _countryListDrop[index];
                  return CountryTile(
                    countryName: _allCountryList[i].countryName,
                    flagUrl: _allCountryList[i].flag,
                    phoneCode: _allCountryList[i].phoneCode,
                    onTap: () {
                      _countryState.changeCountryData(
                          _allCountryList[i].countryName,
                          _allCountryList[i].phoneCode,
                          _allCountryList[i].flag);
                    },
                  );
                },
              ));
  }

}

List<CountryList> _searchCountryList = [];

List<CountryList> _allCountryList = [];
