import 'package:flutter/material.dart';
import 'package:fudee/model/resto_data.dart';

class RestoDetailScreen extends StatelessWidget {
  final Restaurant restaurant;
  const RestoDetailScreen({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Hero(
                  tag: restaurant.pictureId,
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        restaurant.pictureId,
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
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Description",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  restaurant.description,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Menus",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
                              .drinks[index - restaurant.menus.foods.length]
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
        ),
      ),
    );
  }
}

// class RestaurantImage extends StatelessWidget {
//   final String pictureUrl;

//   const RestaurantImage(this.pictureUrl);

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// class RestaurantInfo extends StatelessWidget {
//   final Restaurant restaurant;

//   const RestaurantInfo({required this.restaurant});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }

// class RestaurantMenus extends StatelessWidget {
//   final Restaurant restaurant;

//   const RestaurantMenus({required this.restaurant});

//   @override
//   Widget build(BuildContext context) {
//     return 
//   }
// }
