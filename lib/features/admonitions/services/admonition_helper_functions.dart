String getAdmonitionTypeText(String value) {
  switch (value) {
    case 'choose':
      return 'bitte wählen';
    case 'rk':
      return '';
    case 'rkogs':
      return 'OGS';
    case 'other':
      return 'Vorfall';
    default:
      return '';
  }
}

String getAdmonitionReasonText(String value) {
  String admonitionReasonText = '';
  if (value.contains('gm')) {
    admonitionReasonText = '${admonitionReasonText}Gewalt gegen Menschen';
  }
  if (value.contains('gs')) {
    admonitionReasonText = '$admonitionReasonText | Gewalt gegen Sachen';
  }
  if (value.contains('äa')) {
    admonitionReasonText = '$admonitionReasonText | Ärgern anderer Kinder';
  }
  if (value.contains('il')) {
    admonitionReasonText = '$admonitionReasonText | Ignorieren von Anweisungen';
  }
  if (value.contains('us')) {
    admonitionReasonText = '$admonitionReasonText | Unterrichtsstörung';
  }
  if (value.contains('ss')) {
    admonitionReasonText = '${admonitionReasonText}Sonstiges';
  }
  return admonitionReasonText;
}
