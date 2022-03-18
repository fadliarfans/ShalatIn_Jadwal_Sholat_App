extension DayName on String {
  String translateDayToID() {
    switch (this) {
      case "Monday":
        return "Senin";
      case "Tuesday":
        return "Selasa";
      case "Wednesday":
        return "Rabu";
      case "Thursday":
        return "Kamis";
      case "Friday":
        return "Jumat";
      case "Saturday":
        return "Sabtu";
      case "Sunday":
        return "Minggu";
      default:
        return this;
    }
  }
}
