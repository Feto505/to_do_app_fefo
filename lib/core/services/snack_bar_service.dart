import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

class SnackBarService {
  static void showSuccessMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
              width: double.maxFinite,
              height: msg.length > 80 ? 100 : 75,
              padding: const EdgeInsets.only(right: 8),
              margin: const EdgeInsets.only(left: 24, right: 24),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  // msg.length> 80
                  Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: 10,
                    decoration: const BoxDecoration(
                        color: Color(0xff46c234),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        )),
                  ),
                  Expanded(
                    flex: 1,

                    ///add===========================
                    child: Container(
                      width: 250,
                      height: 250,
                      // color: Colors.white,
                      child: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      // child: const Row(
                      //   children: [
                      //     Text("Successful",style: TextStyle(color: Colors.black),),
                      //     Icon(Icons.check,color: Colors.green,)
                      //   ],
                      // ),
                    ),
                  ),
                  const Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Succes",
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            ///add===========================
                            "msg",
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      )),
                  const VerticalDivider(
                    color: Colors.black26,
                    thickness: 2,
                  ),
                  Expanded(
                    flex: 3,
                    child: IconButton(
                      onPressed: () {},
                      icon: Text(
                        "close",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              )

              ///add===========================
              //: Text("wrong"),
              ),
        );
      },
      duration: const Duration(seconds: 10),
      dismissDirections: [DismissDirection.endToStart],
    );
  }

  static void showErrorMessage(String msg) {
    BotToast.showCustomNotification(
      toastBuilder: (void Function() cancelFunc) {
        return Material(
          color: Colors.transparent,
          child: Container(
              width: double.maxFinite,
              height: msg.length > 80 ? 100 : 75,
              padding: const EdgeInsets.only(right: 8),
              margin: const EdgeInsets.only(left: 24, right: 24),
              decoration: BoxDecoration(
                color: Colors.white60,
                borderRadius: BorderRadius.circular(12),
              ),
              child:
                  // msg.length> 80
                  Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: 10,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        )),
                  ),
                  Expanded(
                    flex: 1,

                    ///add===========================
                    child: Container(
                      width: 250,
                      height: 250,
                      // color: Colors.white,
                      child: const Icon(
                        Icons.check,
                        color: Colors.red,
                      ),
                      // child: const Row(
                      //   children: [
                      //     Text("Successful",style: TextStyle(color: Colors.black),),
                      //     Icon(Icons.check,color: Colors.green,)
                      //   ],
                      // ),
                    ),
                  ),
                  const Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Error",
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.black),
                          ),
                          Text(
                            ///add===========================
                            "msg",
                            textAlign: TextAlign.start,
                            maxLines: 3,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      )),
                  const VerticalDivider(
                    color: Colors.black26,
                    thickness: 2,
                  ),
                  Expanded(
                    flex: 3,
                    child: IconButton(
                      onPressed: () {},
                      icon: Text(
                        "close",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ],
              )

              ///add===========================
              //: Text("wrong"),
              ),
        );
      },
      duration: const Duration(seconds: 10),
      dismissDirections: [DismissDirection.endToStart],
    );
  }
// static void showFailedMessage(String msg){
//   BotToast.showCustomNotification(
//       toastBuilder: (void Function() cancelFunc){
//         return Material(
//           color: Colors.transparent,
//           child: Container(
//             width: double.maxFinite,
//             height: msg.length > 80?100:75,
//             padding: const EdgeInsets.only(right: 8),
//             margin: const EdgeInsets.only(left: 24,right: 24),
//             decoration: BoxDecoration(
//               color: Colors.white60,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child:
//             // msg.length> 80
//              Row(
//               children: [
//                 Container(
//                   height: double.infinity,
//                   width: 10,
//                   decoration: const BoxDecoration(
//                     color: Color(0xff46c234),
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(12),
//                       topRight: Radius.circular(12),
//                     )
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                     child: Container(
//                       width: 250,
//                       height: 250,
//                       color: Colors.white,
//                       child: const Row(
//                         children: [
//                           Text("Successful",style: TextStyle(color: Colors.black),),
//                           Icon(Icons.radio_button_checked_sharp,color: Colors.red,)
//                         ],
//                       ),
//                     ),
//                 ),
//                 const Expanded(
//                   flex: 3,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                             "Fail",
//                           textAlign: TextAlign.start,
//                           maxLines: 3,
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w500,
//                             color: Colors.black
//                           ),
//                         ),
//                         Text(
//                           "msg",
//                           textAlign: TextAlign.start,
//                           maxLines: 3,
//                           style: TextStyle(
//                             fontSize: 14,
//                             color: Colors.black54,
//                           ),
//                         )
//                       ],
//                     )
//                 ),
//                 const VerticalDivider(
//                   color: Colors.black26,
//                   thickness: 2,
//                 ),
//                 Expanded(
//                   flex: 3,
//                     child:IconButton(
//                       onPressed: (){},
//                       icon: Text("close",
//                       textAlign: TextAlign.center,style: TextStyle(color: Colors.black54),
//                       ),
//                     ) ,
//                 ),
//               ],
//             )
//                   // :Text("wrong"),
//           ),
//         );
//       },
//     duration: const Duration(seconds: 10),
//     dismissDirections: [DismissDirection.endToStart],
//   );
// }
}
