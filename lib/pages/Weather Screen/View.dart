//This page contains UI of Weather Details page
//I've added a image for presentation purpose only

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'Model.dart';

class WeatherScreen extends StatefulWidget {
  final String location;

  const WeatherScreen({super.key, required this.location});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var futureWeather;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureWeather = fetchWeather(widget.location);
  }

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('EEEE, dd MMM');
    return formatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Refresh Button
      floatingActionButton: Container(
        height: 50,
        width: 50,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          onPressed: () {
            //state management by setState
            setState(() {
              futureWeather = fetchWeather(widget.location);
            });
          },
          child: Icon(
            Icons.refresh_outlined,
          ),
          backgroundColor: Colors.white,
        ),
      ),

      backgroundColor: Color(0xff111d3b),
      //App bar containes a arrow back icon only
      appBar: AppBar(
        backgroundColor: Color(0xff111d3b),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(width: 50),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      //Main UI for weather page starts here
      //First part of UI is Column contained by row as its first part which has Date and day in lef corner and city name in right corner
      //then UI is  followed by row which has image for representation purpose only in left corner
      //right corner of row has column which has temperature and condition of weather below  it
      //next part is  container which displays  windSpeed temperature and humidity
      //last part is refresh button in button right corner
      body: SafeArea(
        //Displaying the data
        child: FutureBuilder<WeatherDetails>(
          future: futureWeather,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              debugPrint('Error: ${snapshot.error}');
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            //this is a function that I've created above to diplay current date and day
                            getCurrentDate(),
                            style: GoogleFonts.poppins(
                                color: Colors.white, fontSize: 20),
                          ),
                          Expanded(
                            //displays location/city name for which user want weather data
                            child: Text(
                              ' ${snapshot.data!.location}',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 22),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height / 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Image for representation purpose only
                          CircleAvatar(
                            backgroundColor: Color(0xff1a2643),
                            radius: 75,
                            child: Image.asset(
                              'assets/images/cloud_image-removebg-preview.png',
                              // Make sure to add a relevant weather icon asset
                              width: 150,
                              height: 150,
                            ),
                          ),
                          //In this column I've displayed Temperature and condition below it
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Baseline(
                                baseline: 90,
                                baselineType: TextBaseline.alphabetic,
                                //RichText is used to display Temperature value in big fonts and celcius in small
                                child: RichText(
                                    maxLines: 2,
                                    text: TextSpan(
                                        text: "${snapshot.data!.temperature}",
                                        style: GoogleFonts.poppins(
                                          color: Color(0xff85b4ea),
                                          fontSize: 70,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        children: [
                                          //WidgetSpan is used to position the degree celcius unit
                                          WidgetSpan(
                                            child: Transform.translate(
                                              offset: const Offset(2, -50),
                                              child: Text(
                                                "°C",
                                                style: GoogleFonts.poppins(
                                                  color: Color(0xff85b4ea),
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        ])),
                              ),
                              SizedBox(
                                width: 150,
                                height: 70,
                                child: Baseline(
                                  baseline: 10,
                                  baselineType: TextBaseline.alphabetic,
                                  child: Text(
                                    maxLines: 2,
                                    '${snapshot.data!.condition}\n',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 24,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 100),

                      //This Container contains icons and names showing wind speed, humidity and temperature
                      //Row in container contains weather data type and its icon (for e.g wind & wind icon)
                      //data  value is displayed below weather data type with the help of Column
                      Container(
                          width: MediaQuery.sizeOf(context).width / .5,
                          height: 80,
                          decoration: BoxDecoration(
                              color: Color(0xff1a2643),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Wind",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 15,
                                            )),
                                        SizedBox(width: 5.0),
                                        Icon(
                                          Icons.air_sharp,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                    Text("${snapshot.data!.windspeed}",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 50, width: 2, color: Colors.black),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Temperature",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 15,
                                            )),
                                        Icon(Icons.thermostat,
                                            color: Colors.white)
                                      ],
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text:
                                                "${snapshot.data!.temperature}",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14,
                                            ),
                                            children: [
                                          WidgetSpan(
                                            child: Transform.translate(
                                              offset: const Offset(2, -5),
                                              child: Text(
                                                "°C",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          )
                                        ])),
                                  ],
                                ),
                              ),
                              Container(
                                  height: 50, width: 2, color: Colors.black),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text("Humidity",
                                            style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 15,
                                            )),
                                        Icon(Icons.water_drop,
                                            color: Colors.white, size: 15)
                                      ],
                                    ),
                                    Text("${snapshot.data!.humidity}%",
                                        style: GoogleFonts.poppins(
                                          color: Colors.white,
                                          fontSize: 14,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
