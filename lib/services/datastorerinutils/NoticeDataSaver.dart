import 'package:little_miracles_orphange/utils/managenotice/NoticeDetails.dart';

class NoticeDataSaver {
  static noticeDataSaver(
      {required noticeTiming,
      required description,
      required eventTime,
      required eventMode,
      required eventTitle,
      required eventTopic,
      required organisedBy,
      required uniqueId}) {

        NoticeDetails.noticeIssuedTime = noticeTiming;
        NoticeDetails.noticeDescription = description;
        NoticeDetails.noticeEventDateTime = eventTime;
        NoticeDetails.noticeEventMode = eventMode;
        NoticeDetails.noticeEventTitle = eventTitle;
        NoticeDetails.noticeEventTopic = eventTopic;
        NoticeDetails.noticeOrganisedBy = organisedBy;
        NoticeDetails.noticeId = uniqueId;

      }
}
