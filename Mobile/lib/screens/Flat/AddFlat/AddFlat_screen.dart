import 'dart:convert' as convert;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/checkBox.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';
import 'package:planus/screens/Flat/Panel/screens/Counters/InitialCounters_screen.dart';
import 'package:planus/screens/Flat/Panel/screens/Counters/InsertCounters_screen.dart';
import 'package:planus/screens/Flat/Panel/screens/payments.dart';
import 'package:planus/services/apiController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

File image;
int owner_id;
bool isLoading = false;

class AddFlat extends StatefulWidget {
  final int user_id;
  AddFlat(this.user_id);

  @override
  _AddFlatState createState() => _AddFlatState();
}

final flatNameController = TextEditingController();
final localisationController = TextEditingController();
final priceController = TextEditingController();
final areaController = TextEditingController();
final numberOfRoomsController = TextEditingController();
final settlementDayController = TextEditingController();
final settlementPeriodController = TextEditingController();

final coldWaterPriceController = TextEditingController();
final hotWaterPriceController = TextEditingController();
final heatingPriceController = TextEditingController();
final gasPriceController = TextEditingController();
final electricityPriceController = TextEditingController();
final rubbishPriceController = TextEditingController();
final internetPriceController = TextEditingController();
final tvPriceController = TextEditingController();
final phonePriceController = TextEditingController();


final _scaffoldKey = GlobalKey<ScaffoldState>();

class _AddFlatState extends State<AddFlat> {
  bool isColdWater = false;
  bool isHotWater = false;
  bool isHeating = false;
  bool isGas = false;
  bool isElectricity = false;
  bool isRubbish = false;
  bool isInternet = false;
  bool isTv = false;
  bool isPhone = false;

  @override
  void initState() {
    setState(() {
      owner_id = widget.user_id;
    });
    //print('#######');
    //print(owner_id);
    //print('#######');
    super.initState();
  }

  void getImage(bool camera) async {
    final picker = new ImagePicker();
    var pickedFile;
    if(camera){
      pickedFile = await picker.getImage(source: ImageSource.camera);
    }else{
      pickedFile = await picker.getImage(source: ImageSource.gallery);
    }
    setState(() {
      image = File(pickedFile.path);
    });
  }


