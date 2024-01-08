import 'package:flutter/material.dart';
import 'package:fudee/provider/restaurant_provider.dart';
import 'package:provider/provider.dart';

class RestoDetailScreen extends StatelessWidget {
  final String id;
  const RestoDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantProvider>(context, listen: false)
        .fetchRestaurantDetails(id);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Text('Loading...'); // Display loading indicator
              } else if (state.state == ResultState.error) {
                return const Text('Error: Tidak dapat memuat data');
              } else if (state.state == ResultState.hasData) {
                return Text(state.resultDetail.restaurant.name);
              } else {
                return Text('No Data');
              }
            },
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Consumer<RestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              final restaurant = state.resultDetail.restaurant;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Hero(
                        tag: restaurant.name,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                              width: 120,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Column(
                            children: <Widget>[
                              Row(
                                children: [
                                  const Icon(
                                    Icons.place,
                                    size: 25,
                                    color: Colors.green,
                                  ),
                                  Text(
                                    restaurant.city,
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                  const SizedBox(width: 10),
                                  const Icon(Icons.star,
                                      size: 25, color: Colors.amber),
                                  Text(
                                    restaurant.rating.toString(),
                                    style: const TextStyle(fontSize: 20.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Description",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        restaurant.description,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Menus",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: restaurant.menus.foods.length +
                              restaurant.menus.drinks.length,
                          itemBuilder: (context, index) {
                            bool isFood = index < restaurant.menus.foods.length;
                            String itemName = isFood
                                ? restaurant.menus.foods[index].name
                                : restaurant
                                    .menus
                                    .drinks[
                                        index - restaurant.menus.foods.length]
                                    .name;
                            IconData iconData =
                                isFood ? Icons.fastfood : Icons.local_drink;

                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 4),
                              child: ListTile(
                                leading: Icon(iconData),
                                title: Text(itemName),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else {
              return const Center(
                child: Material(
                  child: Text(''),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
