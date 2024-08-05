import 'package:flutter/material.dart';
import 'home_page.dart';

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  String? selectedCountry;

  final List<String> countryCodes = [
    'us', // United States
    'cn', // China
    'in', // India
    'jp', // Japan
    'de', // Germany
  ]; // Top 5 countries by population

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Choose a country to get news:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: DropdownButton<String>(
                    value: selectedCountry,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCountry = newValue;
                      });
                      if (selectedCountry != null &&
                          countryCodes.contains(selectedCountry)) {
                        print('Selected Country: $selectedCountry');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(country: selectedCountry!),
                          ),
                        );
                      }
                    },
                    items: countryCodes.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          _getCountryName(value),
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    isExpanded: true,
                    underline: SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getCountryName(String countryCode) {
    switch (countryCode) {
      case 'us': return 'United States';
      case 'cn': return 'China';
      case 'in': return 'India';
      case 'jp': return 'Japan';
      case 'de': return 'Germany';
      default: return 'Unknown';
    }
  }
}
