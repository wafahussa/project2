// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_application_2/createFoldar.dart';
import 'package:intl/intl.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageScreenState createState() => _ReportPageScreenState();
}

class _ReportPageScreenState extends State<ReportPage> {
  String? selectedStatus;
  DateTime? startDate;
  DateTime? endDate;
  final TextEditingController _searchController = TextEditingController();

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // body text color
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      setState(() {
        if (isStartDate) {
          startDate = picked;
          _startDateController.text = formattedDate;
        } else {
          endDate = picked;
          _endDateController.text = formattedDate;
        }
      });
    }
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        // Allows vertical scrolling
        child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 7,
                    ),
                    TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Street Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _startDateController,
                            decoration: InputDecoration(
                              hintText: 'dd/mm/yyyy',
                              //labelText: 'From Date',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onTap: () => _selectDate(context, true),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          ' To  ',
                        ), // Added space between fields
                        Expanded(
                          child: TextField(
                            controller: _endDateController,
                            decoration: InputDecoration(
                              //  labelText: 'To Date',
                              hintText: 'dd/mm/yyyy',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onTap: () => _selectDate(context, false),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[400],
                      ),
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Foldar(
                TripNo: 'Trip No.1',
                onPressed: () {
                  Navigator.of(context).pushNamed('Listofreports');
                },
              ),
              Foldar(
                TripNo: 'Trip No.2',
                onPressed: () {
                  Navigator.of(context).pushNamed('Listofreports');
                },
              ),
              Foldar(
                TripNo: 'Trip No.3',
                onPressed: () {
                  Navigator.of(context).pushNamed('Listofreports');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
