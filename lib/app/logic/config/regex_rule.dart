class RegexRule {
  static RegExp emptyValidationRule = RegExp(r'^(?!\s*$).+');

  // static CBRegexValidation numberValidationRule =
  //     CBRegexValidation(regex: r'^[0-9]*$', errorMesssage: "hanya angka");
  // static CBRegexValidation emailValidationRule = CBRegexValidation(
  //     regex:
  //         r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$',
  //     errorMesssage: "tidak sesuai");
  // static CBRegexValidation alphabetValidationRule = CBRegexValidation(
  //   regex: r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$",
  //   errorMesssage: "hanya huruf",
  // );
  // static CBRegexValidation nikValidationRule =
  //     CBRegexValidation(regex: r'^[0-9]{16}', errorMesssage: "NIK harus 16 digit");
  // static String passwordValidationRule =
  //     '((?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#%]).{6,10})';
  // static String whiteSpaceRule = 'r"\s+"';
  // static String simRule = r'^[0-9]{4}-[0-9]{4}-[0-9]{6}';
  // static String passportRule = r'^[A-Z]{1}[ ]{0,1}[0-9]{7}';
}
