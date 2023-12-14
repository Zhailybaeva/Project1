class Profile {
  final String qrCode;
  final String cardNumber;
  final String balance;
  final String name;
  final String surname;
  final String lastname;
  final String teacherFIO;
  final String mektep;
  final String classInfo;
  final String language;
  final String pol;


  Profile({
    required this.qrCode,
    required this.cardNumber,
    required this.balance,
    required this.name,
    required this.surname,
    required this.lastname,
    required this.teacherFIO,
    required this.mektep,
    required this.classInfo,
    required this.language,
    required this.pol,

  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      qrCode: json['qr_code'],
      cardNumber: json['card_number'],
      balance: json['balance'],
      name: json['name'],
      surname: json['surname'],
      lastname: json['lastname'] ?? "",
      teacherFIO: json['teacher_fio'],
      mektep: json['mektep'],
      classInfo: json['class'],
      language: json['language'],
      pol: json['pol'],
     
    );
  }
}


