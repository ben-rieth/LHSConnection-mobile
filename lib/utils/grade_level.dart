
class DateUtil {

  static int currentFreshmanHeader = 22;

  static DateTime currSchoolYearStart = new DateTime.utc(2019, 8, 1);
  static DateTime nextSchoolYearStart = new DateTime.utc(2020, 8, 1);

  static void checkHeaderUpdate() {
    if(DateTime.now().isAfter(nextSchoolYearStart)) {
      currentFreshmanHeader++;
      
      currSchoolYearStart = nextSchoolYearStart;
      
      nextSchoolYearStart.add(new Duration(days: 365));
    }
  }

  static String getGradeLevel(int emailHeader) {



    if(emailHeader == currentFreshmanHeader) {
      return "Freshman";
    } else if (emailHeader == currentFreshmanHeader+1) {
      return "Sophmore";
    } else if (emailHeader == currentFreshmanHeader+2) {
      return "Junior";
    } else if (emailHeader == currentFreshmanHeader+3) {
      return "Senior";
    } else {
      return "Something wonky happened";
    }
  }

}