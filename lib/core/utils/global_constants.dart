import 'package:digify_app/core/common_providers/user_data_provider.dart';
import 'package:digify_app/core/model/user_data_model.dart';
import 'package:digify_app/core/utils/static_info.dart' show StaticInfo;
import 'package:flutter_riverpod/legacy.dart' show StateNotifierProvider;
import 'package:intl/intl.dart';


const defaultFontFamily = "Poppins";
Map<String, dynamic> header = {"authorization": StaticInfo.authToken};

final userDataProvider =
StateNotifierProvider<UserDataNotifier, AuthState>(
      (ref) => UserDataNotifier(),
);
// final userDataProvider = StateNotifierProvider<UserDataNotifier, AuthModel?>((
//   ref,
// ) {
//   return UserDataNotifier();
// });

final currentFormattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
// permission_menus.dart

final List<Map<String, dynamic>> permissionMenus = [
  {
    "menuName": "Workforce Structure",
    "permissionKey": "workforce_structure.*",
    "subMenus": [
      {
        "name": "Job",
        "permissions": [
          "workforce_structure.job.*",
          "workforce_structure.job.create",
          "workforce_structure.job.view",
          "workforce_structure.job.update",
          "workforce_structure.job.delete",
        ],
      },
      {
        "name": "Department",
        "permissions": [
          "workforce_structure.department.*",
          "workforce_structure.department.create",
          "workforce_structure.department.view",
          "workforce_structure.department.update",
          "workforce_structure.department.delete",
        ],
      },
      {
        "name": "Grade",
        "permissions": [
          "workforce_structure.grade.*",
          "workforce_structure.grade.create",
          "workforce_structure.grade.view",
          "workforce_structure.grade.update",
          "workforce_structure.grade.delete",
        ],
      },
      {
        "name": "Position",
        "permissions": [
          "workforce_structure.position.*",
          "workforce_structure.position.create",
          "workforce_structure.position.view",
          "workforce_structure.position.update",
          "workforce_structure.position.delete",
        ],
      },
      {
        "name": "Location",
        "permissions": [
          "workforce_structure.location.*",
          "workforce_structure.location.create",
          "workforce_structure.location.view",
          "workforce_structure.location.update",
          "workforce_structure.location.delete",
        ],
      },
    ],
  },
];
