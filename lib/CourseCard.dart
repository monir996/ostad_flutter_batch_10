import 'package:assignment_02_ostad10/utils/ResponsiveFontSize.dart';
import 'package:assignment_02_ostad10/widgets/createChip.dart';
import 'package:flutter/material.dart';

class CourseCard extends StatelessWidget {
  final Map<String, String> course;
  final double screenWidth;
  const CourseCard(this.course, this.screenWidth, {super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = screenWidth < 768;

    return Card(
      elevation: 4,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          AspectRatio(
            aspectRatio: 16/9,
            child: Image.asset(
              'assets/flags/${course['flag']}',
              fit: BoxFit.cover,
            ),
          ),


          Container(
            color: const Color(0xFFF5F5F5),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                  child: Row(
                    children: [
                      if (!isMobile)
                        createChip(Icons.group, 'ব্যাচ ${course['batch']}'),
                      if (!isMobile) const SizedBox(width: 4),
                      createChip(Icons.event_seat, course['seats']!),
                      const SizedBox(width: 4),
                      createChip(Icons.schedule, course['days']!),
                    ],
                  ),
                ),
                const Divider(thickness: 1, height: 1),
              ],
            ),
          ),


          Padding(

            padding: EdgeInsets.all(10),
            child: Text(
              course['title']!,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: ResponsiveFontSize.getTitleFontSize(screenWidth)
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          Spacer(),

          Container(
            color: const Color(0xFFF5F5F5),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ElevatedButton.icon(
              onPressed: (){},
              label: Text(
                "বিস্তারিত দেখুন",
                style: TextStyle(fontSize: ResponsiveFontSize.getButtonFontSize(screenWidth), fontWeight: FontWeight.bold),
              ),
              icon: const Icon(Icons.arrow_forward, size: 16),
              iconAlignment: IconAlignment.end,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE6E5E5),
                foregroundColor: Colors.black87,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}