import 'package:ayur/provider/scheduleprovider.dart';
import 'package:ayur/util/utility.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class ScheduleScreen extends StatefulWidget {
  static const routeName = '/schedulescreen';

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  TextEditingController textEditingController = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();

  DateTime dateTime = DateTime.now();
  bool isLoading = false;

  Future pickDateTime(BuildContext context) async {
    DateTime? date = await showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: dateTime.hour, minute: dateTime.minute));
    setState(() {
      dateTime =
          DateTime(date!.year, date.month, date.day, time!.hour, time.minute);
    });
  }

  void checkMedicine() async {
    setState(() {
      isLoading = true;
    });
    await Provider.of<Scheduleprovider>(context, listen: false).scheduleMed();
    setState(() {
      isLoading = false;
    });
    textEditingController.clear();
    textEditingController2.clear();
    Utility.showSnackbar(context, "Medicine Scheduled");
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Meds'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            width: double.infinity,
            child: Column(children: [
              SizedBox(
                height: 230,
                width: double.infinity,
                child: Center(
                  child: Lottie.asset('assets/images/medlot.json'),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextField(
                showCursor: true,
                controller: textEditingController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.medication_rounded, size: 18),
                  labelText: "Medicine name",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 120,
                clipBehavior: Clip.hardEdge,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 255, 240, 193)),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xff431499)),
                        child: Row(children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 14),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.MMM().format(dateTime),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Rubik',
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  DateFormat.d().format(dateTime),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Rubik',
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber),
                                )
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            width: 3,
                            color: Colors.white,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat.EEEE().format(dateTime),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Rubik',
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  DateFormat.jm().format(dateTime),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: 'Rubik',
                                      color: Colors.amber),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 26),
                      child: GestureDetector(
                        onTap: (() => pickDateTime(context)),
                        child: const Icon(
                          Icons.edit_calendar_outlined,
                          size: 34,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                showCursor: true,
                controller: textEditingController2,
                keyboardType: TextInputType.text,
                maxLines: 6,
                decoration: const InputDecoration(
                  labelText: "Medicine description",
                  labelStyle: TextStyle(
                    color: Colors.grey,
                  ),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () => checkMedicine(),
                child: isLoading
                    ? Container(
                        child: const CircularProgressIndicator(
                            color: Colors.black))
                    : const Text(
                        'Schedule medicine',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                style: ElevatedButton.styleFrom(fixedSize: Size(400, 50)),
              ),
            ])),
      ),
    );
  }
}
