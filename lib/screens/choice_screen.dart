import 'package:flutter/material.dart';
import 'package:grid_selector/base_grid_selector_item.dart';
import 'package:grid_selector/grid_selector.dart';
import 'package:watch_list/tools/globals.dart';

class ChoiceScreen extends StatefulWidget {
  @override
  _ChoiceScreenState createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text("Preferences"),
        //centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            child: Column(
              children: <Widget>[
                GridSelector<int>(
                  backgroundSelectedColor: Color(0xFFE31B25),
                  selectedItemKey: typeChoice,
                  title: "Type",
                  items: _getType(),
                  itemSize: 80,
                  onSelectionChanged: (option) {
                    setState(() {
                      typeChoice = option;
                      print(typeChoice);
                    });
                  },
                ),
                _buildDivider(),
                GridSelector<int>(
                  selectedItemKey: sortChoice,
                  backgroundSelectedColor: Color(0xFFE31B25),
                  title: "Sort By",
                  items: _getSort(),
                  onSelectionChanged: (option) {
                    setState(() {
                      sortChoice = option;
                      print(sortChoice);
                    });
                  },
                  itemSize: 150,
                ),
                _buildDivider(),
                RaisedButton(
                  onPressed: () {
                    if ((typeChoice != null && sortChoice != null) &&
                        !(typeChoice == 2 && sortChoice == 4)) {
                      Navigator.pushReplacementNamed(context, "/main");
                    } else {
                      showSnackBar(
                          scaffoldKey: scaffoldKey,
                          message: "Please make a proper choice.");
                    }
                  },
                  child: const Text("Let's Discover!",
                      style: TextStyle(fontSize: 20)),
                  color: Colors.grey,
                  textColor: Colors.white,
                  elevation: 5,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 32.0,
      ),
      child: Divider(
        height: 2,
        color: Colors.grey,
      ),
    );
  }

  List<BaseGridSelectorItem> _getType() {
    return [
      BaseGridSelectorItem(key: 1, label: "Movies"),
      BaseGridSelectorItem(key: 2, label: "TV Shows"),
    ];
  }

  List<BaseGridSelectorItem> _getSort() {
    return [
      BaseGridSelectorItem(
          key: 1,
          label: "Popularity",
          isEnabled: (typeChoice == null) ? false : true),
      BaseGridSelectorItem(
          key: 2,
          label: "Release Date",
          isEnabled: (typeChoice == null) ? false : true),
      BaseGridSelectorItem(
          key: 3,
          label: "Rating",
          isEnabled: (typeChoice == null) ? false : true),
      BaseGridSelectorItem(
          key: 4,
          label: "Revenue",
          isEnabled: (typeChoice == 2 || typeChoice == null) ? false : true),
    ];
  }
}

showSnackBar({final scaffoldKey, String message}) {
  scaffoldKey.currentState.showSnackBar(SnackBar(
    backgroundColor: Colors.grey,
    content: Text(message),
  ));
}
