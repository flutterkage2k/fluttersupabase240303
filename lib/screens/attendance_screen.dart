import 'package:flutter/material.dart';
import 'package:fluttersupabase240303/models/user_model.dart';
import 'package:fluttersupabase240303/services/db_service.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act/slide_to_act.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<SlideActionState> key = GlobalKey<SlideActionState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: const Text(
              "Welcome",
              style: TextStyle(color: Colors.black54, fontSize: 30),
            ),
          ),
          Consumer<DbService>(builder: (context, dbService, child) {
            return FutureBuilder(
                future: dbService.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    UserModel user = snapshot.data!;

                    return Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        user.name != '' ? user.name : "#${user.employeeId}",
                        style: const TextStyle(fontSize: 25),
                      ),
                    );
                  }

                  return const SizedBox(
                    width: 60,
                    child: LinearProgressIndicator(),
                  );
                });
          }),
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(top: 32),
            child: const Text(
              "Today's Status",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 32),
            height: 150,
            decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(2, 2),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Check In',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Divider(),
                      ),
                      Text(
                        "09:30",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Check Out',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: Divider(),
                      ),
                      Text(
                        "--/--",
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              DateFormat("yyyy MMMM dd").format(DateTime.now()),
              style: TextStyle(fontSize: 20),
            ),
          ),
          StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1)),
              builder: (context, snapshot) {
                return Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat("hh:mm:ss a").format(DateTime.now()),
                    style: const TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                );
              }),
          Container(
            margin: const EdgeInsets.only(top: 25),
            child: Builder(
              builder: (context) {
                return SlideAction(
                  text: "Slide to Check Out",
                  textStyle: const TextStyle(
                    color: Colors.black54,
                    fontSize: 18,
                  ),
                  outerColor: Colors.white,
                  innerColor: Colors.redAccent,
                  key: key,
                  onSubmit: () {
                    key.currentState!.reset();
                    return null;
                  },
                );
              },
            ),
          )
        ],
      ),
    ));
  }
}
