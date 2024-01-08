import 'package:flutter/material.dart';
import 'package:fudee/data/api/api_service.dart';
import 'package:fudee/data/model/resto_data.dart';
import 'package:fudee/ui/resto_detail_screen.dart';

class RestoListScreen extends StatefulWidget {
  const RestoListScreen({Key? key}) : super(key: key);

  @override
  State<RestoListScreen> createState() => _RestoListScreenState();
}

class _RestoListScreenState extends State<RestoListScreen> {
  late Future<RestoData> _restoData;

  @override
  void initState() {
    super.initState();
    _restoData = ApiService().getRestoList();
  }

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
                child: FutureBuilder(
                    future: _restoData,
                    builder: (context, AsyncSnapshot<RestoData> snapshot) {
                      var state = snapshot.connectionState;
                      if (state != ConnectionState.done) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.restaurants.length,
                              itemBuilder: (context, index) {
                                var restaurant =
                                    snapshot.data?.restaurants[index];
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return RestoDetailScreen(
                                          id: restaurant.id);
                                    }));
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Hero(
                                          tag: restaurant!.pictureId,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: Image.network(
                                                'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                                                width: 120,
                                                height: 100,
                                                fit: BoxFit.cover,
                                              )),
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
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                  Text(restaurant.rating
                                                      .toString()),
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
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(snapshot.error.toString()),
                          );
                        } else {
                          return const Material(child: Text(''));
                        }
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
