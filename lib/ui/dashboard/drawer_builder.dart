// import 'dart:developer';
//
// import 'package:dasboard/constants/app_colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class DrawerBuilder extends StatefulWidget {
//   const DrawerBuilder({Key? key}) : super(key: key);
//
//   @override
//   _DrawerBuilderState createState() => _DrawerBuilderState();
// }
//
// class _DrawerBuilderState extends State<DrawerBuilder> {
//   int _selectedDestination = 0;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return buildDrawer(context);
//   }
//
//   String FirstLater(String string) {
//     List<String> nameList = string.split(' ');
//     String firstLater = "";
//     for (int i = 0; i < nameList.length; i++) {
//       firstLater = firstLater + nameList[i][0];
//     }
//     log("firstLater: $firstLater");
//     return firstLater;
//   }
//
//   Drawer buildDrawer(BuildContext context) {
//     return Drawer(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 10),
//                     child: Card(
//                       elevation: 0,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           side: BorderSide(color: Colors.black12, width: .8)),
//                       child: ExpansionTile(
//                         trailing: Icon(
//                           Icons.keyboard_arrow_down,
//                           color: AppColors.orange,
//                         ),
//                         title: Text(
//                           'Transactions',
//                           style: TextStyles.pageSubHeading,
//                         ),
//                         children: [
//                           buildSubMenu(
//                               context,
//                               "Generate QR",
//                               const GenerateQRCodeFSM(),
//                               AssetsHPPayTheme.qRForFSM),
//                           buildSubMenu(context, "Paycode Transaction", null,
//                               AssetsHPPayTheme.img7,
//                               bottomSheetTitle: "PAYCODE"),
//                           buildSubMenu(
//                               context, "Payback", null, AssetsHPPayTheme.img5,
//                               bottomSheetTitle: "PAYBACK"),
//                         ],
//                         // selected: _selectedDestination == 0,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Card(
//               elevation: 0,
//               color: Colors.red.shade50,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   side: BorderSide(color: AppColors.red)),
//               child: ListTile(
//                 title: Text(
//                   'Logout',
//                   style: TextStyles.h1HeadingRed,
//                 ),
//                 trailing: const Icon(
//                   Icons.logout,
//                   color: AppColors.red,
//                 ),
//                 onTap: () {
//                   showDialog(
//                     barrierDismissible: false,
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertBox(
//                         dialogText: "Do you wish to logout?",
//                         FirstButtonFunction: () => {
//                           Navigator.of(context).pop(false),
//                         },
//                         secondButtonFunction: () => {
//                           APIService().logout(context),
//                           Constants.prefs?.setBool("isLogIn", false),
//                           // Constants.prefs
//                           //     ?.setBool(Constants.isRememberMe, true),
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => const LogInScreen())),
//                         },
//                       );
//                     },
//                   );
//
//                   // Constants.prefs!.setBool("LoggedIn", false);
//                   // logout(context, "", "");
//                 },
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   void _showPayBackBottomSheet({context}) {
//     String _selectedValue = "";
//     // --------------------------------------------------------
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent,
//         builder: (builder) {
//           return Consumer(builder: (context, ref, child) {
//             return Container(
//                 height: MediaQuery.of(context).size.height * .30,
//                 padding: const EdgeInsets.only(left: 20),
//                 decoration: const BoxDecoration(
//                     color: AppColors.secondaryWhite,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15))),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20, left: 10),
//                       child: categoryHeading("PayBack"),
//                     ),
//                     addVerticalSpace(14),
//                     CustomRadioButtonTile(
//                         title: const Text(
//                           "Earn Payback",
//                           style: TextStyle(
//                               color: AppColors.secondaryBlue,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         value: "Earn Payback",
//                         groupValue: ref.watch(radioButtonProvider),
//                         onChanged: (value) {
//                           ref.read(radioButtonProvider.state).state =
//                               value as String;
//                           _selectedValue = value;
//                         }),
//                     CustomRadioButtonTile(
//                         title: const Text(
//                           "Burn Payback",
//                           style: TextStyle(
//                               color: AppColors.secondaryBlue,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         value: "Burn Payback",
//                         groupValue: ref.watch(radioButtonProvider),
//                         onChanged: (value) async {
//                           ref.read(radioButtonProvider.state).state =
//                               value as String;
//                           _selectedValue = value;
//                         }),
//                     addVerticalSpace(14),
//                     Center(
//                       child: HPPayButton(
//                           title: "SUBMIT",
//                           onTap: () {
//                             if (_selectedValue == "Earn Payback") {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) =>
//                                           const EarnPayBack())).then((value) {
//                                 Navigator.pop(context);
//                               });
//                             } else {
//                               Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const BurnPaybackMobile()))
//                                   .then((value) {
//                                 Navigator.pop(context);
//                               });
//                             }
//                           }),
//                     )
//                   ],
//                 ));
//           });
//         });
//   }
//
//   Widget buildSubMenu(
//       BuildContext context, String menuName, var clazz, String iconPath,
//       {String? bottomSheetTitle}) {
//     return InkWell(
//       onTap: () {
//         if (clazz != null) {
//           Navigator.pop(context);
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => clazz),
//           );
//         } else {
//           Navigator.pop(context);
//           switch (bottomSheetTitle) {
//             case "PAYCODE":
//               {
//                 _showPayCodeBottomSheet(context: context);
//                 break;
//               }
//             case "PAYBACK":
//               {
//                 _showPayBackBottomSheet(context: context);
//                 break;
//               }
//           }
//         }
//       },
//       child: Padding(
//         padding: const EdgeInsets.only(left: 18.0),
//         child: Container(
//           alignment: Alignment.centerLeft,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Image.asset(
//                   iconPath,
//                   height: 20,
//                   width: 20,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Text(
//                     menuName,
//                     textAlign: TextAlign.start,
//                     style: TextStyles.h1SubHeading,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void selectDestination(int index) {
//     setState(() {
//       _selectedDestination = index;
//     });
//   }
//
//   Future<void> scanQR() async {
//     String barcodeScanRes;
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#D04545FF', 'Cancel', true, ScanMode.QR);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
//     if (!mounted) return;
//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }
//
//   String _scanBarcode = "Not Yet Scanned";
//   void _showPayCodeBottomSheet({context}) {
//     String _selectedValue = "Pay by QR";
//     // --------------------------------------------------------
//     showModalBottomSheet(
//         context: context,
//         backgroundColor: Colors.transparent,
//         builder: (builder) {
//           return Consumer(builder: (context, ref, child) {
//             return Container(
//                 height: MediaQuery.of(context).size.height * .30,
//                 padding: const EdgeInsets.only(left: 20),
//                 decoration: const BoxDecoration(
//                     color: AppColors.secondaryWhite,
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(15),
//                         topRight: Radius.circular(15))),
//                 child: Theme(
//                   data: Theme.of(context).copyWith(
//                     unselectedWidgetColor: AppColors.blue,
//                     disabledColor: AppColors.blue,
//                     selectedRowColor: AppColors.blue,
//                   ),
//                   child: Column(
//                     // mainAxisAlignment: MainAxisAlignment
//                     //     .start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20, left: 10),
//                         child: categoryHeading("PayCode Transactions"),
//                       ),
//                       addVerticalSpace(14),
//                       CustomRadioButtonTile(
//                           title: const Text(
//                             "Pay by QR",
//                             style: TextStyle(
//                                 color: AppColors.secondaryBlue,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           value: "Pay by QR",
//                           groupValue: ref.watch(radioButtonProvider),
//                           onChanged: (value) async {
//                             _selectedValue = value as String;
//                             ref.read(radioButtonProvider.state).state = value;
//                           }),
//                       CustomRadioButtonTile(
//                           title: const Text(
//                             "Pay by PayCode",
//                             style: TextStyle(
//                                 color: AppColors.secondaryBlue,
//                                 fontWeight: FontWeight.w400),
//                           ),
//                           value: "Pay by PayCode",
//                           groupValue: ref.watch(radioButtonProvider),
//                           onChanged: (value) {
//                             _selectedValue = value as String;
//                             ref.read(radioButtonProvider.state).state = value;
//                           }),
//                       addVerticalSpace(14),
//                       Center(
//                         child: HPPayButton(
//                             title: "SUBMIT",
//                             onTap: () async {
//                               if (_selectedValue == "Pay by PayCode") {
//                                 Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 const PayCodeTransaction()))
//                                     .then((value) {
//                                   Navigator.pop(context);
//                                   ref.read(radioButtonProvider.state).state =
//                                       "Pay by QR";
//                                 });
//                               }
//                               if (_selectedValue == "Pay by QR") {
//                                 await scanQR();
//                                 if (_scanBarcode == "-1") {
//                                   Navigator.pop(context);
//                                 } else {
//                                   log("=======_scanBarcode==$_scanBarcode=====");
//                                   if (_scanBarcode.length != 8 ||
//                                       _scanBarcode
//                                           .contains(new RegExp(r'[A-Z]'))) {
//                                     log("=====iffff==_scanBarcode==$_scanBarcode=====");
//                                     showDialog(
//                                       barrierDismissible: false,
//                                       context: context,
//                                       builder: (context) => DialogBox(
//                                           dialogText: "Invalid PayCode"),
//                                     );
//                                     return;
//                                   } else {
//                                     Navigator.pushReplacement(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (context) =>
//                                                 PayCodeTransaction(
//                                                   payCode: _scanBarcode,
//                                                 ))).then((value) {
//                                       Navigator.pop(context);
//                                       ref
//                                           .read(radioButtonProvider.state)
//                                           .state = "Pay by QR";
//                                       //   _scanBarcode = "Not Yet Scanned";
//                                     });
//                                   }
//                                 }
//                               }
//                               // submit();
//                               //TODO: ADD Search Button Working
//                               // setState(() {
//                               //   _isBottomSheetVisible = !_isBottomSheetVisible;
//                               // });
//                             }),
//                       )
//                     ],
//                   ),
//                 ));
//           });
//         });
//   }
// }
//
// void logout(BuildContext context, String title, String message) {
// //flutter define function
//   showDialog(
//     barrierDismissible: false,
//     context: context,
//     builder: (BuildContext context) {
//       //return object of type dialogue
//       return AlertDialog(
//         title: const Text('Do you wish to logout?'),
//         // content: const Text('We hate to see you leave...'),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               log("you choose no");
//               Navigator.of(context).pop(false);
//             },
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () {
//               APIService().logout(context);
//               Constants.prefs?.setBool("isLogIn", false);
//               Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (context) => const LogInScreen()));
//
//               // SystemChannels.platform.invokeMethod('SystemNavigator.pop');
//             },
//             child: const Text('Yes'),
//           ),
//         ],
//       );
//     },
//   );
// }
