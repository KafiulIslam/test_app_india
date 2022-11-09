import 'package:flutter/material.dart';
import 'package:test_app/controller/common/common_widgets.dart';
import 'package:test_app/controller/common/country_flag.dart';
import 'package:test_app/controller/constant/color.dart';
import '../constant/typograph.dart';

class CountryTile extends StatelessWidget {
  final String countryName, flagUrl, phoneCode;
  final VoidCallback? onTap;

  const CountryTile(
      {Key? key, required this.countryName, required this.flagUrl, required this.phoneCode,required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CountryFlag(flagUrl: flagUrl),
               primaryHorizontalSpacer,
                Container(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: Text(
                    countryName,
                    overflow: TextOverflow.ellipsis,
                    style: sixteenBlack,
                  ),
                ),
              ],
            ),
            Text(
              '( $phoneCode )',
              style: sixteenDeepAss,
            )
          ],
        ),
      ),
    );
  }
}
