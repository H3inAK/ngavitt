import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/counrty_status.dart';
import '../providers/counrties_provider.dart';
import '../widgets/countries/country_item.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = 'search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController textEditingController = TextEditingController();
  var _countries = List<CountryStatus>();
  var _backupCountries = List<CountryStatus>();
  var _isQueryEmpty = true;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      _countries =
          Provider.of<CountriesProvider>(context, listen: false).countries;
      _backupCountries.addAll(_countries);
    });
    super.initState();
  }

  void _filterSearchResult(String query) {
    List<CountryStatus> dummySearchList = List<CountryStatus>();
    if (dummySearchList.isNotEmpty) dummySearchList.clear();
    dummySearchList.addAll(_backupCountries);

    if (query.isNotEmpty) {
      // .. do search for countries
      // print(query);
      List<CountryStatus> dummyListData = List<CountryStatus>();
      dummySearchList.forEach((item) {
        if (item.countryName.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
        setState(() {
          _isQueryEmpty = false;
          _countries.clear();
          _countries.addAll(dummyListData);
        });
      });
    } else {
      // .. clear rendered countries
      setState(() {
        _isQueryEmpty = true;
        _countries.clear();
      });
    }
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.2,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            width: MediaQuery.of(context).size.width * 0.75,
            child: TextField(
              onChanged: (value) => _filterSearchResult(value),
              controller: textEditingController,
              autofocus: true,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.black),
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 4),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black26,
                ),
                hintText: "search country by name .....",
                hintStyle: const TextStyle(color: Colors.black38),
                fillColor: Colors.grey[100],
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                textEditingController.clear();
                _isQueryEmpty = true;
              });
            },
          ),
        ],
      ),
      body: _isQueryEmpty
          ? Container()
          : _countries.isEmpty
              ? Center(
                  child: Text("No Countries Founded!"),
                )
              : ListView.builder(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                    bottom: 5,
                  ),
                  itemBuilder: (ctx, i) {
                    return CountryItem(_countries[i]);
                  },
                  itemCount: _countries.length,
                ),
    );
  }
}
