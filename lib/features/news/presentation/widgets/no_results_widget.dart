import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newsy_app/core/resources/common/image_resources.dart';

class NoResultsWidget extends StatelessWidget {
  const NoResultsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              ImageResources.iconSearch,
              height: 60,
              colorFilter: ColorFilter.mode(Colors.grey.withOpacity(0.5), BlendMode.srcIn),
            ),
            const SizedBox(height: 16),
            const Text(
              'No results found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Try different keywords',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
