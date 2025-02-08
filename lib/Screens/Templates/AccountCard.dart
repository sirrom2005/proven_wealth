import 'package:flutter/material.dart';
import '../../Common/MyColors.dart';
import '../../Common/MyStyles.dart';
import '../NewsDetails.dart';

class AccountCard extends StatelessWidget{
  final int pageNumber;

  const AccountCard({
    super.key,
    required this.pageNumber
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;
    double safePaddingTop = MediaQuery.of(context).padding.top;

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: InkWell(
        onTap: (){
          // Navigator.push(context,
          //   MaterialPageRoute(builder: (context) => const NewsDetails()),
          // );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: 200,
                decoration: BoxDecoration(color: Color(0xFF3365ff)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('FEB 32. 2025', style: MyStyles.headerStyle1.copyWith(fontSize: 24)),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Asset Value', style: MyStyles.headerStyle2.copyWith(fontSize: 12)),
                          Text('JMD \$400,000,000.00', style: MyStyles.headerStyle1.copyWith(fontSize: 24, color: MyColors.appAccentColor))
                        ],
                      ),
                      Text('***9090$pageNumber', style: MyStyles.headerStyle1.copyWith(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  //   color: MyColors.white,
                  // ),
                  width: 25,
                  height: 25,
                  child: Icon(Icons.info, color: MyColors.white)
                  // Padding(
                  //   padding: const EdgeInsets.fromLTRB(0, 3.5, 0, 0),
                  //   child: Text('$pageNumber', style: TextStyle(fontSize:12, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                  // ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}