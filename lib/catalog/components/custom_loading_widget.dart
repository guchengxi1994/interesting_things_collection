import 'package:flutter/material.dart';
import 'package:weaving/gen/strings.g.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15), color: Colors.white),
      child: FittedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 80,
              width: 100,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            SizedBox(
              height: 30,
              child: Text(t.dialogs.loading),
            )
          ],
        ),
      ),
    );
  }
}
