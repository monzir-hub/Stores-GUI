import 'package:sqlite_flutter_crud/database.dart';
import 'package:sqlite_flutter_crud/login.dart';
import 'package:sqlite_flutter_crud/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                      "Favorites ",
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
                          itemCount:
                              cubit_App.get(context).favorite_data.length,
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              decoration: BoxDecoration(
                                  color: Colors.cyan,
                                  borderRadius: BorderRadius.circular(15)),
                              height: 150,
                              child: Center(
                                child: ListTile(
                                  title: Text(
                                      "${cubit_App.get(context).favorite_data[index]["name"]}"),
                                  leading: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          "${cubit_App.get(context).favorite_data[index]["image"]}")),
                                  subtitle: Text(
                                      "${cubit_App.get(context).favorite_data[index]["city"]}"),
                                  trailing: IconButton(
                                      onPressed: () {
                                        cubit_App.get(context).delete_data(
                                            "${cubit_App.get(context).favorite_data[index]["name"]}");
                                        cubit_App.get(context).get_data_fav();
                                      },
                                      icon: const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
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
