import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

FlatInfo flatData;
bool _isLoading;

class InsertCounters extends StatefulWidget {
  
  final int user_id;
  final int apartment_id;
  InsertCounters(this.user_id,this.apartment_id);

  @override
  _InsertCountersState createState() => _InsertCountersState();
}

final _scaffoldKey = GlobalKey<ScaffoldState>();

class _InsertCountersState extends State<InsertCounters> {

  double coldWaterCountController = 0.0;
  double hotWaterCountController = 0.0;
  double electricityCountController = 0.0;
  double gasCountController = 0.0;

  double coldWaterCount;
  double hotWaterCount;
  double gasCount;
  double electricityCount;

  List counters;
  FlatInfo flatData;
  bool showLabel = false;

  void _getFlatData(apartment_id,user_id) async{
    var api = new Api();
    var response = await api.listFlats(user_id);
    //print(response);
    if(response['statusCode']==200){
      List flats = response['body']['data'];
      int flats_count = flats.length;

      for(int i=0;i<flats_count;i++){
        if(flats[i]['id_apartment']==apartment_id){
          setState(() {
            flatData = FlatInfo(id_user: user_id);
            flatData.parseData(flats[i]);
          });
          //print(flats[i]);

          _checkCounters(flatData.id_apartment);
        }
      }
    }
  }

  @override
  void initState() {
    _getFlatData(widget.apartment_id,widget.user_id);
    setState(() {
      _isLoading = true;
    });
    //_checkCounters(widget.flatData.id_apartment);
    super.initState();
  }

  void _checkCounters(id_apartment) async{
    var api = new Api();
    var response = await api.getCounters(id_apartment);
    if(response != {}){
      List items = ['cold_water','hot_water','gas','electricity'];
      counters = [coldWaterCount, hotWaterCount, gasCount, electricityCount];
      for(int i=0;i<items.length;i++){
        if(response[items[i]]==null){
          counters[i]=null;
        }else{
          counters[i] = double.parse(response[items[i]]);
        }
      }
    }
    coldWaterCount = counters[0];
    hotWaterCount = counters[1];
    gasCount = counters[2];
    electricityCount = counters[3];

    setState(() {
      _isLoading = false;
    });

    if(flatData.cold_water == 0.0 && flatData.hot_water==0.0 && flatData.gas==0.0 && flatData.electricity==0.0){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      Map response = jsonDecode(localStorage.getString('userData'));

      Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
      Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    if(_isLoading){
        return Scaffold(
          backgroundColor: Colors.orange,
          body: Center(
            child: SpinKitPulse(
              color: Colors.white,
              size: 100.0,
            ),
          )
        );
    }else{
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              children:[ 
              Container(
              child: Stack(
                children: [
                  if(flatData.hot_water>0 || flatData.cold_water>0 || flatData.electricity>0 || flatData.gas>0)Positioned(
                    top: 50,
                    left: 30,
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: "Wprowadź "),
                          TextSpan(text: "liczniki", style: TextStyle(color: Colors.orange)),
                        ]
                      ),
                    )
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(height: size.height*0.15),
                        if(flatData.cold_water>0) RoundedInput(
                          isNumber: true,
                          width: size.width*0.8,
                          placeholder: "Stan licznika wody zimnej [1m\u00B3]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.grey[900],
                          icon: Icons.opacity, //inna
                          onChanged: (val) {
                            setState(() {
                              coldWaterCountController = double.parse(val);
                              showLabel = true;
                            });
                          },
                        ),
                        if(flatData.hot_water>0) RoundedInput(
                          isNumber: true,
                          width: size.width*0.8,
                          placeholder: "Stan licznika wody ciepłej [1m\u00B3]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.grey[900],
                          icon: Icons.waves,
                          onChanged: (val) {
                            setState(() {
                              hotWaterCountController = double.parse(val);
                              showLabel = true;
                            });
                          },
                        ),
                        if(flatData.gas>0) RoundedInput(
                          isNumber: true,
                          width: size.width*0.8,
                          placeholder: "Stan licznika gazu [kWh]",
                          color: Colors.white,
                          icon: CupertinoIcons.burst_fill,
                          textColor: Colors.black,
                          iconColor: Colors.grey[900],
                          onChanged: (val) {
                            setState(() {
                              gasCountController = double.parse(val);
                              showLabel = true;
                            });
                          },
                        ),
                        if(flatData.electricity>0) RoundedInput(
                          isNumber: true,
                          width: size.width*0.8,
                          placeholder: "Stan licznika prądu [kWh]",
                          color: Colors.white,
                          textColor: Colors.black,
                          iconColor: Colors.grey[900],
                          icon: Icons.flash_on,
                          onChanged: (val) {
                            setState(() {
                              electricityCountController = double.parse(val);
                              showLabel = true;
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ]
              ),
            ),
            SizedBox(height: size.height*0.03),
            if(showLabel)Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 30,vertical: 5),
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(text: "Koszty "),
                    TextSpan(text: "mediów", style: TextStyle(color: Colors.orange)),
                  ]
                ),
              ),
            ),
            
