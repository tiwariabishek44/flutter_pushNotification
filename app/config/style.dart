// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:merocanteen/app/config/colors.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';

// Duration duration = const Duration(milliseconds: 360);

// class AppStyles {
//   static TextStyle get appbar {
//     return GoogleFonts.poppins(
//         textStyle: TextStyle(
//             fontSize: 19.sp, fontWeight: FontWeight.w800, color: Colors.black));
//   }

//   static TextStyle get titleStyle {
//     return GoogleFonts.lato(
//         textStyle: TextStyle(
//             fontSize: 16.sp, fontWeight: FontWeight.w800, color: Colors.black));
//   }

//   static TextStyle get subtitleStyle {
//     return GoogleFonts.poppins(
//         textStyle: const TextStyle(
//       color: AppColors.iconColors,
//       fontWeight: FontWeight.w500,
//     ));
//   }

//   static TextStyle get mainHeading {
//     return GoogleFonts.poppins(
//         textStyle: TextStyle(
//       fontSize: 22.sp,
//       color: AppColors.iconColors,
//       fontWeight: FontWeight.w700,
//     ));
//   }

//   static TextStyle get listTileTitle {
//     return GoogleFonts.poppins(
//         fontSize: 17.5.sp,
//         textStyle: const TextStyle(
//           color: AppColors.iconColors,
//           fontWeight: FontWeight.w600,
//         ));
//   }

//   static TextStyle get listTilesubTitle {
//     return GoogleFonts.poppins(
//         fontSize: 15.sp,
//         textStyle: const TextStyle(
//           color: Color.fromARGB(255, 107, 109, 110),
//           fontWeight: FontWeight.w500,
//         ));
//   }

//   static TextStyle get topicsHeading {
//     return GoogleFonts.lato(
//         textStyle: TextStyle(
//       fontSize: 18.sp,
//       color: AppColors.iconColors,
//       fontWeight: FontWeight.w800,
//     ));
//   }
// }

// class AppPadding {
//   static EdgeInsetsGeometry get screenHorizontalPadding {
//     return EdgeInsets.symmetric(horizontal: 3.5.w);
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:merocanteen/app/config/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Duration duration = const Duration(milliseconds: 360);

class AppStyles {
  static TextStyle get appbar {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 19.sp, fontWeight: FontWeight.w800, color: Colors.black));
  }

  static TextStyle get titleStyle {
    return GoogleFonts.lato(
        textStyle: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 169, 96, 96)));
  }

  static TextStyle get subtitleStyle {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
      fontSize: 18.sp,
      color: AppColors.iconColors,
      fontWeight: FontWeight.w500,
    ));
  }

  static TextStyle get mainHeading {
    return GoogleFonts.poppins(
        textStyle: TextStyle(
      overflow: TextOverflow.fade,
      fontSize: 22.sp,
      color: AppColors.iconColors,
      fontWeight: FontWeight.w700,
    ));
  }

  static TextStyle get buttonText {
    return GoogleFonts.poppins(
        fontSize: 17.5.sp,
        textStyle: const TextStyle(
          color: Color.fromARGB(221, 255, 255, 255),
          fontWeight: FontWeight.w600,
        ));
  }

  static TextStyle get listTileTitle {
    return GoogleFonts.lato(
        fontSize: 16.5.sp,
        textStyle: const TextStyle(
          color: AppColors.iconColors,
          fontWeight: FontWeight.w600,
        ));
  }

  static TextStyle get listTileTitle1 {
    return GoogleFonts.lato(
        fontSize: 17.5.sp,
        textStyle: const TextStyle(
          color: Color.fromARGB(221, 255, 255, 255),
          fontWeight: FontWeight.w600,
        ));
  }

  static TextStyle get listTilesubTitle1 {
    return GoogleFonts.poppins(
        fontSize: 15.sp,
        textStyle: const TextStyle(
          color: Color.fromARGB(255, 2, 49, 4),
          fontWeight: FontWeight.w500,
        ));
  }

  static TextStyle get listTilesubTitle {
    return GoogleFonts.poppins(
        fontSize: 15.sp,
        textStyle: const TextStyle(
          color: Color.fromARGB(255, 107, 109, 110),
          fontWeight: FontWeight.w500,
        ));
  }

  static TextStyle get topicsHeading {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 18.sp,
      color: AppColors.iconColors,
      fontWeight: FontWeight.w800,
    ));
  }

  static TextStyle get topicsHeading1 {
    return GoogleFonts.lato(
        textStyle: TextStyle(
      fontSize: 18.sp,
      color: AppColors.backgroundColor,
      fontWeight: FontWeight.w800,
    ));
  }
}

class AppPadding {
  static EdgeInsetsGeometry get screenHorizontalPadding {
    return EdgeInsets.symmetric(horizontal: 3.5.w);
  }
}
