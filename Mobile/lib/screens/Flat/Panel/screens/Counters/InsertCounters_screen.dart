import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:planus/services/apiController.dart';

class InsertCounters extends StatefulWidget {
  
  final FlatInfo flatData;
  InsertCounters(this.flatData);

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

  @override
  void initState() {
    _checkCounters(widget.flatData.id_apartment);
    super.initState();
  }

  void _checkCounters(id_apartment) async{
    var api = new Api();
    var response = await api.getCounters(id_apartment);
    //print(response);
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
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
            children:[ 
            Container(
            child: Stack(
              children: [
                if(widget.flatData.hot_water>0 || widget.flatData.cold_water>0 || widget.flatData.electricity>0 || widget.flatData.gas>0)Positioned(
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
                      if(widget.flatData.cold_water>0) RoundedInput(
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
                          });
                        },
                      ),
                      if(widget.flatData.hot_water>0) RoundedInput(
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
                          });
                        },
                      ),
                      if(widget.flatData.gas>0) RoundedInput(
                        isNumber: true,
                        width: size.width*0.8,
                        placeholder: "Stan licznika gazu [kWh]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        onChanged: (val) {
                          setState(() {
                            gasCountController = double.parse(val);
                          });
                        },
                      ),
                      if(widget.flatData.electricity>0) RoundedInput(
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
          if((widget.flatData.hot_water>0 || widget.flatData.cold_water>0 || widget.flatData.electricity>0 || widget.flatData.gas>0) && (coldWaterCount!= null || hotWaterCount!=null || gasCount!=null || electricityCount!=null))Container(
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
          
          if(widget.flatData.cold_water>0 && coldWaterCount!=null) MediaPrice(size: size, media: " m3 wody zimnej", price: widget.flatData.cold_water, actual_counter: coldWaterCountController, old_counter: coldWaterCount), 
          if(widget.flatData.hot_water>0 && hotWaterCount!=null) MediaPrice(size: size, media: " m3 wody ciepłej", price: widget.flatData.hot_water, actual_counter: hotWaterCountController, old_counter: hotWaterCount),
          if(widget.flatData.gas>0 && gasCount!=null) MediaPrice(size: size, media: " kWh gazu", price: widget.flatData.gas, actual_counter: gasCountController, old_counter: gasCount),
          if(widget.flatData.electricity>0 && electricityCount!=null) MediaPrice(size: size, media: " kWh prądu", price: widget.flatData.electricity, actual_counter: electricityCountController, old_counter: electricityCount),
          
          SizedBox(height: size.height*0.05),
          if(widget.flatData.hot_water>0 || widget.flatData.cold_water>0 || widget.flatData.electricity>0 || widget.flatData.gas>0)RoundedButton(
            text: "Zapisz liczniki",
            width: size.width*0.7,
            color: Colors.white,
            textColor: Colors.orange,
            onPress: () async {
              var api = new Api();
              Map data = {
                'id_apartment':widget.flatData.id_apartment,
                'cold_water': coldWaterCountController,
                'hot_water': hotWaterCountController,
                'gas': gasCountController,
                'electricity': electricityCountController,
              };
              var response = await api.insertCounters(data);

              if(response['message']=='OK'){
                Navigator.pop(context);
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
    );
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