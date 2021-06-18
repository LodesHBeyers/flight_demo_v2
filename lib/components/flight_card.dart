import 'package:flight_demo_v2/helpers/date_time_formatter.dart';
import 'package:flight_demo_v2/viewmodels/flights_view_model.dart';
import 'package:flutter/material.dart';

class FlightCard extends StatelessWidget {
  final FlightViewModel flightViewModel;

  const FlightCard({Key? key, required this.flightViewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final sizes = MediaQuery.of(context).size;
    Map unknownDateTime = {'time': 'Unknown Time', 'date': 'Unknown Date'};

    Map departureDateTime = flightViewModel.departureDateTime != null
        ? formatDateTime(flightViewModel.departureDateTime as DateTime)
        : unknownDateTime;

    Map arrivalDateTime = flightViewModel.arrivalDateTime != null
        ? formatDateTime(flightViewModel.arrivalDateTime as DateTime)
        : unknownDateTime;

    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
        width: sizes.width * .96,
        height: sizes.height * .22,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: Offset(6, 4), color: Colors.black38, blurRadius: 5)
            ],
            color: Color(0xff4B6777)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 24,
                ),
                Text(
                  'Flight: ${flightViewModel.flightNumber}',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff202526)),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Color(0xff202526),
                  size: 24,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: sizes.width * .34,
                  height: sizes.height * .11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        flightViewModel.departureAirport,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(color: Color(0xffa0994b)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            departureDateTime['date'],
                            style: TextStyle(color: Color(0xff202526)),
                          ),
                          Text(
                            departureDateTime['time'],
                            style: TextStyle(color: Color(0xfff0f9ca)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(21),
                          border:
                              Border.all(color: Color(0xffa0994b), width: .5)),
                      child: Icon(
                        Icons.flight_takeoff,
                        color: Color(0xff202526),
                        size: 26,
                      ),
                    )
                  ],
                ),
                Container(
                  width: sizes.width * .34,
                  height: sizes.height * .11,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        flightViewModel.arrivalAirport,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: Color(0xffa0994b)),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            arrivalDateTime['date'],
                            style: TextStyle(color: Color(0xff202526)),
                          ),
                          Text(
                            arrivalDateTime['time'],
                            style: TextStyle(color: Color(0xfff0f9ca)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox()
          ],
        ),
      ),
    );
  }
}
