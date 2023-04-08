import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wifi_iot/wifi_iot.dart';

class NetworkPack extends StatefulWidget {
  const NetworkPack({Key? key}) : super(key: key);

  @override
  State<NetworkPack> createState() => _NetworkPackState();
}

class _NetworkPackState extends State<NetworkPack> {
  late List<WifiModel> allAvailableWifiList = [];

  Future<List<WifiNetwork>> loadAvailableWifiList() async {
    List<WifiNetwork> htResultNetwork;
    try {
      htResultNetwork = await WiFiForIoTPlugin.loadWifiList();
      for (var element in htResultNetwork) {
        setState(() {
          allAvailableWifiList.add(WifiModel(
              ssid: element.ssid!,
              //password: element.password! ?? '',
              bssid: element.bssid! ?? '',
          ));
        });
      }
    } on PlatformException {
      htResultNetwork = <WifiNetwork>[];
    }

    return htResultNetwork;
  }

  @override
  void initState() {
    loadAvailableWifiList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('kadjklfj'),
        leading: IconButton(
            onPressed: () {

            },
            icon: const Icon(Icons.add)),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: allAvailableWifiList.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 16.0,),
        itemBuilder: (BuildContext context, int index) {
          var _data = allAvailableWifiList[index];
          return ListTile(
            tileColor: Colors.lightBlue,
            title: Text(_data.ssid),
          );
        },
      ),
    );
  }
}

class WifiModel {
  final String ssid;
  //final String password;
  final String bssid;

  WifiModel({required this.ssid, required this.bssid });
}
