
class DateUtil {

  static int currentFreshmanHeader;

  static DateTime currSchoolYearStart = new DateTime.utc(2018, 8, 1);
  static DateTime nextSchoolYearStart = new DateTime.utc(2019, 8, 1);

  static void checkHeaderUpdate() {

    currentFreshmanHeader = currSchoolYearStart.year + 4;

    if(DateTime.now().isAfter(nextSchoolYearStart)) {
      currSchoolYearStart = nextSchoolYearStart;
      
      nextSchoolYearStart.add(new Duration(days: 365));
    }
  }

  static String getGradeLevel(int emailHeader) {

    if(emailHeader == currentFreshmanHeader) {
      return "Freshman";
    } else if (emailHeader == currentFreshmanHeader-1) {
      return "Sophomore";
    } else if (emailHeader == currentFreshmanHeader-2) {
      return "Junior";
    } else if (emailHeader == currentFreshmanHeader-3) {
      return "Senior";
    } else {
      return "Something wonky happened";
    }
  }

}