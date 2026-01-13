// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart' show IterableExtension;

enum PermAction { create, view, update, delete }

extension PermActionX on PermAction {
  String get key => switch (this) {
    PermAction.create => 'create',
    PermAction.view => 'view',
    PermAction.update => 'update',
    PermAction.delete => 'delete',
  };

  String get label => switch (this) {
    PermAction.create => 'Create',
    PermAction.view => 'View',
    PermAction.update => 'Update',
    PermAction.delete => 'Delete',
  };
}

class SubMenu {
  final String name;
  final String baseKey;
  final bool includeWildcard;
  final List<PermAction> actions;

  const SubMenu({
    required this.name,
    required this.baseKey,
    this.includeWildcard = true,
    this.actions = const [
      PermAction.create,
      PermAction.view,
      PermAction.update,
      PermAction.delete
    ],
  });

  List<String> get permissionKeys {
    final list = <String>[];
    if (includeWildcard) list.add('$baseKey.*');
    list.addAll(actions.map((a) => '$baseKey.${a.key}'));
    return list;
  }

  factory SubMenu.fromJson(Map<String, dynamic> json) => SubMenu(
    name: json['name'],
    baseKey: json['baseKey'],
    includeWildcard: json['includeWildcard'] ?? true,
    actions: (json['actions'] as List?)
        ?.map((e) => PermAction.values
        .firstWhereOrNull((a) => a.key == e) ??
        PermAction.view)
        .toList() ??
        const [
          PermAction.create,
          PermAction.view,
          PermAction.update,
          PermAction.delete
        ],
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'baseKey': baseKey,
    'includeWildcard': includeWildcard,
    'actions': actions.map((a) => a.key).toList(),
  };
}

class Menu {
  final String menuName;
  final String permissionKey;
  final List<SubMenu> subMenus;

  const Menu({
    required this.menuName,
    required this.permissionKey,
    required this.subMenus,
  });

  List<String> get allPermissionKeys =>
      subMenus.expand((s) => s.permissionKeys).toList();

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
    menuName: json['menuName'],
    permissionKey: json['permissionKey'],
    subMenus: (json['subMenus'] as List)
        .map((e) => SubMenu.fromJson(e))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    'menuName': menuName,
    'permissionKey': permissionKey,
    'subMenus': subMenus.map((s) => s.toJson()).toList(),
  };
}
