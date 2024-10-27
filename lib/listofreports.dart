import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_2/ReportPage.dart';
import 'package:flutter_application_2/pdf_creator.dart';

class Listofreports extends StatelessWidget {
  const Listofreports({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Reports',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('Trips')
              .orderBy('TripNumber')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("No trips found"));
            }

            final trips = snapshot.data!.docs;

            return ListView.builder(
              itemCount: trips.length,
              itemBuilder: (context, index) {
                final trip = trips[index];

                List<String> streetNames = List<String>.from(trip['Streets']);

                List<String> displayedStreets = streetNames.length >= 3
                    ? streetNames.take(3).toList()
                    : streetNames;

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      Icons.description,
                      size: 46,
                      color: Colors.blue,
                    ),
                    title: Text(displayedStreets.join(', ')),
                    subtitle: Text(
                      "Date: ${trip['Date']}\nTime: ${trip['Time']}",
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    onTap: () async {},
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
