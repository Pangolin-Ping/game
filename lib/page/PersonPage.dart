// Flexible(
//                 flex: 1,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: EdgeInsets.fromLTRB(0, 0, 15, 0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                         ),
//                         child: Image.network(accountInfoProvider.stickerUrl),
//                       )
//                     ),
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         Text(
//                           '使用者名稱: ${accountInfoProvider.username}',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                         Text(
//                           '   錢   : ${accountInfoProvider.coin}',
//                           style: TextStyle(
//                             fontSize: 30,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),