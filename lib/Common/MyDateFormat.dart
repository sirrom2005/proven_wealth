import 'package:intl/intl.dart';

class MyDateFormat
{
  getDisplayDate(String inDate, int type)
  {
    String inDateFormat = '';

    try{
      if(type==0){
        inDateFormat = "yyyy-MM-dd";
      }else if(type==1 || type==3){
        inDateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
      }else if(type==2){
        inDate = '${inDate.substring(0,4)}-${inDate.substring(4,6)}-${inDate.substring(6,8)}';
        inDateFormat = "yyyy-MM-dd";
      }

      DateTime parseDate = DateFormat(inDateFormat).parse(inDate);
      var inputDate = DateTime.parse(parseDate.toString());
      if (type == 3) {
        return DateFormat('MMM dd, yyyy - hh:mm a').format(inputDate).replaceAll('AM', 'am').replaceAll('PM', 'pm');
      }
      return DateFormat('MMM dd, yyyy').format(inputDate);
    }catch(a){
      return '-';
    }
  }
}