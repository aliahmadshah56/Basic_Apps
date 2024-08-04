// lib/country_selection_page.dart
import 'package:flutter/material.dart';
import 'home_page.dart'; // Ensure this path is correct

class CountrySelectionPage extends StatefulWidget {
  const CountrySelectionPage({super.key});

  @override
  State<CountrySelectionPage> createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  String? selectedCountry = 'us'; // Default country code

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
        title: Text('Select Country'),
      ),
      body: DropdownButton<String>(
          value: selectedCountry,
          onChanged: (String? newValue) {
            setState(() {
              selectedCountry = newValue;
            });
            if (selectedCountry != null && countryCodes.contains(selectedCountry)) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(country: selectedCountry!),
                ),
              );
            }
          },
          items: countryCodes.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(_getCountryName(value)),
            );
          }).toList(),
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