            if(flatData.cold_water>0 && flatData.cold_water!=null && coldWaterCount!=null) MediaPrice(size: size, media: " m3 wody zimnej", price: flatData.cold_water, actual_counter: coldWaterCountController, old_counter: coldWaterCount), 
            if(flatData.hot_water>0 && flatData.hot_water!=null && hotWaterCount!=null) MediaPrice(size: size, media: " m3 wody ciepłej", price: flatData.hot_water, actual_counter: hotWaterCountController, old_counter: hotWaterCount),
            if(flatData.gas>0 && flatData.gas!=null && gasCount!=null) MediaPrice(size: size, media: " kWh gazu", price: flatData.gas, actual_counter: gasCountController, old_counter: gasCount),
            if(flatData.electricity>0 && flatData.electricity!=null && electricityCount!=null) MediaPrice(size: size, media: " kWh prądu", price: flatData.electricity, actual_counter: electricityCountController, old_counter: electricityCount),
            
            SizedBox(height: size.height*0.05),
            if(flatData.hot_water>0 || flatData.cold_water>0 || flatData.electricity>0 || flatData.gas>0)RoundedButton(
              text: "Zapisz liczniki",
              width: size.width*0.7,
              color: Colors.white,
              textColor: Colors.orange,
              onPress: () async {
                var api = new Api();
                Map data = {
                  'id_apartment':flatData.id_apartment,
                  'cold_water': coldWaterCountController,
                  'hot_water': hotWaterCountController,
                  'gas': gasCountController,
                  'electricity': electricityCountController,
                };
                var response = await api.insertCounters(data);


                if(response['message']=='OK'){
                  SharedPreferences localStorage = await SharedPreferences.getInstance();
                  Map response = jsonDecode(localStorage.getString('userData'));

                  Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                  Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
                }else{
                  _scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.orange,
                        content: Text(
                          response['message'],
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
            SizedBox(height: size.height*0.05)
            ]
          ),
        ),
      ),
    );}
  }
}

class MediaPrice extends StatelessWidget {
  const MediaPrice({
    Key key,
    this.size,
    @required this.price,
    this.media,
    @required this.old_counter = 3,
    @required this.actual_counter = 3,
  }) : super(key: key);

  final Size size;
  final double price;
  final String media;
  final double old_counter;
  final double actual_counter;

  @override
  Widget build(BuildContext context) {

    double counter = actual_counter-old_counter;
    double media_price = counter*price;
    bool isCorrect = actual_counter>=old_counter;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.centerLeft,
      width: size.width*0.8,
      child: isCorrect ? CorrectMediaCount(counter: counter, media: media, media_price: media_price) : Text("")
    );
  }
}

class CorrectMediaCount extends StatelessWidget {
  const CorrectMediaCount({
    Key key,
    @required this.counter,
    @required this.media,
    @required this.media_price,
  }) : super(key: key);

  final double counter;
  final String media;
  final double media_price;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
            ),
            children: [
              TextSpan(text: "Zużyto "),
              TextSpan(text: counter.toStringAsFixed(2), style: TextStyle(color: Colors.orange)),
              TextSpan(text: media),
            ]
          ),
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 18,
            ),
            children: [
              TextSpan(text: "Koszt "),
              TextSpan(text: media_price.toStringAsFixed(2), style: TextStyle(color: Colors.orange)),
              TextSpan(text: " zł"),
            ]
          ),
        ),
      ],
    );
  }
}