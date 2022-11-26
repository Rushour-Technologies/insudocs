import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:insudox/main.dart' as app;
import 'package:insudox/src/app.dart';
import 'package:insudox/src/classes/client_info_model.dart';
import 'package:insudox/src/classes/client_model.dart';
import 'package:insudox/src/classes/saviour_info_model.dart';
import 'package:insudox/src/classes/saviour_model.dart';

void main() {
  group('Class Testing', () {
    test('SaviourRequestInfo', () {
      SaviourRequestInfo saviourRequestInfo = SaviourRequestInfo.fromMap(
        _saviourRequestInfoDummy,
      );

      expect(saviourRequestInfo.name, 'Rushour');

      expect(saviourRequestInfo.qualification, 'B.Tech CSE');

      expect(saviourRequestInfo.specialization, 'Computer Science');

      expect(saviourRequestInfo.qualificationFileLink,
          'https://qualification-file-link');

      expect(saviourRequestInfo.universityName, 'MIT WPU');

      expect(saviourRequestInfo.experienceFileLink,
          'https://experience-file-link');

      expect(saviourRequestInfo.experience, '2YRS');

      expect(saviourRequestInfo.adhaarNumber, 'xxxx-xxxx-xxxx-1234');

      expect(saviourRequestInfo.photoURL, 'https://photo-url');

      expect(saviourRequestInfo.email, 'pataderushikesh@gmail.com');

      expect(saviourRequestInfo.gender, 'M');

      expect(saviourRequestInfo.approvalStatus, 'ACCEPTED');
    });
    print('Saviour Request Info test passed');

    test('ClientModel', () async {
      ClientModel clientModel = ClientModel.fromMap(_clientModelDummy);

      expect(clientModel.name, 'meow');
      expect(clientModel.photoURL, 'https://photo-url.png');
      expect(clientModel.insuranceType, 0);
      expect(clientModel.insuraceStatus, 0);
      expect(clientModel.email, 'rushour@gmail.com');
      expect(clientModel.reportLink, 'https://report-link.pdf');
    });
    print('Client Model test passed');

    test('SaviourModel', () async {
      SaviourModel saviourModel = SaviourModel.fromMap(_saviourModelDummy);
      expect(saviourModel.name, 'some-user');
      expect(saviourModel.qualification, 'B.Tech CSE');
      expect(saviourModel.specialization, 'CSE');
      expect(saviourModel.priorExperience, true);
      expect(saviourModel.yearsOfExperience, 2);
      expect(saviourModel.adhaarNumber, 'xxxx-xxxx-xxxx-1234');
      expect(saviourModel.gender, 'M');
      expect(saviourModel.closedClients, 5);
      expect(saviourModel.currentClients, 7);
      expect(saviourModel.pendingRequests, 9);
    });
    print('Saviour Model test passed');
  });
}

Map<String, dynamic> _saviourRequestInfoDummy = {
  'name': 'Rushour',
  'qualification': 'B.Tech CSE',
  'specialization': 'Computer Science',
  'qualificationFileLink': 'https://qualification-file-link',
  'universityName': 'MIT WPU',
  'experienceFileLink': 'https://experience-file-link',
  'experience': '2YRS',
  'maskedNumber': 'xxxx-xxxx-xxxx-1234',
  'photoURL': 'https://photo-url',
  'email': 'pataderushikesh@gmail.com',
  'gender': 'M',
  'uid': 'my-uid',
  'approvalStatus': 'ACCEPTED',
};

Map<String, dynamic> _clientModelDummy = {
  'photoURL': 'https://photo-url.png',
  'name': 'meow',
  'uid': 'other-uid',
  'insuranceType': 0,
  'insuraceStatus': 0,
  'email': 'rushour@gmail.com',
  'reportLink': 'https://report-link.pdf',
};

Map<String, dynamic> _saviourModelDummy = {
  'name': 'some-user',
  'qualification': 'B.Tech CSE',
  'universityName': 'MIT WPU',
  'specialization': 'CSE',
  'priorExperience': true,
  'yearsOfExperience': 2,
  'adhaarNumber': 'xxxx-xxxx-xxxx-1234',
  'gender': 'M',
  'closedClients': 5,
  'currentClients': 7,
  'pendingRequests': 9,
};
