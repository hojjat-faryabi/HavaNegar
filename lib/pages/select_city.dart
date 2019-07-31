import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SelectCity extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SelectCityState();
}

class SelectCityState extends State<SelectCity> {
  dynamic _groupValue = 0;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    // TODO: implement build
    return Scaffold(
      body: Container(
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
                      enabled: _groupValue == 0
                          ? true
                          : false,
                      maxLines: 1,
                      minLines: 1,
                      keyboardType: TextInputType.numberWithOptions(decimal: false, signed: false),
                      textAlign: TextAlign.center,
                      cursorColor: Colors.yellow[600],
                      decoration: InputDecoration(
                          hintText: "نام شهر",
                          border: OutlineInputBorder(
                            gapPadding: 0,
                            borderSide: BorderSide(color: Colors.yellow[600]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: GestureDetector(
                            child: Container(
                              child: Icon(Icons.search, color: Colors.black,),
                              decoration: BoxDecoration(
                                color: _groupValue == 0
                                      ? Colors.yellow[600]
                                      : Colors.grey,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(0),
                                    bottomLeft: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(0)
                                )
                              ),
                            ),
                            onTap: (){
                              print("clicked!");
                            },
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 5)

                      ),
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
                          color: _groupValue == 1 ? Colors.yellow[500] : Colors.grey,
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
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
