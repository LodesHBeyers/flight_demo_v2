
import 'package:flutter/material.dart';

class ConnectionCheckerWrapper extends StatelessWidget {
  final bool hasConnection;
  const ConnectionCheckerWrapper({Key? key, required this.hasConnection}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return AnimatedOpacity(
      opacity: hasConnection? 0: 1,
      duration: Duration(milliseconds: 600),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width*.05, vertical: size.height*.04),
            child: Container(
              height: size.height*.06,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(size.height*.04),
                  border: Border.all(color: Colors.black87)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No internet connection found!',
                    style: TextStyle(
                        fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
