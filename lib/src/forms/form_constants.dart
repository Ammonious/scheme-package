import 'mask_text_input_formatter.dart';

enum SchemeFieldStyle { card, outline,neu }

const List stateAbbreviations = [
  'AL',
  'AK',
  'AS',
  'AZ',
  'AR',
  'CA',
  'CO',
  'CT',
  'DE',
  'DC',
  'FL',
  'GA',
  'HI',
  'ID',
  'IL',
  'IN',
  'IA',
  'KS',
  'KY',
  'LA',
  'ME',
  'MH',
  'MD',
  'MA',
  'MI',
  'MN',
  'MS',
  'MO',
  'MT',
  'NE',
  'NV',
  'NH',
  'NJ',
  'NM',
  'NY',
  'NC',
  'ND',
  'OH',
  'OK',
  'OR',
  'PW',
  'PA',
  'PR',
  'RI',
  'SC',
  'SD',
  'TN',
  'TX',
  'UT',
  'VT',
  'VA',
  'WA',
  'WV',
  'WI',
  'WY'
];

  stateDropDown() {
  List items = List();
  stateAbbreviations.forEach((element) {
    Map map = {'value': element, 'display': element};
    items.add(map);
  });
  return items;
}

// FORMATTERS
MaskTextInputFormatter phoneFormatter =
    MaskTextInputFormatter(mask: '###-###-####', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter dobFormatter =
    MaskTextInputFormatter(mask: '##/##/##', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter ssnFormatter =
    MaskTextInputFormatter(mask: '###-##-####', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter einFormatter =
    MaskTextInputFormatter(mask: '##-#######', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter ccFormatter =
    MaskTextInputFormatter(mask: '####-####-####-####', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter expFormatter =
    MaskTextInputFormatter(mask: '##/##', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter cvcFormatter =
    MaskTextInputFormatter(mask: '###', filter: {"#": RegExp(r'[0-9]')});

MaskTextInputFormatter amexFormatter =
    MaskTextInputFormatter(mask: '####', filter: {"#": RegExp(r'[0-9]')});
