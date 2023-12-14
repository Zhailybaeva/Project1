import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileRepo {
  final CollectionReference profileCollection =
      FirebaseFirestore.instance.collection('profile');

  Future<List<Map<String, dynamic>>?> fetchProfileData() async {
    try {
      QuerySnapshot querySnapshot = await profileCollection.get();

      if (querySnapshot.docs.isNotEmpty) {
        // Получаем список данных из всех документов в коллекции
        List<Map<String, dynamic>> profileDataList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
        return profileDataList;
      }
    } catch (e) {
      print('Ошибка при получении данных профиля: $e');
    }
    return null;
  }
}
