import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:test_app/controller/constant/typograph.dart';

import '../constant/color.dart';

class ContentColumn extends StatelessWidget {
  final String iconPath, title, number;
  const ContentColumn({Key? key, required this.title, required this.number, required this.iconPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SvgPicture.asset(iconPath),
        SizedBox(height: 16,),
        Text(  title,style:  twelveAss),
        Text(number,style: fourteenWhite),
    ],);
  }
}
