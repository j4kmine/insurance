import 'package:flutter/foundation.dart';

class Strings {
  Strings._();

  //General
  static const String appName = "CarFren";
  static const String dateFormat = "dd/MM/yyyy";
  static const String timeFormat = "HH:mm";
  static const String expiryDateFormat = "MM/yyyy";
  static const String quote = "i_just_want_a_quote";
  static const String pendingAcceptance = "pending_acceptance";
  static const String upcoming = "upcoming";
  static const String stripeKey = kReleaseMode
      ? "pk_live_51IizDnEdvIpOcefuDymXYjn4nYHvsHfSTbVKlMJZNmLNjj90104ZyrmolkhwFvI4i60lsN2BMp2RsmeYd4D3rLie0050oCcyub"
      : "pk_test_51IizDnEdvIpOcefuBdxfz0Us7eZRwav2CL0s7obVztllNOo62d9yHMAaKcN1MjuphWRdG2uUssb1T88tZhCuTM6P003sTOp7WS";

  static const Map<String, int> dayOptions = {
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6,
    'Sunday': 7
  };
  static const List<String> typeOptions = ['', 'new', 'preowned'];
  static const List<String> hybridOptions = ['', 'hybrid', 'non_hybrid'];
  static const List<String> vehicleOptions = ['', "i_just_want_a_quote"];
  static const List<String> salutationOptions = [
    '',
    'mr',
    'ms',
    'mrs',
    'mdm',
    'company'
  ];
  static const List<String> genderOptions = [
    '',
    'M',
    'F',
  ];
  static const List<String> yesNoOptions = ['', 'yes', 'no'];
  static const List<String> usageOptions = ['', 'private', 'phv'];
  static const List<String> occupationTypeOptions = ['', 'indoor', 'outdoor'];
  static const List<String> idTypeOptions = [
    '',
    'nric',
    'fin',
    'passport',
    'birth_certificate',
    'others'
  ];
  static const List<String> occupationOptions = [
    '',
    'Acupuncturist',
    'Admin',
    'Air Crew / Pilot',
    'Air Traffic Controller',
    'Airline Officer',
    'Architect',
    'ArtHandicraft/Antique Dealer',
    'Astronomer',
    'Author',
    'Baby Sitter',
    'Baker',
    'Barber',
    'Barrister',
    'Bartender',
    'Beautician',
    'Boilerman',
    'Butcher',
    'Car Dealer',
    'Carpenter (Woodworking Machinery)',
    'Cashier',
    'Caterer',
    'Chamber Maid/Caretaker',
    'Chauffeur',
    'Cheer Leader',
    'Chef/Cook/Confectioner',
    'Chemical Plant Worker',
    'Chiropractor',
    'Cleaner (Indoor)',
    'Cleaner (Office)',
    'Cleaner(Outdoor, Exclude Height Works)',
    'Clerical',
    'Coach',
    'Construction Engineer',
    'Construction Worker / Supervisor/Foreman',
    'Counseller',
    'Craftman',
    'Crane Operator',
    'Customer Service (Indoor)',
    'Customer Service (Outdoor)',
    'Dancer/Dance Instructor',
    'Deliveryman',
    'Dentist',
    'Despatch Rider',
    'Dietician',
    'Diplomat',
    'Disc Jockey',
    'Diver',
    'Domestic Helper',
    'Domestic Maid',
    'Doormen',
    'Draughtman',
    'Driver Cum Delivery Man',
    'Driver/Despatch Rider',
    'Driving Instructor',
    'Economist',
    'EditorCopy Writer',
    'Engineer (DeskBound)',
    'Engineer (Involves Use Of Tool)',
    'Engineer (Outdoor)',
    'Entertainer',
    'Executive(Indoor)',
    'Executive(Outdoor)',
    'Factory Operator',
    'Farmer',
    'Fashion Designer',
    'Finance &amp; Accounts',
    'Financial Advisor',
    'Fisherman',
    'Fishmonger',
    'Fitness Trainer',
    'Fitter',
    'Florist',
    'Forklift Driver',
    'Gardener',
    'Geologist',
    'Glazier',
    'Godown Keeper',
    'Grocer',
    'Hairstylist',
    'Hawker Inspector',
    'Hawker/Stallholder',
    'Health Inspector',
    'Homemaker/Housewife',
    'Housekeeper',
    'Interior Designer',
    'Janitor',
    'Jeweller',
    'Jockeys',
    'Journalist Indoor',
    'Judge',
    'Kitchen Assistant',
    'Laboratory Technician',
    'Lawyer',
    'Lecturer',
    'Librarian',
    'Life Guard',
    'Lift Attendant',
    'Locksmith',
    'Logistic Assistant',
    'Machinist',
    'Machinist (Woodworking)',
    'Magician',
    'Maintenance Inspector / Supervisor(Max Height Works @ 3M)',
    'Maintenance Technician  (Max Height Works @ 3M)',
    'Management/Administration',
    'Marine Salvage Crew',
    'Martial Arts Instructor',
    'Masseur/ Masseuse',
    'Mechanic',
    'Medical Practitioner',
    'Merchant',
    'Meteorologist',
    'Meter Reader',
    'Midwife',
    'Minister Of Singapore Government',
    'Model',
    'Money Changer',
    'Motor Engineer',
    'Musician',
    'National Servicemen',
    'News Vendor',
    'Newscaster (Indoor)',
    'Newscaster (Outdoor)',
    'Novelist',
    'Nurse',
    'Nurse (Outpatient Clinic)',
    'Odd Job Labourer',
    'Oil Rig Worker',
    'Onboard Vessel (Admin/Service Crew)',
    'Onboard Vessel Work (Manual Work)',
    'Operations Executive / Manager',
    'Operator/Production',
    'Optician',
    'Others',
    'Outward Bound Trainer',
    'Packer',
    'Painter_Indoor (Max 3 Meter Above Ground)',
    'Painter_Outdoor (Max 10 Meter Above Ground)',
    'Paramedics',
    'Parking Officer',
    'Pawnbroker',
    'Person Involved In Handling Of Explosives',
    'Petrol Pump Attendant',
    'Pharmacist',
    'Photographer(Indoor)',
    'Photographer(Outdoor)',
    'Piano Tuner',
    'Planter',
    'Plumber',
    'Porter',
    'Postman',
    'Prison Officer / Warden',
    'Private Investigator',
    'Professional Sportsperson',
    'Publisher/Printer',
    'Purchaser (Indoor)',
    'Purchaser (Outdoor)',
    'QC Inspector',
    'Radio/Television Engineer',
    'Radiologist',
    'Real Estate Agent',
    'Receptionist',
    'Referee',
    'Remisier',
    'Renovations Contractor',
    'Retiree',
    'Safety Inspector',
    'Sailor',
    'School Teacher/Principal',
    'Secretary',
    'Security Personnel_Armed',
    'Security Personnel_Unarmed',
    'Self-Employed (Indoor)',
    'Self-Employed (Outdoor)',
    'Service Engineer',
    'Ship Crew',
    'Shipmaster',
    'Signwriter',
    'Singapore Armed Forces Personnel',
    'Singapore Civil Defense Force',
    'Singapore Police Force',
    'Site Coordinator',
    'Social Escort',
    'Software Engineer',
    'Sole Proprietor',
    'Sole Proprietor (Outdoor)',
    'Sole Proprietor(Indoor)',
    'Statistician',
    'Steerman',
    'Stevedore /  Dockworkers',
    'Stock Broker',
    'Student &amp; Child In Singapore',
    'Student_Full Time',
    'Student_Outside Of Singapore',
    'Student_Part Time',
    'Tailor/Seamstress',
    'Taxi Driver',
    'Therapist',
    'Tiler',
    'Tour Consultant / Guide',
    'Trader',
    'Traffic Warden',
    'Translator',
    'Tutor',
    'Typist',
    'Undertaker',
    'Unemployed',
    'Usher',
    'Vegetable Seller',
    'Veterinary Surgeon',
    'Waiter/Waitress',
    'Watchman',
    'Web Designer',
    'Welder',
    'Window Cleaner',
    'Working Onboard Non-Sailing Vessel',
    'Zookeeper',
    'Zoologist'
  ];
  // Country
  static const Map<String, String> nationalityCodes = {
    "SG": 'Singapore',
    "AF": 'Afghanistan',
    "AL": 'Albania',
    "DZ": 'Algeria',
    "AS": 'American Samoa',
    "AD": 'Andorra',
    "AO": 'Angola',
    "AI": 'Anguilla',
    "AQ": 'Antarctica',
    "AG": 'Antigua and Barbuda',
    "AR": 'Argentina',
    "AM": 'Armenia',
    "AW": 'Aruba',
    "AU": 'Australia',
    "AT": 'Austria',
    "AZ": 'Azerbaijan',
    "BS": 'Bahamas',
    "BH": 'Bahrain',
    "BD": 'Bangladesh',
    "BB": 'Barbados',
    "BY": 'Belarus',
    "BE": 'Belgium',
    "BZ": 'Belize',
    "BJ": 'Benin',
    "BM": 'Bermuda',
    "BT": 'Bhutan',
    "BO": 'Bolivia',
    "BA": 'Bosnia and Herzegovina',
    "BW": 'Botswana',
    "BR": 'Brazil',
    "IO": 'British Indian Ocean Territory',
    "VG": 'British Virgin Islands',
    "BN": 'Brunei',
    "BG": 'Bulgaria',
    "BF": 'Burkina Faso',
    "BI": 'Burundi',
    "KT": 'COTEDIVOIRE',
    "KH": 'Cambodia',
    "CM": 'Cameroon',
    "CA": 'Canada',
    "CV": 'Cape Verde',
    "KY": 'Cayman Islands',
    "CF": 'Central African Republic',
    "TD": 'Chad',
    "CL": 'Chile',
    "CN": 'China',
    "CX": 'Christmas Island',
    "CC": 'Cocos Islands',
    "CO": 'Colombia',
    "KM": 'Comoros',
    "CK": 'Cook Islands',
    "CR": 'Costa Rica',
    "HR": 'Croatia',
    "CU": 'Cuba',
    "CW": 'Curacao',
    "CY": 'Cyprus',
    "CZ": 'Czech Republic',
    "DD": 'DDGK',
    "CD": 'Democratic Republic of the Congo',
    "DK": 'Denmark',
    "DJ": 'Djibouti',
    "DM": 'Dominica',
    "DO": 'Dominican Republic',
    "TL": 'East Timor',
    "EC": 'Ecuador',
    "EG": 'Egypt',
    "SV": 'El Salvador',
    "GQ": 'Equatorial Guinea',
    "ER": 'Eritrea',
    "EE": 'Estonia',
    "ET": 'Ethiopia',
    "FK": 'Falkland Islands',
    "FO": 'Faroe Islands',
    "FJ": 'Fiji',
    "FI": 'Finland',
    "FR": 'France',
    "PF": 'French Polynesia',
    "GA": 'Gabon',
    "GM": 'Gambia',
    "GE": 'Georgia',
    "DE": 'Germany',
    "GH": 'Ghana',
    "GI": 'Gibraltar',
    "GR": 'Greece',
    "GL": 'Greenland',
    "GD": 'Grenada',
    "GU": 'Guam',
    "GT": 'Guatemala',
    "GG": 'Guernsey',
    "GN": 'Guinea',
    "GW": 'Guinea-Bissau',
    "GY": 'Guyana',
    "HT": 'Haiti',
    "HN": 'Honduras',
    "HK": 'Hong Kong',
    "HU": 'Hungary',
    "IS": 'Iceland',
    "IN": 'India',
    "ID": 'Indonesia',
    "IR": 'Iran',
    "IQ": 'Iraq',
    "IE": 'Ireland',
    "IM": 'Isle of Man',
    "IL": 'Israel',
    "IT": 'Italy',
    "CI": 'Ivory Coast',
    "JM": 'Jamaica',
    "JP": 'Japan',
    "JE": 'Jersey',
    "JO": 'Jordan',
    "KZ": 'Kazakhstan',
    "KE": 'Kenya',
    "KI": 'Kiribati',
    "XK": 'Kosovo',
    "KW": 'Kuwait',
    "KG": 'Kyrgyzstan',
    "LA": 'Laos',
    "LV": 'Latvia',
    "LB": 'Lebanon',
    "LS": 'Lesotho',
    "LR": 'Liberia',
    "LY": 'Libya',
    "LI": 'Liechtenstein',
    "LT": 'Lithuania',
    "LU": 'Luxembourg',
    "MO": 'Macao',
    "MK": 'Macedonia',
    "MG": 'Madagascar',
    "MW": 'Malawi',
    "MY": 'Malaysia',
    "MV": 'Maldives',
    "ML": 'Mali',
    "MT": 'Malta',
    "MH": 'Marshall Islands',
    "MR": 'Mauritania',
    "MU": 'Mauritius',
    "YT": 'Mayotte',
    "MX": 'Mexico',
    "FM": 'Micronesia',
    "MD": 'Moldova',
    "MC": 'Monaco',
    "MN": 'Mongolia',
    "ME": 'Montenegro',
    "MS": 'Montserrat',
    "MA": 'Morocco',
    "MZ": 'Mozambique',
    "MM": 'Myanmar',
    "NA": 'Namibia',
    "NR": 'Nauru',
    "NP": 'Nepal',
    "NL": 'Netherlands',
    "AN": 'Netherlands Antilles',
    "NC": 'New Caledonia',
    "NZ": 'New Zealand',
    "NI": 'Nicaragua',
    "NE": 'Niger',
    "NG": 'Nigeria',
    "NU": 'Niue',
    "KP": 'North Korea',
    "MP": 'Northern Mariana Islands',
    "NO": 'Norway',
    "ZZ": 'OTHERS',
    "OM": 'Oman',
    "PK": 'Pakistan',
    "PW": 'Palau',
    "PS": 'Palestine',
    "PA": 'Panama',
    "PG": 'Papua New Guinea',
    "PY": 'Paraguay',
    "PE": 'Peru',
    "PH": 'Philippines',
    "PN": 'Pitcairn',
    "PL": 'Poland',
    "PT": 'Portugal',
    "PR": 'Puerto Rico',
    "QA": 'Qatar',
    "CG": 'Republic of the Congo',
    "RE": 'Reunion',
    "RO": 'Romania',
    "RU": 'Russia',
    "RW": 'Rwanda',
    "BL": 'Saint Barthelemy',
    "SH": 'Saint Helena',
    "KN": 'Saint Kitts and Nevis',
    "LC": 'Saint Lucia',
    "MF": 'Saint Martin',
    "PM": 'Saint Pierre and Miquelon',
    "VC": 'Saint Vincent and the Grenadines',
    "WS": 'Samoa',
    "SM": 'San Marino',
    "ST": 'Sao Tome and Principe',
    "SA": 'Saudi Arabia',
    "SN": 'Senegal',
    "RS": 'Serbia',
    "SC": 'Seychelles',
    "SL": 'Sierra Leone',
    "SX": 'Sint Maarten',
    "SK": 'Slovakia',
    "SI": 'Slovenia',
    "SB": 'Solomon Islands',
    "SO": 'Somalia',
    "ZA": 'South Africa',
    "KR": 'South Korea',
    "SS": 'South Sudan',
    "ES": 'Spain',
    "LK": 'Sri Lanka',
    "SD": 'Sudan',
    "SR": 'Suriname',
    "SJ": 'Svalbard and Jan Mayen',
    "SZ": 'Swaziland',
    "SE": 'Sweden',
    "CH": 'Switzerland',
    "SY": 'Syria',
    "TW": 'Taiwan',
    "TJ": 'Tajikistan',
    "TZ": 'Tanzania',
    "TH": 'Thailand',
    "TG": 'Togo',
    "TK": 'Tokelau',
    "TO": 'Tonga',
    "TT": 'Trinidad and Tobago',
    "TN": 'Tunisia',
    "TR": 'Turkey',
    "TM": 'Turkmenistan',
    "TC": 'Turks and Caicos Islands',
    "TV": 'Tuvalu',
    "VI": 'U.S. Virgin Islands',
    "UG": 'Uganda',
    "UA": 'Ukraine',
    "AE": 'United Arab Emirates',
    "GB": 'United Kingdom',
    "US": 'United States',
    "UY": 'Uruguay',
    "UZ": 'Uzbekistan',
    "VU": 'Vanuatu',
    "VA": 'Vatican',
    "VE": 'Venezuela',
    "VN": 'Vietnam',
    "WF": 'Wallis and Futuna',
    "EH": 'Western Sahara',
    "YU": 'YUGOSLAVIA',
    "YE": 'Yemen',
    "ZM": 'Zambia',
    "ZW": 'Zimbabwe'
  };
  static const List<String> nationalityOptions = [
    '',
    'Singapore',
    'OTHERS',
    'Afghanistan',
    'Albania',
    'Algeria',
    'American Samoa',
    'Andorra',
    'Angola',
    'Anguilla',
    'Antarctica',
    'Antigua and Barbuda',
    'Argentina',
    'Armenia',
    'Aruba',
    'Australia',
    'Austria',
    'Azerbaijan',
    'Bahamas',
    'Bahrain',
    'Bangladesh',
    'Barbados',
    'Belarus',
    'Belgium',
    'Belize',
    'Benin',
    'Bermuda',
    'Bhutan',
    'Bolivia',
    'Bosnia and Herzegovina',
    'Botswana',
    'Brazil',
    'British Indian Ocean Territory',
    'British Virgin Islands',
    'Brunei',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'COTEDIVOIRE',
    'Cambodia',
    'Cameroon',
    'Canada',
    'Cape Verde',
    'Cayman Islands',
    'Central African Republic',
    'Chad',
    'Chile',
    'China',
    'Christmas Island',
    'Cocos Islands',
    'Colombia',
    'Comoros',
    'Cook Islands',
    'Costa Rica',
    'Croatia',
    'Cuba',
    'Curacao',
    'Cyprus',
    'Czech Republic',
    'DDGK',
    'Democratic Republic of the Congo',
    'Denmark',
    'Djibouti',
    'Dominica',
    'Dominican Republic',
    'East Timor',
    'Ecuador',
    'Egypt',
    'El Salvador',
    'Equatorial Guinea',
    'Eritrea',
    'Estonia',
    'Ethiopia',
    'Falkland Islands',
    'Faroe Islands',
    'Fiji',
    'Finland',
    'France',
    'French Polynesia',
    'Gabon',
    'Gambia',
    'Georgia',
    'Germany',
    'Ghana',
    'Gibraltar',
    'Greece',
    'Greenland',
    'Grenada',
    'Guam',
    'Guatemala',
    'Guernsey',
    'Guinea',
    'Guinea-Bissau',
    'Guyana',
    'Haiti',
    'Honduras',
    'Hong Kong',
    'Hungary',
    'Iceland',
    'India',
    'Indonesia',
    'Iran',
    'Iraq',
    'Ireland',
    'Isle of Man',
    'Israel',
    'Italy',
    'Ivory Coast',
    'Jamaica',
    'Japan',
    'Jersey',
    'Jordan',
    'Kazakhstan',
    'Kenya',
    'Kiribati',
    'Kosovo',
    'Kuwait',
    'Kyrgyzstan',
    'Laos',
    'Latvia',
    'Lebanon',
    'Lesotho',
    'Liberia',
    'Libya',
    'Liechtenstein',
    'Lithuania',
    'Luxembourg',
    'Macao',
    'Macedonia',
    'Madagascar',
    'Malawi',
    'Malaysia',
    'Maldives',
    'Mali',
    'Malta',
    'Marshall Islands',
    'Mauritania',
    'Mauritius',
    'Mayotte',
    'Mexico',
    'Micronesia',
    'Moldova',
    'Monaco',
    'Mongolia',
    'Montenegro',
    'Montserrat',
    'Morocco',
    'Mozambique',
    'Myanmar',
    'Namibia',
    'Nauru',
    'Nepal',
    'Netherlands',
    'Netherlands Antilles',
    'New Caledonia',
    'New Zealand',
    'Nicaragua',
    'Niger',
    'Nigeria',
    'Niue',
    'North Korea',
    'Northern Mariana Islands',
    'Norway',
    'Oman',
    'Pakistan',
    'Palau',
    'Palestine',
    'Panama',
    'Papua New Guinea',
    'Paraguay',
    'Peru',
    'Philippines',
    'Pitcairn',
    'Poland',
    'Portugal',
    'Puerto Rico',
    'Qatar',
    'Republic of the Congo',
    'Reunion',
    'Romania',
    'Russia',
    'Rwanda',
    'Saint Barthelemy',
    'Saint Helena',
    'Saint Kitts and Nevis',
    'Saint Lucia',
    'Saint Martin',
    'Saint Pierre and Miquelon',
    'Saint Vincent and the Grenadines',
    'Samoa',
    'San Marino',
    'Sao Tome and Principe',
    'Saudi Arabia',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leone',
    'Sint Maarten',
    'Slovakia',
    'Slovenia',
    'Solomon Islands',
    'Somalia',
    'South Africa',
    'South Korea',
    'South Sudan',
    'Spain',
    'Sri Lanka',
    'Sudan',
    'Suriname',
    'Svalbard and Jan Mayen',
    'Swaziland',
    'Sweden',
    'Switzerland',
    'Syria',
    'Taiwan',
    'Tajikistan',
    'Tanzania',
    'Thailand',
    'Togo',
    'Tokelau',
    'Tonga',
    'Trinidad and Tobago',
    'Tunisia',
    'Turkey',
    'Turkmenistan',
    'Turks and Caicos Islands',
    'Tuvalu',
    'U.S. Virgin Islands',
    'Uganda',
    'Ukraine',
    'United Arab Emirates',
    'United Kingdom',
    'United States',
    'Uruguay',
    'Uzbekistan',
    'Vanuatu',
    'Vatican',
    'Venezuela',
    'Vietnam',
    'Wallis and Futuna',
    'Western Sahara',
    'YUGOSLAVIA',
    'Yemen',
    'Zambia',
    'Zimbabwe'
  ];

  static const List<String> residentialOptions = [
    '',
    'Singapore',
    'PR',
    'Foreigner'
  ];
  static const List<String> ncdOptions = [
    '',
    '0%',
    '10%',
    '20%',
    '30%',
    '40%',
    '50%'
  ];

  static const List<String> weatherOptions = [
    '',
    'Clear & Dry',
    'Raining & Wet',
    'After Rain & Wet'
  ];

  static const List<String> reportingOptions = [
    '',
    'Reporting Only',
    'Claim Other Party',
    'Claim Own Insurance'
  ];

  static const List<String> purposeOptions = [
    '',
    'Private Use',
    'Work Purpose',
  ];

  static const List<String> relationshipOptions = [
    '',
    'Spouse',
    'Parents',
    'Children',
    'Sibling',
    'Employee',
    'Others'
  ];
}