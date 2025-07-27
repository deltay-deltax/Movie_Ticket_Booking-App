import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/pages/bottomnav.dart';
import 'package:movie_booking_app/pages/home.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // disables default back behavior
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => BottomNav()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: [
              const Center(
                child: Text(
                  'Bookings',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream:
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .collection('bookings')
                          .orderBy('BookedAt', descending: true)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var bookings = snapshot.data!.docs;

                    if (bookings.isEmpty) {
                      return const Center(
                        child: Text(
                          'No bookings yet.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: bookings.length,
                      itemBuilder: (context, index) {
                        var booking = bookings[index];

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 10,
                          ),
                          padding: const EdgeInsets.only(left: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              const SizedBox(height: 15),
                              Center(
                                child: QrImageView(
                                  data: booking['QrId'],
                                  version: QrVersions.auto,
                                  size: 120,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      booking['MovieImage'],
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 20.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.movie,
                                              color: Color(0xffbeb031),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              booking['Movie'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.date_range,
                                              color: Color(0xffbeb031),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              booking['Date'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.access_time,
                                              color: Color(0xffbeb031),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              booking['Time'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.group,
                                              color: Color(0xffbeb031),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "${booking['Tickets']}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 20),
                                            const Icon(
                                              Icons.monetization_on,
                                              color: Color(0xffbeb031),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              "\$${booking['TotalPrice']}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
