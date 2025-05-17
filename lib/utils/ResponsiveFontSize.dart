class ResponsiveFontSize {
  static double getTitleFontSize(double screenWidth) {
    if (screenWidth >= 1024) return 20; // Desktop/Web
    if (screenWidth >= 768) return 16; // Tablet
    return 14; // Mobile
  }


  static double getButtonFontSize(double screenWidth) {
    if (screenWidth >= 1024) return 16; // Desktop/Web
    if (screenWidth >= 768) return 15; // Tablet
    return 14; // Mobile
  }
}

