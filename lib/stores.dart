import 'package:sqlite_flutter_crud/database.dart';
import 'package:sqlite_flutter_crud/login.dart';
import 'package:sqlite_flutter_crud/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  @override
  void initState() {
    super.initState();
  }
  void addInitialStore() {
    cubit_App.get(context).insert_database_home(
      name: "Pizza King",
      image: "Pizza.jpeg",
      city: "Helwan",
    );
    cubit_App.get(context).get_data_stores(); // Refresh the data after insertion
  }

  @override
  Widget build(BuildContext context) {
    IconData fav = Icons.favorite_border;
    bool f = false;

    return BlocConsumer<cubit_App, states_App>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Stores",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text("Logout"),
                                content: const Text("Do you want to logout?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push<void>(
                                          context,
                                          MaterialPageRoute<void>(
                                            builder:
                                                (BuildContext context) =>
                                                login(),
                                          ),
                                        );
                                      },
                                      child: const Text("Yes")),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("No"))
                                ],
                              ));
                        },
                        icon: const Icon(
                          Icons.logout,
                        ))
                  ],
                ),
                Expanded(
                  child: cubit_App.get(context).stores_data.isEmpty
                      ? const Center(
                    child: CircularProgressIndicator(),
                  )
                      : ListView.separated(
                    itemCount: cubit_App.get(context).stores_data.length,
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.cyan[300],
                            borderRadius: BorderRadius.circular(15)),
                        height: 150,
                        child: Center(
                          child: ListTile(
                            title: Text(
                                "${cubit_App.get(context).stores_data[index]["name"]}"),
                            leading: CircleAvatar(
                                backgroundImage: AssetImage(
                                    "${cubit_App.get(context).stores_data[index]["image"]}")),
                            subtitle: Text(
                                "${cubit_App.get(context).stores_data[index]["city"]}"),
                            trailing: IconButton(
                                onPressed: () {
                                  print("Ahmed");
                                  cubit_App
                                      .get(context)
                                      .favorite_data
                                      .forEach((element) {
                                    if (element["name"] ==
                                        cubit_App
                                            .get(context)
                                            .stores_data[index]["name"]) {
                                      f = true;
                                    }
                                  });
                                  if (f == false) {
                                    cubit_App.get(context).inseart_database_fav(
                                        name:
                                        "${cubit_App.get(context).stores_data[index]["name"]}",
                                        image:
                                        "${cubit_App.get(context).stores_data[index]["image"]}",
                                        city:
                                        "${cubit_App.get(context).stores_data[index]["city"]}");
                                    cubit_App.get(context).get_data_fav();
                                  } else {
                                    print("Rashe");
                                  }
                                },
                                icon: Icon(
                                  fav,
                                  color: Colors.black,
                                )),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });
  }
}
