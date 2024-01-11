import 'package:flutter/material.dart';
import 'package:fudee/provider/restaurant_provider.dart';
import 'package:fudee/ui/resto_detail_screen.dart';
import 'package:provider/provider.dart';

class RestoListScreen extends StatelessWidget {
  const RestoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Restaurants",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () async {
              final String? query = await showSearch(
                context: context,
                delegate: RestaurantSearchDelegate(),
              );
              if (query != null && query.isNotEmpty) {
                Provider.of<RestaurantProvider>(context, listen: false)
                    .searchRestaurant(query);
              }
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child:
                    Consumer<RestaurantProvider>(builder: (context, state, _) {
                  if (state.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.state == ResultState.hasData) {
                    {
                      return ListView.builder(
                          itemCount: state.result.restaurants.length,
                          itemBuilder: (context, index) {
                            var restaurant = state.result.restaurants[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return RestoDetailScreen(id: restaurant.id);
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
                    }
                  } else if (state.state == ResultState.noData) {
                    return Center(
                      child: Material(
                        child: Center(
                            child: Text(
                          state.message,
                          style: const TextStyle(fontSize: 20),
                        )),
                      ),
                    );
                  } else if (state.state == ResultState.error) {
                    return Center(
                      child: Material(
                        child:
                            Text(state.message, style: const TextStyle(fontSize: 20)),
                      ),
                    );
                  } else {
                    return const Center(
                      child: Material(
                        child: Text(''),
                      ),
                    );
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

class RestaurantSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, ''));
  }

  @override
  Widget buildResults(BuildContext context) {
    Provider.of<RestaurantProvider>(context, listen: false)
        .searchRestaurant(query);

    return Consumer<RestaurantProvider>(
      builder: (context, state, child) {
        if (state.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return ListTile(
                title: Text(restaurant.name),
                subtitle: Text(restaurant.city),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RestoDetailScreen(id: restaurant.id);
                  }));
                },
              );
            },
          );
        } else if (state.state == ResultState.noData) {
          return const Center(child: Text('No restaurants found.'));
        } else if (state.state == ResultState.error) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text(''));
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
