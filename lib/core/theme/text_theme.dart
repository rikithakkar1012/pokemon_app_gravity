import 'package:flutter/material.dart';

const TextTheme customTextTheme = TextTheme(
  // Custom headline style
  displayLarge: TextStyle(
    fontSize: 32, // Larger size for headlines
    fontWeight: FontWeight.bold,
    color: Colors.black87, // Dark text color for readability on white background
    fontFamily: 'Roboto', // You can choose any font that fits your design
  ),
  displayMedium: TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    fontFamily: 'Roboto',
  ),
  displaySmall: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.black87,
    fontFamily: 'Roboto',
  ),
  // Custom body text style
  bodyLarge: TextStyle(
    fontSize: 16, // Standard body text size
    fontWeight: FontWeight.normal,
    color: Colors.black87,
    fontFamily: 'Roboto',
  ),
  bodyMedium: TextStyle(
    fontSize: 14, // Smaller body text for secondary info
    fontWeight: FontWeight.normal,
    color: Colors.black54, // Slightly lighter for less important text
    fontFamily: 'Roboto',
  ),
  bodySmall: TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: Colors.black38, // Even lighter color for captions or disclaimers
    fontFamily: 'Roboto',
  ),
  labelLarge: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.white, // Button text should be white for visibility
    fontFamily: 'Roboto',
  ),
);
