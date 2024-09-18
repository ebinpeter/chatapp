import 'package:googleapis_auth/auth_io.dart';

class AccessTokenFirebase {
  static String firebaseMessagingScope =
      "https://www.googleapis.com/auth/firebase.messaging";

  Future<String> getAccessToke() async {
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "mychat-5b639",
          "private_key_id": "24a9cdb968ceb7751a918b005507ddef0ef21afd",
          "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC372gG3nR+NHQ5\nU/qlRqRAgl3o+W9kN+SdrmAwwruBo/DzetdUY3DOQEVcOFDVJeqckgDj5ZZn/uV1\nj9tNeT1FfIaiU2vQZJRgiyxBAYxPK+AdUVYOCnASz5YaHhSd+fIeleKSa/14VO96\n8iEcKTlAmodDQeWoF76OXJF7Tw5+Ix23nkXGNpUMqepzIUnM7Fy6lBrA7dw8HK7z\nnpqqIl1l403uhFg8Kc+MOyrJ5s3KWhUTmTBlbWL2wufqjFrEuT7xJjRjpQ7TXa6b\n5zlsIiLZ9gbnXLdpW2fDpCUrIyo7xeVUva/RlKKVg2D2FSn9FovpQ87GZqTMLVjU\n3hG93CDbAgMBAAECggEADmYxDBydHQYpNRW0cPzbPeuWw3bHeB6CCLAOerK78BWv\n9reepM4WFidk5qfH+C+8Mp6hcDXYdPK47t+gqOt9VvO9LHcAYTOGhBpREBO5crc6\nF8F2zamWhXp3wzqonYdkI23Ta2gF00Y+6y6KVgSKJVsTjLnbazHUqptnjjItrcUb\nAVi9ko1wMAnlhLuy/3ezx9TRXgFzd8KoGsTW8CmH5TAUOBIHsIU6356V5Ceh51vJ\nXcaOW/9gxpc/tp4Kpd2qB6k3PvTLUMn4E5vCWDs18C/JLh7lE3UA9UkzwZmI6GV0\n1mwSpfemqgfNPLioNxwu9edNxn9xbNjBxdHkZ9U2DQKBgQDeuvHuJpPmcGfUZPnr\nY5BkX1GuCo3D4B2s6eVV6ZzjSiC++nveofR7JOJIpYTRH6ZuU3t5ltQvoIWJJ5pd\nr6yJZyshWfII3xtQ4SoHixwO1Dh87u70WfjcuThNg3lmMqiqg1Py3pQZQtkHxY+I\nIR4t3NpOO95xxHNOX7grm3VTJQKBgQDTaPa+Ze2kLtQPFoz5T4CVKII1fAd0CSjn\nXxOSsS3tvEHTutAgqEIvA03uJ8ywsrNqZWfuHayloQj8xOdMGYzAc0o93c/zSctq\nsvAxTj86P8j/QnK97ZNFvktbXqX5IVJCYjIS3vpq2fCQ5i4D3rHVX9pP03JSs2P8\ngeN/tUtj/wKBgQCXw+p1y/ObYZxeLS/eJMmOmySc4rQWc+/Ektuh3rz4YtpNR4CA\nAvsDre5CcgY+OMK/CkNoZk3O5iIXgtS8Yae/OH07DH7PbLbANazd1vwXXqPe/S/1\ncBkSzWJ/7sYZzQsApNve8asYS2R21zcmGurldUeLZ1/7RVEMZkyn6hXXwQKBgQCA\nhC57UDtGs7D1+x9373ybMCT3no5pW6gh/wpHAq6I9wiNTeN39tFFAx08ybUFNZ0b\n8MldV2y8w0hTYN+6w01tMKjRMyZXH2UpV93sG0UUg/IMOrjF/MaqfyQQR1leOYNo\nF4mZLzPMAPDdJRCUCazRqZNtM30sCSGfPtatq+hIwQKBgBJGsoECzXHgBF/gMqKA\nr3QzM9XzATTFJpNH8fVJ047I41UjJoz+TGY3iUE0a89WCxrfigHcYqFnTyWsfCW7\nBOC0/lv9hFq/UhWdsEmd3N7yfQOSuQ6k7eX5u+ac2Swy8Hy2aPTisPGKb8eIdycl\nvAQJOucvuYT8dTNh3AUfOML5\n-----END PRIVATE KEY-----\n",
          "client_email":
          "firebase-adminsdk-sewk5@mychat-5b639.iam.gserviceaccount.com",
          "client_id": "117392730584565009255",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
          "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
          "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-sewk5%40mychat-5b639.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        [firebaseMessagingScope]);

    final accessToken = client.credentials.accessToken.data;

    return accessToken;
  }
}
