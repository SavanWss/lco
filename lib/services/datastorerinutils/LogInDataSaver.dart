import 'package:little_miracles_orphange/utils/loggedInDetails/LoggedInDetails.dart';

class LogInDataSaver {
  static LogInDataSave(
      {required name,
      required mobile,
      required email,
      required dob,
      required role,
      required gender,
      required address,
      required profession,
      required totaldonatedfund,
      required adoptedchild,
      required yearlyincome,
      required marriedstatus}) {

    LoggedInDetails.userName = name;
    LoggedInDetails.userRole = role;
    LoggedInDetails.userAddress = address;
    LoggedInDetails.userAdoptedChild = adoptedchild;
    LoggedInDetails.userDob = dob;
    LoggedInDetails.userEmail = email;
    LoggedInDetails.userGender = gender;
    LoggedInDetails.userMarriedStatus = marriedstatus;
    LoggedInDetails.userMobile = mobile;
    LoggedInDetails.userProfession = profession;
    LoggedInDetails.userTotalDonatedFund = totaldonatedfund;
    LoggedInDetails.userYearlyIncome = yearlyincome;

  }
}
