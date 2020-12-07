import 'dart:convert' as convert;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/components/checkBox.dart';
import 'package:planus/components/goBackButton.dart';
import 'package:flutter/services.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/screens/Flat/Panel/screens/Counters/InitialCounters_screen.dart';
import 'package:planus/screens/Flat/Panel/screens/Counters/InsertCounters_screen.dart';
import 'package:planus/screens/Flat/Panel/screens/payments.dart';
import 'package:planus/services/apiController.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

File image;
bool isLoading = false;

class EditFlat extends StatefulWidget {
  final FlatInfo flatData;
  EditFlat(this.flatData);

  @override
  _EditFlatState createState() => _EditFlatState();
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

class _EditFlatState extends State<EditFlat> {
  bool isColdWater = false;
  bool isHotWater = false;
  bool isHeating = false;
  bool isGas = false;
  bool isElectricity = false;
  bool isRubbish = false;
  bool isInternet = false;
  bool isTv = false;
  bool isPhone = false;
  bool isPublic;

  @override
  void initState() {

    isPublic = widget.flatData.isPublic;

    flatNameController.text = widget.flatData.name;
    priceController.text = widget.flatData.price.toStringAsFixed(2);
    areaController.text = widget.flatData.area.toString();
    numberOfRoomsController.text = widget.flatData.rooms.toString();
    localisationController.text = widget.flatData.localization;
    settlementDayController.text = widget.flatData.settlement_day.toString();
    settlementPeriodController.text = widget.flatData.billing_period.toString();


    coldWaterPriceController.text = widget.flatData.cold_water==0.0 ? null : widget.flatData.cold_water.toStringAsFixed(2);
    hotWaterPriceController.text = widget.flatData.hot_water==0.0 ? null : widget.flatData.hot_water.toStringAsFixed(2);
    heatingPriceController.text = widget.flatData.heating==0.0 ? null : widget.flatData.heating.toStringAsFixed(2);
    gasPriceController.text = widget.flatData.gas==0.0 ? null : widget.flatData.gas.toStringAsFixed(2);
    electricityPriceController.text = widget.flatData.electricity==0.0 ? null : widget.flatData.electricity.toStringAsFixed(2);
    rubbishPriceController.text = widget.flatData.rubbish==0.0 ? null : widget.flatData.rubbish.toStringAsFixed(2);
    internetPriceController.text = widget.flatData.internet==0.0 ? null : widget.flatData.internet.toStringAsFixed(2);
    tvPriceController.text = widget.flatData.tv==0.0 ? null : widget.flatData.tv.toStringAsFixed(2);
    phonePriceController.text = widget.flatData.phone==0.0 ? null : widget.flatData.phone.toStringAsFixed(2);

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

        var imageGet = await get(widget.flatData.image);
        String networkImageBytes = convert.base64Encode(imageGet.bodyBytes);

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
          'rubbish': rubbishPriceController.text=='' ? null: rubbishPriceController.text,
          'internet': internetPriceController.text=='' ? null : internetPriceController.text,
          'tv': tvPriceController.text=='' ? null : tvPriceController.text,
          'phone': phonePriceController.text=='' ? null : phonePriceController.text,
          'user_id': widget.flatData.id_owner,
          'id_apartment': widget.flatData.id_apartment,
          'public': isPublic ? 1 : 0,
          'image': (image!=null) ? convert.base64Encode(image.readAsBytesSync()) : networkImageBytes
        };
        
        //print(data);
        var api = new Api();
        var response = await api.editFlat(data);
        //print('#####');
        //print(response);
        isLoading=false;

        List mediaControllers = [coldWaterPriceController, hotWaterPriceController, gasPriceController, electricityPriceController];

        for(int i=0; i<mediaControllers.length;i++){
          if(mediaControllers[i].text==''){
            mediaControllers[i].text='0.0';
          }else{
            mediaControllers[i].text = mediaControllers[i].text.replaceAll(',','.');
          }
          //print(mediaControllers[i].text);
        }

        if(response['message']=='OK'){
          isLoading=false;
          if(widget.flatData.cold_water!=double.parse(coldWaterPriceController.text) || widget.flatData.hot_water!=double.parse(hotWaterPriceController.text) || widget.flatData.gas!=double.parse(gasPriceController.text) || widget.flatData.electricity!=double.parse(electricityPriceController.text)){
            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => InitialCounters(widget.flatData.id_user,widget.flatData.id_apartment)));
          }else{
            SharedPreferences localStorage = await SharedPreferences.getInstance();
            Map response = jsonDecode(localStorage.getString('userData'));

            Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
          }
          
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
                        TextSpan(text: "Edytuj "),
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
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(width: 1.0, color: Colors.orange),
                              image: DecorationImage(
                                image: NetworkImage(widget.flatData.image)
                              )
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
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(30, 30, 15, 30),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  color: Colors.grey[900],
                                  fontSize: 18,
                                ),
                                children: [
                                  TextSpan(text: "Publiczne "),
                                  TextSpan(text: "mieszkanie", style: TextStyle(color: Colors.orange)),
                                  TextSpan(text: ":")
                                ]
                              ),
                            ),
                          ),
                          FlatCheckBox(
                            isSelected: widget.flatData.isPublic,
                            onTap: () {
                              setState(() {
                                isPublic = !isPublic;
                              });
                            }
                          ),
                        ],
                      ),
                      SizedBox(height: size.height*0.01),
                      RoundedButton(
                            text: "Zapisz zmiany",
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