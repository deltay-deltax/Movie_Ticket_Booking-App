import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_booking_app/service/constant.dart';

class MovieDetailPage extends StatefulWidget {
  String image, name, shortdetail, moviedetail;
  int price;
  MovieDetailPage({
    super.key,
    required this.image,
    required this.name,
    required this.shortdetail,
    required this.moviedetail,
    required this.price,
  });
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;
  int ticketCount = 1;
  Map<String, dynamic>? paymentIntent;

  List<String> dateList = [];

  final List<String> timeSlots = [
    '08:00 AM',
    '10:30 AM',
    '01:00 PM',
    '03:30 PM',
    '06:00 PM',
    '08:00 PM',
    '10:00 PM',
  ];

  @override
  void initState() {
    super.initState();
    generateNext7Days();
  }

  void generateNext7Days() {
    DateTime today = DateTime.now();
    dateList = List.generate(7, (index) {
      DateTime date = today.add(Duration(days: index));
      return DateFormat('E d').format(date); // e.g., Mon 25
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            widget.image,
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xff1f1f1f),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        widget.shortdetail,
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.moviedetail,
                        style: TextStyle(color: Colors.grey[300]),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Select Date",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: dateList.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedDateIndex == index;
                            return Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isSelected
                                          ? Color(0xfff3c318)
                                          : Colors.grey[800],
                                  foregroundColor:
                                      isSelected ? Colors.black : Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() => selectedDateIndex = index);
                                },
                                child: Text(dateList[index]),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Select Time Slot",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 45,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: timeSlots.length,
                          itemBuilder: (context, index) {
                            bool isSelected = selectedTimeIndex == index;
                            return Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor:
                                      isSelected
                                          ? Color(0xfff3c318)
                                          : Colors.transparent,
                                  foregroundColor:
                                      isSelected ? Colors.black : Colors.white,
                                  side: BorderSide(
                                    color:
                                        isSelected
                                            ? Color(0xfff3c318)
                                            : Colors.grey,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() => selectedTimeIndex = index);
                                },
                                child: Text(timeSlots[index]),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, color: Colors.white),
                                  onPressed: () {
                                    setState(() {
                                      if (ticketCount > 1) ticketCount--;
                                    });
                                  },
                                ),
                                Text(
                                  "$ticketCount",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, color: Colors.white),
                                  onPressed: () {
                                    setState(() => ticketCount++);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xfff3c318),
                              foregroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(
                                horizontal: 30,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              makePayment(
                                (widget.price * ticketCount).toString(),
                              );
                            },
                            child: Text(
                              "Total : \$${ticketCount * widget.price}\nBook Now",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SecretKey', // ✅ use Bearer + your key
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
      rethrow;
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100); // Convert to cents
    return calculatedAmount.toString();
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'USD');

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent?['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'AmazeFilm',
        ),
      );

      await displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception: $e\n$s');
    }
  }

  Future<void> displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance
          .presentPaymentSheet()
          .then((value) async {
            // Show success dialog
            showDialog(
              context: context,
              builder:
                  (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 10),
                            Text("Payment Successful"),
                          ],
                        ),
                      ],
                    ),
                  ),
            );

            paymentIntent = null;
          })
          .onError((error, stackTrace) {
            print("Error is ===> $error $stackTrace");
          });
    } catch (e) {
      print('Exception while displaying payment sheet: $e');
    }
  }
}
