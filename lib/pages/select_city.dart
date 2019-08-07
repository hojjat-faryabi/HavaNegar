import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hava_negar/services/city_service.dart';
import 'package:hava_negar/utility/initial_data.dart';

import '../initial.dart';

class SelectCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectCityState();
}

class SelectCityState extends State<SelectCity> {
  dynamic _groupValue = 0;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController controller = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      key: this.scaffoldKey,
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (b, i) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 35),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/images/light/big_sun.svg",
                      width: screenSize.width / 2,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12),
                  child: Text(
                    "هــوانــگـار",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      RadioListTile(
                          selected: _groupValue == 0 ? true : false,
                          activeColor: Colors.blue,
                          title: Text("براساس نام شهر:"),
                          value: 0,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = value;
                            });
                          }),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        child: TextField(
                          controller: controller,
                          autocorrect: false,
                          enabled: _groupValue == 0 ? true : false,
                          maxLines: 1,
                          minLines: 1,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          cursorColor: Colors.yellow[600],
                          decoration: InputDecoration(
                              hintText: "نام شهر",
                              border: OutlineInputBorder(
                                gapPadding: 0,
                                borderSide:
                                    BorderSide(color: Colors.yellow[600]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              suffixIcon: GestureDetector(
                                child: Container(
                                  child: Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  decoration: BoxDecoration(
                                      color: _groupValue == 0
                                          ? Colors.yellow[600]
                                          : Colors.grey,
                                      borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(0),
                                          bottomLeft: Radius.circular(10),
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(0))),
                                ),
                                onTap: () {
                                  if (this.controller.text != "" &&
                                      this.controller.text != null) {
                                    _getCityLocation(
                                        this.controller.text, context);
                                    showDialog(
                                      context: context,
                                      builder: (_) {
                                        return AlertDialog(
                                          content: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              CircularProgressIndicator(
                                                strokeWidth: 5,
                                              ),
                                            ],
                                          )
                                        );
                                      },
                                      barrierDismissible: false,
                                    );
                                    FocusScope.of(context)
                                        .requestFocus(new FocusNode());
                                    //print(this.controller.text);
                                  } else {
                                    print("empety input!!");
                                  }
                                },
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 0, vertical: 5)),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    children: <Widget>[
                      RadioListTile(
                          activeColor: Colors.blue,
                          selected: _groupValue == 1 ? true : false,
                          title: Text("براساس موقعیت مکانی:"),
                          value: 1,
                          groupValue: _groupValue,
                          onChanged: (value) {
                            setState(() {
                              _groupValue = 1;
                            });
                          }),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 50),
                          height: 35,
                          decoration: BoxDecoration(
                              color: _groupValue == 1
                                  ? Colors.yellow[500]
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: Icon(Icons.my_location),
                          ),
                        ),
                        onTap: _groupValue == 1
                            ? () {
                                print("gps");
                              }
                            : null,
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  _getCityLocation(String city, BuildContext context) async {
    var locationData;
    locationData = await CityService.getCityLocation(location: city);

    //Future.delayed(Duration(seconds: 3));
//    print(await CityService.getCityLocation(location: city));

    setState(() {
      Navigator.of(context).pop();
      if (locationData == null) {
        print("wrong!!");
        this.scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(
              "شهر وارد شده یافت نشد!",
              style: TextStyle(fontFamily: "Vazir"),
            )));
      } else {
        this.scaffoldKey.currentState.showSnackBar(SnackBar(
                content: Text(
              "شهر : " +
                  city +
                  "\n طول جغرافیایی : " +
                  locationData["results"][0]["geometry"]["lng"].toString() +
                  " \n عرض جغرافیایی : " +
                  locationData["results"][0]["geometry"]["lat"].toString(),
              style: TextStyle(fontFamily: "Vazir"),
            )));
        HomePageInitialData.latt = locationData["results"][0]["geometry"]["lat"].toString();
        HomePageInitialData.longt = locationData["results"][0]["geometry"]["lng"].toString();
        HomePageInitialData.cityName = locationData["results"][0]["components"]["city"].toString();

        // and this section we most clear all old data in initial_data.dart

        Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Initial()) ,
        );
      }
    });
  }
}
