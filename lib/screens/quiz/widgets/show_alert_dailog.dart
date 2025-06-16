import 'package:app_b_804/app_resource/app_strings.dart';
import 'package:flutter/material.dart';

Future<bool> showExitQuizDialog(BuildContext context) async {
  return await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
        title: const Text(
          AppStrings.exit,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        content: const Text(
          AppStrings.alertExitContent,
          style: TextStyle(
            fontSize: 13,
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
        titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
        actionsPadding: EdgeInsets.zero,
        actions: <Widget>[
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 0.5,
                color: Colors.grey.shade300,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(14.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        AppStrings.cancel,
                        style: TextStyle(
                          color: Color(0xFF007AFF),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  Container(
                    width: 0.5,
                    height: 44,
                    color: Colors.grey.shade300,
                  ),
                  Expanded(
                    child: TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(14.0),
                          ),
                        ),
                      ),
                      child: const Text(
                        AppStrings.exit,
                        style: TextStyle(
                          color: Color(0xFFFF3B30),
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      onPressed: () => Navigator.of(context).pop(true),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    },
  ) ?? false;
}