import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:weather_app/pages/Home%20Screen/Home_Model.dart';
import '../Weather Screen/Model.dart';
import '../Weather Screen/View.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //bool loading is defined to show loading icon further in screen
  bool loading = false;
  //textediting Controller for  textField
  TextEditingController result = TextEditingController();
  late Box<SearchSave> box1;
  FocusNode _focusNode = FocusNode();
  bool _showSuggestions = false;

  @override
  void initState() {
    super.initState();
    box1 = Hive.box<SearchSave>('search');
    _focusNode.addListener(() {
      setState(() {
        _showSuggestions = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cities = box1.values.toList();
    //unniqueCitites is created to avoid display of duplicate cities
    final uniqueCities = cities.map((e) => e.cityName).toSet().toList();
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Weather App"),
        ),
      ),
      //From Here Our main UI of Screen Starts which contains a text field and button which triggers
      //weather data fetching also it has a container below text field which diplays list of previously searched cities on focus
      body: SafeArea(
        child: loading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(bottom: keyboardHeight),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: result,
                            focusNode: _focusNode,
                            decoration: InputDecoration(
                              hintText: 'Enter city name',
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                          ),
                          if (_showSuggestions)
                            Container(
                              height: 200 - keyboardHeight > 0
                                  ? 200 - keyboardHeight
                                  : keyboardHeight - 120,
                              child: ListView.builder(
                                itemCount: uniqueCities.length,
                                itemBuilder: (context, index) {
                                  final city = uniqueCities[index];
                                  return ListTile(
                                    title: Text(city),
                                    onTap: () {
                                      setState(() {
                                        result.text = city;
                                        _showSuggestions = false;
                                        _focusNode.unfocus();
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String city = result.text.trim();
                        if (city.isEmpty) {
                          // This will Show an error if the city name is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please enter a city name')),
                          );
                          return;
                        }
                        setState(() {
                          loading = true;
                        });

                        try {
                          WeatherDetails weatherDetails =
                              await fetchWeather(city);
                          final searchSave = SearchSave(city);
                          await box1.add(searchSave);
                          setState(() {
                            loading = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => WeatherScreen(location: city),
                            ),
                          );
                        } catch (e) {
                          print(e);
                          Text("$e"); //Error Handling
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Failed to load weather')),
                          );
                        }
                      },
                      child: Text("Lets check it's weather!",
                          style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        minimumSize:
                            Size(MediaQuery.sizeOf(context).width / 2, 50),
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
