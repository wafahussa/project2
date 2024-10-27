import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  List<String> streetNames = [
    'Quraish Street',
    'Hira Street',
    'King Fahad Road',
    'King Abdulaziz Road',
    'Palestine Street',
    'Prince Sultan Road',
    'Al Madinah Road',
    'Sari Street',
    'Tahlia Street',
    'Prince Majed Road'
  ];

  int currentTripNumber = 1;

  @override
  void initState() {
    super.initState();
    _getLastTripNumber();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    _searchController.dispose();
    super.dispose();
  }

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
              primary: Colors.blue,
              onPrimary: Colors.white,
              onSurface: Colors.black,
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

  Future<void> _getLastTripNumber() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('Trips')
        .orderBy('TripNumber', descending: true)
        .limit(1)
        .get();

    setState(() {
      if (snapshot.docs.isNotEmpty) {
        currentTripNumber = snapshot.docs.first['TripNumber'] + 1;
      } else {
        currentTripNumber = 1;
      }
    });
  }

  Future<void> _addSingleTripToFirestore() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Trips').get();
      if (snapshot.docs.isEmpty) {
        setState(() {
          currentTripNumber = 1;
        });
      }

      String formattedDate = DateFormat('dd/MM/yyyy').format(DateTime.now());
      String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());

      final selectedStreets =
          (streetNames.toList()..shuffle()).take(3).toList();

      DocumentReference tripRef =
          await FirebaseFirestore.instance.collection('Trips').add({
        'Name': 'Trip Number $currentTripNumber',
        'TripNumber': currentTripNumber,
        'Date': formattedDate,
        'Time': formattedTime,
        'Streets': selectedStreets,
      });

      await tripRef.update({'TripID': tripRef.id});

      setState(() {
        currentTripNumber++;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Trip successfully added")),
      );
    } catch (e) {
      print("Error adding trip: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error adding trip")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 45, left: 10, right: 10),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 7),
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
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _startDateController,
                            decoration: InputDecoration(
                              hintText: 'dd/mm/yyyy',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            onTap: () => _selectDate(context, true),
                            readOnly: true,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text('To '),
                        Expanded(
                          child: TextField(
                            controller: _endDateController,
                            decoration: InputDecoration(
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
                    SizedBox(height: 5),
                    ElevatedButton(
                      onPressed: () {
                        // Implement search functionality here
                      },
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
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Trips')
                    .orderBy('TripNumber')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Text("No trips found");
                  }

                  final trips = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: trips.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final trip = trips[index];
                      return Card(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          leading:
                              Icon(Icons.folder, size: 46, color: Colors.blue),
                          title: Text(trip['Name']),
                          subtitle: Text(
                            " Date: ${trip['Date']} \nTime: ${trip['Time']}",
                            style: TextStyle(
                              fontSize: 11.5,
                              color: Colors.grey[700],
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed('Listofreports');
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSingleTripToFirestore,
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
