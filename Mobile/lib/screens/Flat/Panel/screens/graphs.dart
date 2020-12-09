import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:planus/services/apiController.dart';
class GraphsScreen extends StatefulWidget {

  final FlatInfo flatData;

  GraphsScreen(this.flatData);

  @override
  _GraphsScreenState createState() => _GraphsScreenState();
}

class _GraphsScreenState extends State<GraphsScreen> {

  bool _isLoading = true;
  bool _areStats = true;

  List<BarChartModel> price_sums = [];

  List<BarChartModel> cold_water_data = [];
  List<BarChartModel> hot_water_data = [];
  List<BarChartModel> gas_data = [];
  List<BarChartModel> electricity_data = [];

  Map data;
  
  getData() async{
    var api = new Api();
    var response = await api.getStats(widget.flatData.id_apartment);

    if (response['statusCode']==200){
      data = response['body'];
      int length = data['months'].length;
      if(length<3){
        setState(() {
          _isLoading=false;
          _areStats = false;
        });
      }else{
        for(int i=0; i<data['price_sums'].length;i++){
          price_sums.add(BarChartModel(label: data['months'][i], value: double.parse(data['price_sums'][i])));
        }
        for(int i=0; i<data['cold_water'].length;i++){
          cold_water_data.add(BarChartModel(label: data['months'][i], value: double.parse(data['cold_water'][i])));
        }
        for(int i=0; i<data['hot_water'].length;i++){
          hot_water_data.add(BarChartModel(label: data['months'][i], value: double.parse(data['hot_water'][i])));
        }
        for(int i=0; i<data['gas'].length;i++){
          gas_data.add(BarChartModel(label: data['months'][i], value: double.parse(data['gas'][i])));
        }
        for(int i=0; i<data['electricity'].length;i++){
          electricity_data.add(BarChartModel(label: data['months'][i], value: double.parse(data['electricity'][i])));
        }
      }
      setState(() {
        _isLoading=false;
      });
    }
  }

  @override
  void initState() {
    getData();
    setState(() {
    });
    
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(_isLoading){
      return Scaffold(
        backgroundColor: Colors.white,
         body: Center(
          child: SpinKitPulse(
            color: Colors.orange,
            size: 100.0,
          ),
        )
      );
    }else{
      if(_areStats){
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                      width: size.width*0.9,
                      alignment: Alignment.centerLeft,
                      child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                        color: Colors.grey[900],
                        fontSize: 24,
                      ),
                      children: [
                        TextSpan(text: "Statystki "),
                        TextSpan(text: "mieszkania ", style: TextStyle(color: Colors.orange)),
                        ]
                      ),
                    ),
                    ),
                    Container(
                      width: size.width*0.7,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(text: "Wysokość rachunku ", style: TextStyle(color: Colors.orange)),
                              TextSpan(text: "mieszkania \nw ciągu ostatnich 12 miesięcy"),
                              ]
                            ),
                          ),
                          Container(
                            width: size.width*0.8,
                            height: size.width*0.45,
                            child: BarChart(
                              data: price_sums,
                              color: Colors.orange,
                            ),
                          ),
                          SizedBox(height: size.height*0.05)
                        ],
                      ),
                    ),
                    if(data['cold_water'].length>0)Container(
                      width: size.width*0.7,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(text: "Koszt "),
                              TextSpan(text: "wody zimnej", style: TextStyle(color: HexColor('#45D8E1'))),
                              TextSpan(text: " w ciągu \nostatnich 12 miesięcy"),
                              ]
                            ),
                          ),
                          Container(
                            width: size.width*0.8,
                            height: size.width*0.45,
                            child: BarChart(
                              data: cold_water_data,
                              color: HexColor('#45D8E1'),
                            ),
                          ),
                          SizedBox(height: size.height*0.05)
                        ],
                      ),
                    ),
                    if(data['hot_water'].length>0)Container(
                      width: size.width*0.7,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(text: "Koszt "),
                              TextSpan(text: "wody ciepłej", style: TextStyle(color: HexColor('#FF0000'))),
                              TextSpan(text: " w ciągu \nostatnich 12 miesięcy"),
                              ]
                            ),
                          ),
                          Container(
                            width: size.width*0.8,
                            height: size.width*0.45,
                            child: BarChart(
                              data: hot_water_data,
                              color: HexColor('#FF0000'),
                            ),
                          ),
                          SizedBox(height: size.height*0.05)
                        ],
                      ),
                    ),
                    if(data['gas'].length>0)Container(
                      width: size.width*0.7,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(text: "Koszt "),
                              TextSpan(text: "gazu", style: TextStyle(color: HexColor('#56CA53'))),
                              TextSpan(text: " w ciągu \nostatnich 12 miesięcy"),
                              ]
                            ),
                          ),
                          Container(
                            width: size.width*0.8,
                            height: size.width*0.45,
                            child: BarChart(
                              data: gas_data,
                              color: HexColor('#56CA53'),
                            ),
                          ),
                          SizedBox(height: size.height*0.05)
                        ],
                      ),
                    ),
                    if(data['electricity'].length>0)Container(
                      width: size.width*0.7,
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style: TextStyle(
                              color: Colors.grey[900],
                              fontSize: 18,
                            ),
                            children: [
                              TextSpan(text: "Koszt "),
                              TextSpan(text: "prądu", style: TextStyle(color: HexColor('#FFD600'))),
                              TextSpan(text: " w ciągu \nostatnich 12 miesięcy"),
                              ]
                            ),
                          ),
                          Container(
                            width: size.width*0.8,
                            height: size.width*0.45,
                            child: BarChart(
                              data: electricity_data,
                              color: HexColor('#FFD600'),
                            ),
                          ),
                          SizedBox(height: size.height*0.05)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          )
        );
      }else{
        return Center(
          child: Container(
            height: size.height,
            width: size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/noStats.svg",
                  width: size.width*0.4,
                  height: size.height*0.35,
                ),
                SizedBox(height: size.height*0.05),
                Container(
                  width: size.width*0.8,
                  child: Text(
                    'Po upływie trzech miesięcy rozliczeniowych w tym miejscu zostaną wyświetlone statystki.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    }
    
  }
}

class BarChartModel {
  String label;
  double value;

  BarChartModel({ this.label, this.value}
);
}

class BarChart extends StatelessWidget {

  final List<BarChartModel> data;
  final Color color;

  BarChart({this.data, this.color});

  @override
  Widget build(BuildContext context) {

    List<charts.Series<BarChartModel, String>> series =
    [
      charts.Series(
        id: 'Summary',
        data: data,
        domainFn: (BarChartModel x, _) => x.label,
        measureFn: (BarChartModel x, _) => x.value,
        colorFn: (BarChartModel x, _) => charts.ColorUtil.fromDartColor(color),
      )
    ];

    return charts.BarChart(
      series, 
      animate: true, 
    );
  }
}