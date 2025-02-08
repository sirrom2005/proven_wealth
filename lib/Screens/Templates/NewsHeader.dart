import 'package:flutter/material.dart';
import '../../Common/MyColors.dart';
import '../../Common/MyStyles.dart';
import '../NewsDetails.dart';

class NewsHeader extends StatelessWidget{
  final int pageNumber;

  const NewsHeader({
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
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const NewsDetails()),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.asset('lib/assets/images/news3.jpg', width: screenWidth),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  width: screenWidth,
                  height: 110,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter, // Start point of the gradient
                      end: Alignment.bottomCenter, // End point of the gradient
                      colors: [
                        MyColors.black.withAlpha(0), // Semi-transparent black overlay
                        MyColors.black.withAlpha(255),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: screenWidth*0.8,
                          child: Text('The cow jump over the moon', style: MyStyles.headerStyle1.copyWith(fontSize: 24, height:1.1))
                        ),
                        SizedBox(height:5),
                        Text('June 12, 2025', style: MyStyles.headerStyle2.copyWith(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: 120,
                  left: 5,
                  child:Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: MyColors.appAccentColor,
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                        child: Text('TOP STORES', style: MyStyles.headerStyle1.copyWith(fontSize: 12)),
                      ),
                    ),
                  ),
              ),
              for(double i=0; i<3; i++)...[
                Positioned(
                  bottom: 15,
                  right: 55-(i*20),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: MyColors.appAccentColor, // Border color
                        width: 2.0,       // Border width
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: i==(pageNumber-1) ? MyColors.appAccentColor : null,
                    ),
                    width: 8,
                    height: 8
                  )
                )
              ]
            ],
          ),
        ),
      ),
    );
  }
}