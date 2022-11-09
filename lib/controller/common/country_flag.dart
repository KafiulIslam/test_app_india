import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../constant/color.dart';

class CountryFlag extends StatelessWidget {
  final String flagUrl;
  const CountryFlag({Key? key, required this.flagUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 15.0,
      backgroundColor: trans,
      child: CachedNetworkImage(
        imageUrl: flagUrl,
        imageBuilder: (context, imageProvider) => Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: imageProvider, fit: BoxFit.cover),
          ),
        ),
        placeholder: (context, url) => const CircularProgressIndicator(color: Colors.blue,),
        errorWidget: (context, url, error) =>  const Icon(Icons.flag,color: iconColor,),
      ),
    );
  }
}
