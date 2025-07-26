import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_image/qr_image.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        margin: EdgeInsetsDirectional.only(top: 40.0),

        child: Column(
          children: [
            Center(
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
              child: Container(
                padding: EdgeInsets.only(left: 20.0, top: 20.0, right: 10.0),
                margin: EdgeInsets.only(
                  // top: MediaQuery.of(context).size.height / 2.5,
                  left: 5.0,
                  right: 5.0,
                ),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Color(0xff1e232c),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(color: Colors.white),
                      child: Column(
                        children: [
                          SizedBox(height: 5.0),
                          Center(
                            child: QrImageView(
                              data: 'teusb',
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
                                  'Assets/images/infinity.jpg',
                                  height: 130,
                                  width: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),

                              SizedBox(width: 20.0),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(height: 40),
                                        Icon(
                                          Icons.person,
                                          color: const Color.fromARGB(
                                            255,
                                            190,
                                            176,
                                            49,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Aaditya Gupta',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.movie,
                                          color: const Color.fromARGB(
                                            255,
                                            190,
                                            176,
                                            49,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          'Infinity Wars',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.group,
                                          color: const Color.fromARGB(
                                            255,
                                            190,
                                            176,
                                            49,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          '3',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.monetization_on,
                                              color: const Color.fromARGB(
                                                255,
                                                190,
                                                176,
                                                49,
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Text(
                                              '\$200',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
