import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:veda_nidhi_v2/widgets/primary_cta.dart';

class NoInternetViewScreen extends StatelessWidget {
  const NoInternetViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/no_internet_icon.svg'),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'Ooops!',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16.0,
            ),
            Text(
              'No Internet Connection',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(
              height: 16.0,
            ),
            primaryButton(
              label: 'Try Again',
              isLoading: false,
              onpressed: () {},
              width: width * 0.6,
            )
          ],
        ),
      )),
    );
  }
}
