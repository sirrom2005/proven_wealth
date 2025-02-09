import 'package:flutter/material.dart';
import '../../Common/MyColors.dart';
import '../../Common/MyStyles.dart';
import '../AccountInfo.dart';

class AccountSummary{
  final String accountValue;
  final String accountNumber;

  AccountSummary({
    required this.accountValue,
    required this.accountNumber
  });
}

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

    final List<AccountSummary> accountSummary = [
      AccountSummary(accountNumber: '***9090$pageNumber', accountValue: 'JMD \$4,500.72'),
      AccountSummary(accountNumber: '***5678$pageNumber', accountValue: 'JMD \$12,123.12'),
      AccountSummary(accountNumber: '***1214$pageNumber', accountValue: 'JMD \$1,0091.02')
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
      child: InkWell(
        onTap: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AccountInfo()),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Container(
                width: screenWidth,
                height: 200,//Color(0xFF3365ff)
                decoration: BoxDecoration(color: Color(0xFF3365ff)),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Account at', style: MyStyles.headerStyle2.copyWith(fontSize: 12)),
                          Text('FEB 32. 2025', style: MyStyles.headerStyle1.copyWith(fontSize: 24))
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Asset Value', style: MyStyles.headerStyle2.copyWith(fontSize: 12)),
                          Text(accountSummary[pageNumber].accountValue, style: MyStyles.headerStyle1.copyWith(fontSize: 24, color: MyColors.appAccentColor))
                        ],
                      ),
                      Text(accountSummary[pageNumber].accountNumber, style: MyStyles.headerStyle1.copyWith(fontSize: 16)),
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