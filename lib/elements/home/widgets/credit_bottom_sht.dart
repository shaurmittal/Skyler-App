import 'package:findmyngo/constants/color_constants.dart';
import 'package:findmyngo/utils/size/size_config.dart';
import 'package:flutter/material.dart';

class CreditBottomSheet extends StatelessWidget {
  final void Function() onDone;
  const CreditBottomSheet({super.key, required this.onDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 4000,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: ColorConstants.lightGreen,
          border: Border.all(
            color: ColorConstants.darkGreen,
            width: SizeConfig.getPercentSize(0.7),
          ),
          borderRadius: BorderRadius.circular(
            SizeConfig.getPercentSize(9),
          ),
          boxShadow: [
            BoxShadow(
              color: ColorConstants.darkGreen,
              offset: Offset(
                SizeConfig.getPercentSize(-1.5),
                SizeConfig.getPercentSize(-1.5),
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Credit System',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: onDone,
                ),
              ],
            ),
            const SizedBox(height: 15.0), // Space between heading and text

            // Explanation text with tick icon

            _buildListItem('Welcome to the challenge!'),
            SizedBox(
              height: 10,
            ),
            _buildListItem(
                'Every NGO strives to be the best, now its your turn!'),
            SizedBox(
              height: 10,
            ),
            _buildListItem('On the missions tab, find missions weekly.'),
            SizedBox(
              height: 10,
            ),
            _buildListItem('Once you complete them, you earn a point.'),
            SizedBox(
              height: 10,
            ),
            _buildListItem('Once you complete ten missions, you earn a gem.'),
            SizedBox(
              height: 10,
            ),
            _buildListItem(
                'Use these gems to earn incentives for helping the community!'),
            // Space before buttons
          ],
        ),
      ),
    );
  }
}

Widget _buildListItem(String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Icon(
        Icons.check,
        color: Colors.grey,
        size: 20,
      ),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black,
          ),
        ),
      ),
    ],
  );
}
