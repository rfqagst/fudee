import 'package:flutter/material.dart';
import 'package:fudee/model/resto_data.dart';
import 'package:fudee/resto_detail_screen.dart';

class RestoListScreen extends StatelessWidget {
  const RestoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Column(
                children: [
                  Text(
                    "Restaurants",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    "Recomendation Restaurant for you",
                    style: TextStyle(fontSize: 15),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
              Expanded(
                child: FutureBuilder<String>(
                    future: DefaultAssetBundle.of(context)
                        .loadString('assets/resto.json'),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(
                          child: Text("Tidak Ada data"),
                        );
                      }
                      final RestoData restoData =
                          restoDataFromJson(snapshot.data!);
                      return ListView.builder(
                          itemCount: restoData.restaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = restoData.restaurants[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RestoDetailScreen(
                                      restaurant: restaurant);
                                }));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 15.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Hero(
                                      tag: restaurant.pictureId,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          restaurant.pictureId,
                                          width: 120,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                restaurant.name,
                                                style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.place,
                                                size: 18,
                                                color: Colors.green,
                                              ),
                                              Text(
                                                restaurant.city,
                                                style: const TextStyle(
                                                    fontSize: 16.0),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.star,
                                                  size: 18,
                                                  color: Colors.amber),
                                              Text(
                                                  restaurant.rating.toString()),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
