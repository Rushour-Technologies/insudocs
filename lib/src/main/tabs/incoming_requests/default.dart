import 'package:insudox/globals.dart';
import 'package:insudox/src/classes/client_info_model.dart';
import 'package:insudox/src/classes/insurance_enums.dart';
import 'package:insudox/src/classes/saviour_info_model.dart';

List<ClientRequestInfo> clientRequestInfoList = List.generate(
  20,
  (index) => const ClientRequestInfo(
    name: 'John Doe',
    insuranceType: 1,
    insuraceStatus: 1,
    email: 'pataderushikesh@gmail.com',
    reportLink: 'https://www.google.com',
    photoURL: DEFAULT_PROFILE_PICTURE,
    uid: 'sdf',
  ),
);

List<SaviourRequestInfo> saviourRequestInfoList = List.generate(
  20,
  (index) => SaviourRequestInfo(
    name: 'John Doe',
    email: 'water@gmail.com',
    photoURL: DEFAULT_PROFILE_PICTURE,
    adhaarNumber: '123456789012',
    gender: 'M',
    qualificationFileLink: 'https://www.google.com',
    experienceFileLink: 'https://www.google.com',
    experience: "2",
    universityName: 'IIT',
    uid: 'sdf',
    specialization: 'Heath Claim',
    qualification: 'B.Tech',
    approvalStatus: ApprovalStatus.PENDING.data,
  ),
);
