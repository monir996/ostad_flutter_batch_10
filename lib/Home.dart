import 'package:flutter/material.dart';
import 'CourseCard.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, String>> courses = const [
    {
      "title": "App Development with Flutter",
      "batch": "১০",
      "seats": "৯ সিট বাকি",
      "days": "২০ দিন বাকি",
      "flag": "bd.png",
    },
    {
      "title": "Full Stack Web Dev with JavaScript (MERN)",
      "batch": "১১",
      "seats": "৩ সিট বাকি",
      "days": "১৯ দিন বাকি",
      "flag": "us.png",
    },
    {
      "title": "Full Stack Web Dev with Python, Django & React",
      "batch": "৯",
      "seats": "৬৮ সিট বাকি",
      "days": "৪৫ দিন বাকি",
      "flag": "uk.png",
    },
    {
      "title": "Web Dev with PHP, Laravel & Vue",
      "batch": "৯",
      "seats": "৭৮ সিট বাকি",
      "days": "৪৫ দিন বাকি",
      "flag": "ca.png",
    },
    {
      "title": "Web Dev with ASP.Net Core",
      "batch": "৭",
      "seats": "৭৫ সিট বাকি",
      "days": "৩৭ দিন বাকি",
      "flag": "au.png",
    },
    {
      "title": "SQA: Manual & Automated Testing",
      "batch": "১১",
      "seats": "৫ সিট বাকি",
      "days": "৩০ দিন বাকি",
      "flag": "in.png",
    },
    {
      "title": "Mastering DevOps",
      "batch": "৩",
      "seats": "২ সিট বাকি",
      "days": "২৫ দিন বাকি",
      "flag": "pk.png",
    },
    {
      "title": "Coding Interview Preparation",
      "batch": "৫",
      "seats": "৬৭ সিট বাকি",
      "days": "৪৯ দিন বাকি",
      "flag": "sa.png",
    }
  ];

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount;

    if(screenWidth > 1024) {
      crossAxisCount = 4;  // Desktop/Web size
    } else if (screenWidth > 768 && screenWidth <= 1024) {
      crossAxisCount = 3; // Tablet size
    } else {
      crossAxisCount = 2; // Mobile size
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const Text("Responsive Design"),
          foregroundColor: Colors.white,
          backgroundColor: Colors.lightBlue
      ),
      body: Padding(
        padding: EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: courses.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 3/4
          ),
          itemBuilder: (context, index) {
            return CourseCard(courses[index], screenWidth);
          },
        ),
      ),
    );
  }
}