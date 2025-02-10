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

    final List<AccountSummary> accountSummary = [
      AccountSummary(accountNumber: '***9090$pageNumber', accountValue: 'JMD \$4,500.72'),
      AccountSummary(accountNumber: '***5678$pageNumber', accountValue: 'USD \$12,123.12'),
      AccountSummary(accountNumber: '***1214$pageNumber', accountValue: 'CAN \$1,091.02')
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
      child: InkWell(
        onTap: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AccountInfo()),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFF3365ff),
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(70), // Shadow color
                spreadRadius:1, // How much the shadow should spread
                blurRadius:5, // How blurry the shadow should be
                offset: const Offset(4, 4), // Offset of the shadow from the container
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Account at', style: MyStyles.headerStyle2.copyWith(fontSize: 12).copyWith(color: MyColors.white)),
                    Text('FEB 32. 2025', style: MyStyles.headerStyle1.copyWith(fontSize: 24).copyWith(color: MyColors.white))
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Asset Value', style: MyStyles.headerStyle2.copyWith(fontSize: 12).copyWith(color: MyColors.white)),
                    Text(accountSummary[pageNumber].accountValue, style: MyStyles.headerStyle1.copyWith(fontSize: 24, color: MyColors.appAccentColor))
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text(accountSummary[pageNumber].accountNumber, style: MyStyles.headerStyle1.copyWith(fontSize: 16).copyWith(color: MyColors.white))),
                    Icon(Icons.info, color: MyColors.white)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}