import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:planus/services/apiController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentsScreen extends StatefulWidget {

  final FlatInfo flatData;

  PaymentsScreen(this.flatData);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

var settlement_day;
List<CircularStackEntry> data;
List itemData;
Map billData;
int id_bill;

bool _isLoading = true;
bool _areCounters = true;

String name;
String price;

class _PaymentsScreenState extends State<PaymentsScreen> {

  getData() async{
    var api = new Api();

    var response = await api.getBill(widget.flatData.id_apartment);

    //print(response['body']['bill']);
    setState(() {
      if(response['statusCode']==500){
        _isLoading=false;
        _areCounters=false;
      }
      if(response['statusCode']==200){
        billData = response['body']['bill'];
        if(response['body']['bill']==null){
          _isLoading=false;
          _areCounters=false;
        }else{
        id_bill=billData['id_bill'];

        double fee_sum=0;
        for(int i=0;i<billData['additional_fees'].length;i++){
          fee_sum+=double.parse(billData['additional_fees'][i]['price']);
        }

        //print(billData);
        data = <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[        
            //prąd
            new CircularSegmentEntry(double.parse(billData['electricity']), Colors.yellow),
            //woda_zimna
            new CircularSegmentEntry(double.parse(billData['cold_water']), Colors.blue),
            //woda_ciepla
            new CircularSegmentEntry(double.parse(billData['hot_water']), Colors.red[200]),
            //gaz
            new CircularSegmentEntry(double.parse(billData['gas']), Colors.green),
            //smieci*mieszkancy
            new CircularSegmentEntry(double.parse(billData['rubbish']), Colors.brown),
            //ogrzewanie
            //new CircularSegmentEntry(widget.flatData.heating, Colors.red),
            //wynajem
            new CircularSegmentEntry(double.parse(billData['rental_price']), HexColor('#646DBC')),
            //internet
            new CircularSegmentEntry(double.parse(billData['internet']), Colors.green[200]),
            //telewizja
            new CircularSegmentEntry(double.parse(billData['tv']), Colors.blue[200]),
            //abonament
            new CircularSegmentEntry(double.parse(billData['phone']), Colors.yellow[200]),
            //koszty dodatkowe
            new CircularSegmentEntry(fee_sum, Colors.orange),
          ],
          rankKey: 'Summary',
        ),
        ];

        itemData = [
          {
            'color': HexColor('#646DBC'),
            'icon': Icons.house,
            'text': 'Czynsz',
            'price':billData['rental_price'],
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'color': Colors.green[200],
            'icon': Icons.router,
            'text': 'Internet',
            'price': billData['internet'],
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'color': Colors.blue[200],
            'icon': Icons.live_tv,
            'text': 'Telewizja',
            'price': billData['tv'],
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'color': Colors.yellow[200],
            'icon': Icons.phone,
            'text': 'Telefon',
            'price': billData['phone'],
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'color': Colors.blue,
            'icon': Icons.opacity,
            'text': 'Zimna woda',
            'price': billData['cold_water'],
            'isCounter':false,
            'count': '3.1',
            'unit':'m\u00B3'
          },
          {
            'color': Colors.red[200],
            'icon': Icons.waves,
            'text': 'Ciepła woda',
            'price':billData['hot_water'],
            'isCounter':false,
            'count': '3.1', 
            'unit':'m\u00B3'
          },
          {
            'color': Colors.yellow,
            'icon': Icons.flash_on,
            'text': 'Prąd',
            'price':billData['electricity'],
            'isCounter':false,
            'count': '3.1', 
            'unit':'kWh'
          },
          {
            'color': Colors.green,
            'icon': CupertinoIcons.burst_fill, 
            'text': 'Gaz',
            'price':billData['gas'],
            'isCounter':false,
            'count': '3.1', 
            'unit':'kWh'
          },
          /*
          {
            'color': Colors.red,
            'icon': Icons.local_fire_department,
            'text': 'Ogrzewanie',
            'price':(widget.flatData.heating).toStringAsFixed(2),
            'isCounter':false,
            'count': '',
            'unit':''
          },
          */
          {
            'color': Colors.brown,
            'icon': Icons.delete, 
            'text': 'Śmieci',
            'price':billData['rubbish'],
            'isCounter':false,
            'count': '',
            'unit':''
          },
        ]; 

        for(int i=0;i<billData['additional_fees'].length;i++){
          itemData.add({
            'color': Colors.orange,
            'icon': Icons.add, 
            'text': billData['additional_fees'][i]['name'],
            'price': billData['additional_fees'][i]['price'],
            'isCounter':false,
            'count': '',
            'unit':''
          });
        }
        _isLoading=false;
        }
      };
    });
  }



  @override
  void initState() {
    setState(() {
      getData();
      settlement_day = widget.flatData.settlement_day;
      //print(settlement_day);
    });
    
    super.initState();
  }

  @override
  void dispose() {
    billData=null;
    _isLoading=true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var month = new DateTime.now().month;
    var now = new DateTime.now();

    if(now.day<widget.flatData.settlement_day)
      month-=1;

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
      if(billData!=null){
        return SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 30,vertical: 30),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey[900],
                            fontSize: 24,
                          ),
                          children: [
                            TextSpan(text: "Rachunek za "),
                            TextSpan(text: "mieszkanie", style: TextStyle(color: Colors.orange)),
                          ]
                        ),
                      ),
                      Text(
                        "Termin rozliczeniowy: $settlement_day.$month",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 18,
                  ),
                  children: [
                    TextSpan(text: "Łączna suma rachunku ".toUpperCase(), style: TextStyle(color: Colors.orange)),
                    TextSpan(text: billData==null ? 'Wczytywanie...' : billData['sum']),
                    TextSpan(text: " ZŁ".toUpperCase(), style: TextStyle(color: Colors.grey[600])),
                    ]
                  ),
                ),
                Container(
                  width: size.width*0.9,
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  width: size.width*0.6,
                  height: size.width*0.6,
                  child: new AnimatedCircularChart(
                    size: const Size(300.0, 300.0),
                    initialChartData: data,
                    chartType: CircularChartType.Pie,
                  ),
                ),
                Container(
                  width: size.width*0.9,
                  alignment: Alignment.centerLeft,
                  child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                    color: Colors.grey[900],
                    fontSize: 24,
                  ),
                  children: [
                    TextSpan(text: "Szczegóły "),
                    TextSpan(text: "rachunku ", style: TextStyle(color: Colors.orange)),
                    ]
                  ),
                  ),
                ),
                SizedBox(height: size.height*0.02),
                for(int i=0;i<itemData.length;i++) if(double.parse(itemData[i]['price'])>0)ItemCard(
                  size: size,
                  color: itemData[i]['color'],
                  icon: itemData[i]['icon'],
                  text: itemData[i]['text'],
                  price: itemData[i]['price'],
                  isCounter: itemData[i]['isCounter'],
                  count: itemData[i]['count'],
                  unit: itemData[i]['unit'],
                ), 
                SizedBox(height: size.height*0.03),   
                if(widget.flatData.id_user==widget.flatData.id_owner) Container(
                  child: Column(
                    children: [
                      Container(
                        width: size.width*0.9,
                        alignment: Alignment.centerLeft,
                        child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                          color: Colors.grey[900],
                          fontSize: 24,
                        ),
                        children: [
                          TextSpan(text: "Dodaj "),
                          TextSpan(text: "opłatę ", style: TextStyle(color: Colors.orange)),
                          ]
                        ),
                        ),
                      ),
                      SizedBox(height: size.height*0.03),
                      RoundedInput(
                        width: size.width*0.7,
                        placeholder: "Nazwa opłaty",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.black,
                        icon: Icons.assignment,
                        onChanged: (val){
                          name = val;
                        }
                      ),
                      RoundedInput(
                        width: size.width*0.7,
                        placeholder: "Wysokość opłaty",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.black,
                        icon: Icons.monetization_on,
                        isNumber: true,
                        onChanged: (val){
                          price = val;
                        },
                      ),    
                      SizedBox(height: size.height*0.03),      
                      RoundedButton(
                        width: size.width*0.7,
                        text: "Dodaj",
                        textColor: Colors.white,
                        color: Colors.orange.withOpacity(0.95),
                        onPress: () async{
                          if(name.length>0 && price.length>0){
                            Map data = {
                              'id_bill': id_bill,
                              'name': name,
                              'price': price
                            };

                            var api = new Api();
                            var response = await api.addToBill(data);
                            //print(response);
                            if(response['message']=='OK'){
                              SharedPreferences localStorage = await SharedPreferences.getInstance();
                              Map response = jsonDecode(localStorage.getString('userData'));

                              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
                              Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => Flats(response)));
                            }
                          }
                        }             
                      ),
                      SizedBox(height: size.height*0.05),
                    ],
                  ),
                ),    
              ],
            ),
          ),
        ),
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
                "assets/noCounters.svg",
                width: size.width*0.4,
                height: size.height*0.35,
              ),
              SizedBox(height: size.height*0.05),
              Container(
                width: size.width*0.8,
                child: Text(
                  'Po upływie pierwszego terminu rozliczenia w tym miejscu zostanie wyświetlone podsumowanie ubiegłego miesiąca.',
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

class ItemCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final bool isCounter;
  final String count;
  final String unit;
  final String price;

  const ItemCard({
    Key key,
    @required this.size,
    this.color = Colors.blue,
    this.icon = Icons.opacity,
    this.text,
    this.isCounter = false,
    this.count,
    this.price,
    this.unit
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: size.width*0.95,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Column(
        children: [
          Container(
            //height: size.height*0.11,
            constraints: BoxConstraints(
              minHeight: size.height*0.11
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.orange, width: 1.0)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width*0.3,
                  alignment: Alignment.center,
                  height: size.height*0.08,
                  child: CircleAvatar(
                    backgroundColor: color, 
                    foregroundColor: Colors.white,
                    radius: 30,
                    child: Icon(icon, size: 30,),
                  ),
                ),
                Container(
                  //width: size.width*0.3, //zobaczyc na ip7
                  constraints: BoxConstraints(
                    maxWidth: 127
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                      text,
                      style: TextStyle(
                        fontSize: 20
                        ),
                      ),
                      if(isCounter) SizedBox(height:5),
                      if(isCounter) Text(
                      "Zużycie: $count$unit",
                      style: TextStyle(
                        fontSize: 15
                        ),
                      ),
                      
                    ]
                  )            
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, size.width*0.05, 0),
                  width: size.width*0.3,
                  alignment: Alignment.centerRight,
                  child: Text(
                    "$price\zł",
                    style: TextStyle(
                      fontSize: 18
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
