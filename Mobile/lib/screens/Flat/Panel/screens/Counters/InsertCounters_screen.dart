import 'package:flutter/material.dart';
import 'package:planus/components/RoundedButton.dart';
import 'package:planus/components/RoundedInput.dart';

class InsertCounters extends StatefulWidget {
  final int apartment_id;
  InsertCounters(this.apartment_id);

  @override
  _InsertCountersState createState() => _InsertCountersState();
}

class _InsertCountersState extends State<InsertCounters> {

  final coldWaterPriceController = TextEditingController();
  final hotWaterPriceController = TextEditingController();
  final heatingPriceController = TextEditingController();
  final gasPriceController = TextEditingController();

  

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children:[ 
            Container(
            child: Stack(
              children: [
                Positioned(
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
                      RoundedInput(
                        width: size.width*0.8,
                        placeholder: "Ilość zużytej wody zimnej [1m\u00B3]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        icon: Icons.opacity //inna
                      ),
                      RoundedInput(
                        width: size.width*0.8,
                        placeholder: "Ilość zużytej wody ciepłej [1m\u00B3]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        icon: Icons.waves,
                      ),
                      RoundedInput(
                        width: size.width*0.8,
                        placeholder: "Ilość zużytego gazu [kWh]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                      ),
                      RoundedInput(
                        width: size.width*0.8,
                        placeholder: "Ilość zużytego prądu [kWh]",
                        color: Colors.white,
                        textColor: Colors.black,
                        iconColor: Colors.grey[900],
                        icon: Icons.flash_on,
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
          SizedBox(height: size.height*0.03),
          Container(
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
          MediaPrice(size: size, media: " m3 wody zimnej", price: 1.3, actual_counter: 0, old_counter: 0),
          MediaPrice(size: size, media: " m3 wody ciepłej", price: 1.3, actual_counter: 0, old_counter: 0),
          MediaPrice(size: size, media: " kWh gazu", price: 1.3, actual_counter: 0, old_counter: 0),
          MediaPrice(size: size, media: " kWh prądu", price: 1.3, actual_counter: 0, old_counter: 0),
          
          SizedBox(height: size.height*0.05),
          RoundedButton(
            text: "Zapisz liczniki",
            width: size.width*0.7,
            color: Colors.white,
            textColor: Colors.orange,
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
              TextSpan(text: counter.toString(), style: TextStyle(color: Colors.orange)),
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
              TextSpan(text: media_price.toString(), style: TextStyle(color: Colors.orange)),
              TextSpan(text: " zł"),
            ]
          ),
        ),
      ],
    );
  }
}