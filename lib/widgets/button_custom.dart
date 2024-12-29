// import 'package:flutter/material.dart';
// import 'package:test1/core/const_data/app_colors.dart';
// import 'package:test1/core/const_data/my_size.dart';
//
// class ButtonCustom extends StatelessWidget {
//   final double? margin ;
//   final String? text ;
//   final String? Function(String?)? fun;
//
//
//   const ButtonCustom({super.key, this.margin, this.text, this.fun});
//
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       width: double.infinity,
//       margin: EdgeInsets.symmetric(
//           horizontal: margin ?? 16),
//       child: ElevatedButton(
//         onPressed: () async {
//           await fun;
//         },
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.red[700],
//           // Background color
//           elevation: 5,
//           // Shadow
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//                 10), // Rounded corners
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment:
//           MainAxisAlignment.center,
//           children: [
//             Text(
//               text!,
//               style: TextStyle(
//                 color: AppColors.white,
//                 fontSize: MySize.fontSizeLg,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
