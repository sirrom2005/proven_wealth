import 'package:flutter/material.dart';
import 'package:proven_wealth/Screens/NewsDetails.dart';
import '../../Common/MyColors.dart';
import '../../Common/MyStyles.dart';

class NewListing extends StatelessWidget{
  const NewListing({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double screenHeight = size.height;
    double screenWidth = size.width;

    return InkWell(
      onTap: (){
        Navigator.push(context,
          MaterialPageRoute(builder: (context) => const NewsDetails()),
        );
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(50,10,50,0),
            child: Container(
              height: 1,
              width: screenWidth,// Line thickness
              color: Colors.grey.withAlpha(70), // Line color
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10,10,10,0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,10,0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset('lib/assets/images/news2.jpg', width: 120)
                  ),
                ),
                Expanded(
                  child: Container(
                    //color: MyColors.red,
                    //height: cellHeight,
                    width: 100,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('June 13, 2012', style: MyStyles.headerStyle3),
                        SizedBox(height:3),
                        Text('Sdfdsf dfdsf Hellof dsfsda ds dsad sads adsadas d asd as dsa dsa d', style: MyStyles.headerStyle3.copyWith(color: MyColors.black)),
                        SizedBox(height:3),
                        Text('Info1 | More | Random info', style: MyStyles.headerStyle3.copyWith(color: MyColors.appAccentColor)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}