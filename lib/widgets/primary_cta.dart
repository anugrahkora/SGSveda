import 'package:flutter/material.dart';

Container primaryButton(
    {required String label,
    required bool isLoading,
    double? width,
    required void Function()? onpressed}) {
  return Container(
    height: 50,
    width: width ?? 380,
    decoration: BoxDecoration(
        color: const Color(0xffff6933), borderRadius: BorderRadius.circular(5)),
    child: TextButton(
      onPressed: onpressed,
      child: isLoading
          ? const Center(
              child: AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ))
          : Text(
              label,
              style: const TextStyle(
                  color: Color(0xffffffff),
                  fontFamily: 'Metropolis',
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
    ),
  );
}
