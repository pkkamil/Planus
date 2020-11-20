import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/checkBox.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';

class AddFlat extends StatelessWidget {

  //Apartment data controllers
  final flatNameController = TextEditingController();
  final localisationController = TextEditingController();
  final priceController = TextEditingController();
  final areaController = TextEditingController();
  final numberOfRoomsController = TextEditingController();
  final settlementDayController = TextEditingController();
  final settlementPeriodController = TextEditingController();

  //Media data controllers
  final coldWaterPriceController = TextEditingController();
  final hotWaterPriceController = TextEditingController();
  final heatingPriceController = TextEditingController();
  final gasPriceController = TextEditingController();
  final electricityPriceController = TextEditingController();
  final rubbishPriceController = TextEditingController();
  final internetPriceController = TextEditingController();
  final tvPriceController = TextEditingController();
  final phonePriceController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
              children: [Stack(
              children: [
                GoBackButton(
                  isLeft: false,
                  pop: true,
                ),
                Positioned(
                  top: 60,
                  left: 30,
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 24,
                      ),
                      children: [
                        TextSpan(text: "Utwórz "),
                        TextSpan(text: "mieszkanie", style: TextStyle(color: Colors.orange))
                      ]
                    ),
                  )
                ),
                Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: size.height*0.17),
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(
                            Icons.insert_photo_outlined, //inna
                            color: Colors.white,
                            size: 70,
                          ),
                        ),
                        SizedBox(height:size.height*0.02),
                        RoundedInput(
                          controller: flatNameController,
                          width: size.width*0.7,
                          placeholder: "Nazwa mieszkania",
                          icon: Icons.home,
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                        ),
                        RoundedInput(
                          controller: localisationController,
                          width: size.width*0.7,
                          placeholder: "Lokalizacja",
                          icon: Icons.gps_fixed,
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                        ),
                        RoundedInput(
                          controller: priceController,
                          width: size.width*0.7,
                          placeholder: "Cena wynajmu [zł]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.monetization_on, //inna
                        ),
                        RoundedInput(
                          controller: areaController,
                          width: size.width*0.7,
                          placeholder: "Powierzchnia [m2]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.crop_square, //inna
                        ),
                        RoundedInput(
                          controller: numberOfRoomsController,
                          width: size.width*0.7,
                          placeholder: "Liczba pokoi",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.airline_seat_individual_suite,
                        ),
                        RoundedInput(
                          controller: settlementDayController,
                          width: size.width*0.7,
                          placeholder: "Dzień rozliczenia",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.event,
                        ),
                        RoundedInput(
                          controller: settlementPeriodController,
                          width: size.width*0.7,
                          placeholder: "Okres rozliczenia [miesiące]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.date_range,
                        ),
                    ]
                  ),
                ),
              ]
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.grey[900],
                      fontSize: 24,
                    ),
                    children: [
                      TextSpan(text: "Opłaty za "),
                      TextSpan(text: "media", style: TextStyle(color: Colors.orange))
                    ]
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: Center(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RoundedInput(
                                    controller: coldWaterPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1m3 wody zimnej",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.opacity //inna
                                  ),
                                  RoundedInput(
                                    controller: hotWaterPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1m3 wody ciepłej",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.waves,
                                  ),
                                  RoundedInput(
                                    controller: heatingPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za ogrzewanie [roczna]",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.local_fire_department
                                  ),
                                  RoundedInput(
                                    controller: gasPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1kWh gazu",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                  ),
                                  RoundedInput(
                                    controller: electricityPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1kWh prądu",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.flash_on,
                                  ),
                                  RoundedInput(
                                    controller: rubbishPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za śmieci/os",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.delete, //inna
                                  ),
                                  RoundedInput(
                                    controller: internetPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za internet",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.router, //inna
                                  ),
                                  RoundedInput(
                                    controller: tvPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za telewizję",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.live_tv
                                  ),
                                  RoundedInput(
                                    controller: phonePriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za telefon",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.phone,
                                  ),
                                
                                ],
                              ),
                              Column(
                                children: [
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                  FlatCheckBox(),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: size.height*0.01),
                      RoundedButton(
                            text: "Utwórz mieszkanie",
                            textColor: Colors.white,
                            color: Colors.orange.withOpacity(0.95),
                            onPress: (){
                              //Navigator.popAndPushNamed(context, '/counter');
                            },
                            width: size.width*0.7
                      ),
                      SizedBox(height: size.height*0.05),
                    ],
                  ),
                ),
              )
            ]
          ),
      ),
    );
  }
}
