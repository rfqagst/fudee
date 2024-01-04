import 'package:flutter/material.dart';
import 'package:fudee/model/resto_data.dart';

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
                  Text("Restaurants"),
                  Text("Recomendation Restaurant for you"),
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
                      final RestoData restoData =
                          restoDataFromJson(snapshot.data!);
                      return ListView.builder(
                          itemCount: restoData.restaurants.length,
                          itemBuilder: (context, index) {
                            final restaurant = restoData.restaurants[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      restaurant.pictureId,
                                      width: 120,
                                      height: 100,
                                      fit: BoxFit
                                          .cover, // Sesuaikan dengan kebutuhan
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10.0),
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
                                                size: 18, color: Colors.amber),
                                            Text(restaurant.rating.toString()),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
