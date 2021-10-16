import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Models/routes.dart';

import '../../Provider/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.add_places);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).fetchPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text("Got no places yet. Start adding some places."),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.isEmpty
                    ? ch
                    : ListView.builder(
                        itemCount: greatPlaces.items.length,
                        itemBuilder: (ctx, i) => Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                greatPlaces.items[i].image,
                              ),
                              radius: 30,
                            ),
                            title: Text(greatPlaces.items[i].title),
                            subtitle: Text(
                              "${greatPlaces.items[i].location.latitude}, ${greatPlaces.items[i].location.longitude}",
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                Routes.place_detail,
                                arguments: greatPlaces.items[i].id,
                              );
                            },
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
