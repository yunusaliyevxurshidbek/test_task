bool isSpecialDay(DateTime day) {
  return (day.day >= 1 && day.day <= 3) || (day.day >= 25 && day.day <= 31);
}

bool isPinkDay(DateTime day) {
  return day.day >= 16 && day.day <= 19;
}