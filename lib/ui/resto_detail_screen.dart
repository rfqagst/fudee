import 'package:flutter/material.dart';
import 'package:fudee/data/api/api_service.dart';
import 'package:fudee/data/model/resto_detail.dart';

class RestoDetailScreen extends StatefulWidget {
  final String id;
  const RestoDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<RestoDetailScreen> createState() => _RestoDetailScreenState();
}

class _RestoDetailScreenState extends State<RestoDetailScreen> {
  late Future<RestoDetail> _restoDetail;

  @override
  void initState() {
    super.initState();
    _restoDetail = ApiService().getRestoDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FutureBuilder<RestoDetail>(
            future: _restoDetail,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text('Loading...'); // Display loading indicator
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (snapshot.hasData) {
                return Text(snapshot.data!.restaurant.name);
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
        body: FutureBuilder<RestoDetail>(
          future: _restoDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final restaurant = snapshot.data!.restaurant;
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
            } else {
              return const Text('No Data');
            }
          },
        ),
      ),
    );
  }
}