  @override
  Widget build(BuildContext context) {
    sendData() async{
      setState(() {
        isLoading = true;
      });
      try{
        Map data = {
          'name': flatNameController.text,
          'price': priceController.text,
          'area': areaController.text,
          'rooms': numberOfRoomsController.text,
          'localization': localisationController.text,
          'settlement_day': settlementDayController.text,
          'billing_period': settlementPeriodController.text,

          'cold_water': coldWaterPriceController.text=='' ? null : coldWaterPriceController.text,
          'hot_water': hotWaterPriceController.text=='' ? null : hotWaterPriceController.text,
          'heating':heatingPriceController.text=='' ? null : heatingPriceController.text,
          'gas':gasPriceController.text=='' ? null : gasPriceController.text,
          'electricity': electricityPriceController.text=='' ? null : electricityPriceController.text,
          'rubbish': rubbishPriceController.text=='' ?null: rubbishPriceController.text,
          'internet': internetPriceController.text=='' ? null : internetPriceController.text,
          'tv': tvPriceController.text=='' ? null : tvPriceController.text,
          'phone': phonePriceController.text=='' ? null : phonePriceController.text,
          'user_id': owner_id,
          'image': convert.base64Encode(image.readAsBytesSync())
        };
        //print(data);
        var api = new Api();
        var response = await api.createFlat(data);
        //print('#####');
        print(response);
        if(response['message']=='OK'){
          isLoading=false;
          Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
          Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => InitialCounters(widget.user_id,response['apartment_id'])));
        }else{
          setState(() {
            isLoading=false;
          });
          _scaffoldKey.currentState.showSnackBar(
            SnackBar(
              backgroundColor: Colors.orange,
                content: Text(
                  response['errors'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18
                  ),
                )
            )
          );
        }
      }catch(e){
        print(e);
        setState(() {
            isLoading=false;
        });
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: Colors.orange,
              content: Text(
                'Musisz wypełnić poprawnie wszystkie pola związane z danymi mieszkania, zdjęcie również jest wymagane',
                 textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18
                ),
              )
          )
        );
      }
    }

    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
    ]);
    Size size = MediaQuery.of(context).size;

    if(isLoading){
      return Scaffold(
        key: _scaffoldKey,
          backgroundColor: Colors.orange,
          body: Center(
            child: SpinKitPulse(
              color: Colors.white,
              size: 100.0,
            ),
          )
        );
    }
    else{
      return Scaffold(
      key: _scaffoldKey,
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
                        GestureDetector(
                          onTap: () {
                            getImage(false);
                          },
                          onLongPress: () {
                            getImage(true);
                          },
                          child: image==null ? Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(100)
                            ),
                            child: Icon(
                              Icons.add_a_photo,
                              color: Colors.white,
                              size: 70,
                            ),
                          ) :
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 1.0, color: Colors.orange),
                              image: DecorationImage(
                                image: FileImage(image)
                              )
                            ),
                          ) 
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
                          onCompleted: () {
                            if(flatNameController.text.length<5){
                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                  content: Text(
                                    "Nazwa powinna mieć minimum 5 znaków",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  )
                              )
                            );
                            }
                          },
                        ),
                        RoundedInput(
                          controller: localisationController,
                          width: size.width*0.7,
                          placeholder: "Lokalizacja",
                          icon: Icons.gps_fixed,
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          onCompleted: () {
                            if(localisationController.text.length<5){
                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                  content: Text(
                                    "Lokalizacja powinna mieć minimum 5 znaków",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  )
                              )
                            );
                            }
                          },
                        ),
                        RoundedInput(
                          controller: priceController,
                          isNumber: true,
                          width: size.width*0.7,
                          placeholder: "Cena wynajmu [zł]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.monetization_on, //inna
                          onChanged: (x) {
                            if(priceController.text.length==0){
                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                  content: Text(
                                    "To pole jest wymagane",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  )
                              )
                            );
                            }
                          },
                        ),
                        RoundedInput(
                          controller: areaController,
                          isNumber: true,
                          width: size.width*0.7,
                          placeholder: "Powierzchnia [m\u00B2]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.crop_square, //inna
                          onChanged: (x) {
                            if(areaController.text.length==0){
                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                  content: Text(
                                    "To pole jest wymagane",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  )
                              )
                            );
                            }
                          },
                        ),
                        RoundedInput(
                          controller: numberOfRoomsController,
                          width: size.width*0.7,
                          isNumber: true,
                          placeholder: "Liczba pokoi",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.airline_seat_individual_suite,
                          onChanged: (x) {
                            if(numberOfRoomsController.text.length==0){
                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                  content: Text(
                                    "To pole jest wymagane",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  )
                              )
                            );
                            }
                          },
                        ),
                        RoundedInput(
                          controller: settlementDayController,
                          width: size.width*0.7,
                          isNumber: true,
                          placeholder: "Dzień rozliczenia",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.event,
                          onChanged: (x) {
                            if(int.parse(settlementDayController.text)>28){
                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                  content: Text(
                                    "Maksymalny dzień rozliczenia to 28",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  )
                              )
                            );
                            }
                          },
                        ),
                        RoundedInput(
                          controller: settlementPeriodController,
                          width: size.width*0.7,
                          isNumber: true,
                          placeholder: "Okres rozliczenia [miesiące]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.black,
                          icon: Icons.date_range,
                          onChanged: (x) {
                            if(settlementPeriodController.text.length==0){
                              _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.orange,
                                  content: Text(
                                    "To pole jest wymagane",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18
                                    ),
                                  )
                              )
                            );
                            }
                          },
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
                margin: EdgeInsets.symmetric(horizontal: 25),
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
                                    isNumber: true,
                                    controller: coldWaterPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1m\u00B3 wody zimnej",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.opacity, //inna
                                    isEnabled: isColdWater,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: hotWaterPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1m\u00B3 wody ciepłej",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.waves,
                                    isEnabled: isHotWater,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: heatingPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za ogrzewanie [roczna]",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.local_fire_department,
                                    isEnabled: isHeating,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: gasPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1kWh gazu",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    isEnabled: isGas,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: electricityPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za 1kWh prądu",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.flash_on,
                                    isEnabled: isElectricity,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: rubbishPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za śmieci/os",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.delete, //inna
                                    isEnabled: isRubbish,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: internetPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za internet",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.router, //inna
                                    isEnabled: isInternet,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: tvPriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za telewizję",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.live_tv,
                                    isEnabled: isTv,
                                  ),
                                  RoundedInput(
                                    isNumber: true,
                                    controller: phonePriceController,
                                    width: size.width*0.7,
                                    placeholder: "Cena za telefon",
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    iconColor: Colors.black,
                                    icon: Icons.phone,
                                    isEnabled: isPhone,
                                  ),
                                
                                ],
                              ),
                              Column(
                                children: [
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isColdWater = !isColdWater;
                                        coldWaterPriceController.text = '';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isHotWater = !isHotWater;
                                        hotWaterPriceController.text='';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isHeating = !isHeating;
                                        heatingPriceController.text='';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isGas = !isGas;
                                        gasPriceController.text='';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isElectricity = !isElectricity;
                                        electricityPriceController.text='';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isRubbish = !isRubbish;
                                        rubbishPriceController.text='';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isInternet = !isInternet;
                                        internetPriceController.text='';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isTv = !isTv;
                                        tvPriceController.text='';
                                      });
                                    }
                                  ),
                                  FlatCheckBox(
                                    onTap: () {
                                      setState(() {
                                        isPhone = !isPhone;
                                        phonePriceController.text='';
                                      });
                                    }
                                  ),
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
                              List inputs = [image,flatNameController,localisationController, priceController,areaController,numberOfRoomsController,settlement_day,settlementPeriodController];
                              List labels = ['Zdjęcie','Nazwa mieszkania','Lokalizacja','Cena wynajmu','Powierzchnia','Liczba pokoi','Dzień rozliczenia','Okres rozliczenia'];
                              for(int x=0;x<inputs.length;x++){
                                if(x == ''||x==null){
                                  var i = labels[x];
                                  _scaffoldKey.currentState.showSnackBar(
                                    SnackBar(
                                      backgroundColor: Colors.orange,
                                        content: Text(
                                          "Pole $i jest wymagane.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18
                                          ),
                                        )
                                    )
                                  );
                                }
                              }
                              if(flatNameController.text.length<5){
                                _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.orange,
                                    content: Text(
                                      "Nazwa powinna mieć minimum 5 znaków",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    )
                                )
                              );
                              }
                              if(localisationController.text.length<5){
                                _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.orange,
                                    content: Text(
                                      "Lokalizacja powinna mieć minimum 5 znaków",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 18
                                      ),
                                    )
                                )
                              );
                              }
                              sendData();
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
    );}
  }
}