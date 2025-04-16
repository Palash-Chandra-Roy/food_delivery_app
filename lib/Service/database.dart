import 'package:cloud_firestore/cloud_firestore.dart';

class DatebaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInfoMap);
  }

  Future addUserOrderDetails(
    Map<String, dynamic> userOrderMap,
    String id,
    String orderid,
  ) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Order")
        .doc(orderid)
        .set(userOrderMap);
  }

  Future addAdminDetails(
    Map<String, dynamic> userOrderMap,
    String orderid,
  ) async {
    return await FirebaseFirestore.instance
        .collection("Order")
        .doc(orderid)
        .set(userOrderMap);
  }
}
