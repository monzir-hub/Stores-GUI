// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, unused_local_variable

import 'package:sqlite_flutter_crud/database.dart';
import 'package:sqlite_flutter_crud/login.dart';
import 'package:sqlite_flutter_crud/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class distance extends StatelessWidget {
  distance({super.key});
  Map<String, List<double>> latlang = {
    "Helwan": [29.845400, 31.337151],
    "6 Octobar": [30.562120, 31.788839],
    "Egypt Mall": [29.967590, 30.968330],
    "City Mall": [30.364361, 30.506901]
  };
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit_App, states_App>(
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Distance",
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
                                              builder: (BuildContext context) =>
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
                child: ((cubit_App.get(context).servicse == false) ||
                        (cubit_App.get(context).per ==
                            LocationPermission.denied))
                    ? Center(
                        child: Text("check Permission and Open Loaction"),
                      )
                    : ListView.separated(
                        itemCount: cubit_App.get(context).favorite_data.length,
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
                                    "Distance : ${(Geolocator.distanceBetween(cubit_App.get(context).current!.latitude, cubit_App.get(context).current!.longitude, latlang["${cubit_App.get(context).favorite_data[index]["city"]}"]![0], latlang["${cubit_App.get(context).favorite_data[index]["city"]}"]![1]) / 1000).round()} K"),
                              ),
                            ),
                          );
                        },
                      ),
              )
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
