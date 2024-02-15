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
  bool firstItem = true;
  String admonitionReasonText = '';

  if (value.contains('gm')) {
    admonitionReasonText = '${admonitionReasonText}Gewalt gegen Menschen';
    firstItem = false;
  }

  if (value.contains('gs')) {
    if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
    admonitionReasonText = '${admonitionReasonText}Gewalt gegen Sachen';
    firstItem = false;
  }
  if (value.contains('äa')) {
    if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';

    admonitionReasonText = '${admonitionReasonText}Ärgern anderer Kinder';
    firstItem = false;
  }

  if (value.contains('il')) {
    if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
    admonitionReasonText = '${admonitionReasonText}Ignorieren von Anweisungen';
    firstItem == false;
  }

  if (value.contains('us')) {
    if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
    admonitionReasonText = '${admonitionReasonText}Unterrichtsstörung';
    firstItem = false;
  }

  if (value.contains('ss')) {
    if (firstItem == false) admonitionReasonText = '$admonitionReasonText - ';
    admonitionReasonText = '${admonitionReasonText}Sonstiges';
    firstItem = false;
  }
  return admonitionReasonText;
}
