import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:veda_nidhi_v2/controllers/error_status_controller.dart';
import 'package:veda_nidhi_v2/controllers/otp_view_controller.dart';
import 'package:veda_nidhi_v2/widgets/primary_cta.dart';

class OtpViewScreen extends StatefulWidget {
  final String phoneNumber;
  final String code;
  const OtpViewScreen(
      {super.key, required this.phoneNumber, required this.code});

  @override
  State<OtpViewScreen> createState() => _OtpViewScreenState();
}

class _OtpViewScreenState extends State<OtpViewScreen> {
  final controller = Get.find<OtpViewController>();
  final errorController = Get.find<ErrorStatusController>();
  final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff8f95a6)),
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ));
  @override
  void initState() {
    controller.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "OTP Verification",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("OTP has been sent to your phone number",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: const Color(0xff515869),
                        )),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 45, left: 45, right: 45),
                child: Pinput(
                  defaultPinTheme: defaultPinTheme,
                  length: 6,
                  onChanged: ((value) {
                    controller.setOtp(value);
                  }),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Align(
                alignment: Alignment.center,
                child: Obx(
                  () => Text(errorController.error,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: const Color.fromARGB(255, 238, 0, 0),
                          )),
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(
                    left: 80,
                    top: 55,
                  ),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Didn't receive the OTP ?",
                      style: TextStyle(
                          color: Color(0xff515869),
                          fontFamily: 'Metropolis',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 55, right: 0, left: 0),
                  child: Obx(
                    () => Align(
                      alignment: Alignment.centerLeft,
                      child: controller.isResentLoading
                          ? const Padding(
                              padding: EdgeInsets.all(6.0),
                              child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                      child: CircularProgressIndicator())),
                            )
                          : Obx(
                              () => TextButton(
                                onPressed: controller.isResentEnabled
                                    ? () async {
                                        await controller.resentOtp(
                                            phoneNumber: widget.phoneNumber,
                                            countryCode: widget.code);
                                      }
                                    : null,
                                child: Obx(
                                  () => Text(
                                    controller.isResentEnabled
                                        ? "Resend"
                                        : "${controller.seconds}",
                                    style: const TextStyle(
                                        color: Color(0xff141a39),
                                        fontFamily: 'Metropolis',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: primaryButton(
                  label: 'Verify',
                  isLoading: controller.loading,
                  onpressed: () async {
                    await controller.verifyOtp(widget.phoneNumber);
                  }),
            )),
          ],
        ),
      ),
    );
  }
}
