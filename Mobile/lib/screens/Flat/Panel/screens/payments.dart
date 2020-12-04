import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:planus/screens/Flat/Flats_list/flats.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

class PaymentsScreen extends StatefulWidget {

  final FlatInfo flatData;

  PaymentsScreen(this.flatData);

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

var settlement_day;
List<CircularStackEntry> data;
List itemData;

class _PaymentsScreenState extends State<PaymentsScreen> {

  @override
  void initState() {
    setState(() {
      settlement_day = widget.flatData.settlement_day;

      data = <CircularStackEntry>[
        new CircularStackEntry(
          <CircularSegmentEntry>[
            /*
            //prąd*róznica
            new CircularSegmentEntry(100.0, Colors.yellow),
            //woda_zimna*roznica
            new CircularSegmentEntry(100.0, Colors.blue),
            //woda_ciepla*roznica
            new CircularSegmentEntry(100.0, Colors.red[200]),
            //gaz*roznica
            new CircularSegmentEntry(100.0, Colors.green),
            */

            //smieci*mieszkancy
            new CircularSegmentEntry(widget.flatData.rubbish*1, Colors.brown),
            //ogrzewanie
            new CircularSegmentEntry(widget.flatData.heating, Colors.red),
            //wynajem
            new CircularSegmentEntry(widget.flatData.price, HexColor('#646DBC')),
            //internet
            new CircularSegmentEntry(widget.flatData.internet, Colors.green[200]),
            //telewizja
            new CircularSegmentEntry(widget.flatData.tv, Colors.blue[200]),
            //abonament
            new CircularSegmentEntry(widget.flatData.phone, Colors.yellow[200]),
          ],
          rankKey: 'Quarterly Profits',
        ),
        ];

        itemData = [
          {
            'widget': widget.flatData.price,
            'color': HexColor('#646DBC'),
            'icon': Icons.house,
            'text': 'Czynsz',
            'price':(widget.flatData.price).toStringAsFixed(2),
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'widget': widget.flatData.internet,
            'color': Colors.green[200],
            'icon': Icons.router,
            'text': 'Internet',
            'price':(widget.flatData.internet).toStringAsFixed(2),
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'widget': widget.flatData.tv,
            'color': Colors.blue[200],
            'icon': Icons.live_tv,
            'text': 'Telewizja',
            'price':(widget.flatData.tv).toStringAsFixed(2),
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'widget': widget.flatData.phone,
            'color': Colors.yellow[200],
            'icon': Icons.phone,
            'text': 'Telefon',
            'price':(widget.flatData.phone).toStringAsFixed(2),
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'widget': widget.flatData.cold_water,
            'color': Colors.blue,
            'icon': Icons.opacity,
            'text': 'Zimna woda',
            'price':(widget.flatData.cold_water*3.1).toStringAsFixed(2),
            'isCounter':true,
            'count': '3.1', //ODCZYT Z LICZNIKA
            'unit':'m\u00B3'
          },
          {
            'widget': widget.flatData.hot_water,
            'color': Colors.red[200],
            'icon': Icons.waves,
            'text': 'Ciepła woda',
            'price':(widget.flatData.hot_water*3.1).toStringAsFixed(2),
            'isCounter':true,
            'count': '3.1', //ODCZYT Z LICZNIKA
            'unit':'m\u00B3'
          },
          {
            'widget': widget.flatData.electricity,
            'color': Colors.yellow,
            'icon': Icons.flash_on,
            'text': 'Prąd',
            'price':(widget.flatData.electricity*3.1).toStringAsFixed(2),
            'isCounter':true,
            'count': '3.1', //ODCZYT Z LICZNIKA
            'unit':'kWh'
          },
          {
            'widget': widget.flatData.gas,
            'color': Colors.green,
            'icon': Icons.games_sharp, //DO ZMIANY
            'text': 'Gaz',
            'price':(widget.flatData.gas*3.1).toStringAsFixed(2),
            'isCounter':true,
            'count': '3.1', //ODCZYT Z LICZNIKA
            'unit':'kWh'
          },
          {
            'widget': widget.flatData.heating,
            'color': Colors.red,
            'icon': Icons.local_fire_department,
            'text': 'Ogrzewanie',
            'price':(widget.flatData.heating).toStringAsFixed(2),
            'isCounter':false,
            'count': '',
            'unit':''
          },
          {
            'widget': widget.flatData.rubbish,
            'color': Colors.brown,
            'icon': Icons.delete, //DO ZMIANY
            'text': 'Śmieci',
            'price':(widget.flatData.rubbish*1).toStringAsFixed(2),
            'isCounter':false,
            'count': '',
            'unit':''
          },
        ];
    });
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var month = new DateTime.now().month;
    var now = new DateTime.now();

    if(now.day<widget.flatData.settlement_day)
      month-=1;

    Size size = MediaQuery.of(context).size;
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
                  TextSpan(text: widget.flatData.summary.toStringAsFixed(2)),
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
              for(int i=0;i<itemData.length;i++) if(itemData[i]['widget']>0)ItemCard(
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
            ],
          ),
        ),
      ),
    );
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
            height: size.height*0.11,
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
                  //width: size.width*0.45,
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
                    "$price\zł", //zmiana ceny
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
