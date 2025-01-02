// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("直播標題"),
//           centerTitle: true,
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               // 第一行圓形按鈕和頭像
//               Row(
//                 children: [
//                   IconButton(
//                     icon: Icon(Icons.radio_button_checked),
//                     onPressed: () {},
//                   ),
//                   SizedBox(width: 8),
//                   Text("一", style: TextStyle(fontSize: 18)),
//                 ],
//               ),
//               SizedBox(height: 8),
//               // 卡片列表
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: 2, // 假設有兩個卡片
//                   itemBuilder: (context, index) {
//                     return Card(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         side: BorderSide(color: Colors.black),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // 左側圓形頭像
//                             CircleAvatar(
//                               radius: 20,
//                               backgroundColor: Colors.grey,
//                               child: Text("圖"),
//                             ),
//                             SizedBox(width: 8),
//                             // 右側文字和按鈕內容
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     "第N條 xxxxxxx xxxxx",
//                                     style: TextStyle(fontSize: 16),
//                                   ),
//                                   SizedBox(height: 4),
//                                   Row(
//                                     children: [
//                                       // 綠色圓形指示燈
//                                       Row(
//                                         children: List.generate(
//                                           5,
//                                           (index) => Padding(
//                                             padding:
//                                                 const EdgeInsets.symmetric(
//                                                     horizontal: 2),
//                                             child: CircleAvatar(
//                                               radius: 4,
//                                               backgroundColor: Colors.green,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                       SizedBox(width: 8),
//                                       // 紅色按鈕
//                                       ElevatedButton(
//                                         onPressed: () {},
//                                         style: ElevatedButton.styleFrom(
//                                           backgroundColor: Colors.red,
//                                           shape: RoundedRectangleBorder(
//                                             borderRadius:
//                                                 BorderRadius.circular(12),
//                                           ),
//                                         ),
//                                         child: Text(
//                                           "三振",
//                                           style: TextStyle(fontSize: 12),
//                                         ),
//                                       ),
//                                       SizedBox(width: 8),
//                                       // "A:B" 標籤
//                                       Text("A:B", style: TextStyle(fontSize: 16)),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }