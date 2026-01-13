class AuthState {
  final bool isLoading;
  final AuthModel? user;

  const AuthState({
    required this.isLoading,
    required this.user,
  });

  const AuthState.initial() : isLoading = true, user = null;

  AuthState copyWith({bool? isLoading, AuthModel? user}) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }

  bool get isAuthenticated => user != null;
}

class AuthModel {
  final String accessToken;
  final String refreshToken;
  final User user;

  AuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['accessToken'] ?? '',
      refreshToken: json['refreshToken'] ?? '',
      user: User.fromJson(json['user'] ?? json['users'] ?? const {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }
}

// ===================== USER & REFS (UPDATED) =====================

// ===================== USER & REFS (UPDATED) =====================

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String? mobile;
  final String? profilePhotoUrl;

  final CompanyRef? company;
  final BusinessUnitRef? businessUnit;

  final JobRef? job;
  final PositionRef? position;
  final GradeRef? grade;
  final double salary;
  final double commissionPct;
  final ManagerRef? manager;
  final UserDepartment? department;

  final String designation;
  final String employeeId;

  /// Dept-scoped role assignments from API "userRoles"
  final List<UserRoleAssignment> userRoles;

  /// Global/system roles from API "roles" (e.g., Super Admin)
  final List<RoleRef> globalRoles;

  /// Effective roles list from API "effectiveUserRoles" (dept-scoped + global {department:null, access:'ALL'})
  final List<EffectiveUserRoleAssignment> effectiveUserRoles;

  /// Optional single primary role object from API "role"
  final RoleRef? primaryRole;

  /// Optional legacy single-role string (kept for compatibility)
  final String? legacyRole;

  final String status;
  final bool emailVerified;
  final String emailVerificationToken;
  final DateTime? hireDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  /// Explicit user-level permissions returned by API
  final List<String> permissions;

  /// Map from API for quick UI flags
  final Map<String, bool> permissionFlags;

  final List<UserDepartment> managedDepartments;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    this.mobile,
    this.profilePhotoUrl,
    this.company,
    this.businessUnit,
    this.job,
    this.position,
    this.grade,
    required this.salary,
    required this.commissionPct,
    this.manager,
    this.department,
    required this.designation,
    required this.employeeId,
    this.userRoles = const [],
    this.globalRoles = const [],
    this.effectiveUserRoles = const [],
    this.primaryRole,
    this.legacyRole,
    required this.status,
    required this.emailVerified,
    required this.emailVerificationToken,
    this.hireDate,
    this.createdAt,
    this.updatedAt,
    required this.permissions,
    required this.permissionFlags,
    required this.managedDepartments,
  });

  /// Full name convenience
  String get fullName => '${firstName.trim()} ${lastName.trim()}'.trim();

  /// Permissions merged from:
  /// - explicit user.permissions
  /// - dept-scoped roles (userRoles.role.permissions)
  /// - global roles (globalRoles.permissions)
  /// - effectiveUserRoles.role.permissions
  List<String> get effectivePermissions {
    final seen = <String>{};
    final out = <String>[];

    void addAll(Iterable<String> perms) {
      for (final p in perms) {
        if (p.isNotEmpty && seen.add(p)) {
          out.add(p);
        }
      }
    }

    addAll(permissions);
    for (final ur in userRoles) {
      addAll(ur.role.permissions);
    }
    for (final gr in globalRoles) {
      addAll(gr.permissions);
    }
    for (final er in effectiveUserRoles) {
      addAll(er.role.permissions);
    }

    return out;
  }

  /// Permission check with wildcard support
  bool hasPermission(String key) {
    if (key.isEmpty) return false;
    final eff = effectivePermissions;

    if (eff.contains(key)) return true;

    final parts = key.split('.');
    for (int i = parts.length - 1; i >= 1; i--) {
      final prefix = parts.take(i).join('.');
      final wildcard = '$prefix.*';
      if (eff.contains(wildcard)) return true;
    }

    return eff.contains('*');
  }

  /// Convenience: is Super Admin (any global role named 'Super Admin' OR any effective role with isSystemRole & department == null)
  bool get isSuperAdmin {
    if (primaryRole?.name == 'Super Admin') return true;
    if (globalRoles.any((r) => r.name == 'Super Admin')) return true;
    if (effectiveUserRoles.any((e) => e.role.isSystemRole && e.department == null)) return true;
    return false;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    // ---- helpers ----
    Map<String, bool> parseBoolMap(dynamic m) {
      if (m is Map) {
        return m.map((k, v) => MapEntry(k.toString(), v == true));
      }
      return <String, bool>{};
    }

    List<String> parseStringList(dynamic v) {
      if (v is List) return v.whereType<String>().toList(growable: false);
      return const <String>[];
    }

    CompanyRef? parseCompany(dynamic v) {
      if (v == null) return null;
      if (v is String) return CompanyRef(id: v, companyName: '');
      if (v is Map<String, dynamic>) return CompanyRef.fromJson(v);
      return null;
    }

    BusinessUnitRef? parseBU(dynamic v) {
      if (v == null) return null;
      if (v is String) return BusinessUnitRef(id: v, businessUnitName: '');
      if (v is Map<String, dynamic>) return BusinessUnitRef.fromJson(v);
      return null;
    }

    UserDepartment? parseDept(dynamic v) {
      if (v == null) return null;
      if (v is String) return UserDepartment(id: v, departmentName: '');
      if (v is Map<String, dynamic>) return UserDepartment.fromJson(v);
      return null;
    }

    JobRef? parseJob(dynamic v) {
      if (v == null) return null;
      if (v is String) return JobRef(id: v, jobTitle: '');
      if (v is Map<String, dynamic>) return JobRef.fromJson(v);
      return null;
    }

    PositionRef? parsePosition(dynamic v) {
      if (v == null) return null;
      if (v is String) return PositionRef(id: v, positionTitle: '');
      if (v is Map<String, dynamic>) return PositionRef.fromJson(v);
      return null;
    }

    GradeRef? parseGrade(dynamic v) {
      if (v == null) return null;
      if (v is String) return GradeRef(id: v, gradeName: '');
      if (v is Map<String, dynamic>) return GradeRef.fromJson(v);
      return null;
    }

    ManagerRef? parseManager(dynamic v) {
      if (v == null) return null;
      if (v is String) return ManagerRef(id: v, firstName: '', lastName: '');
      if (v is Map<String, dynamic>) return ManagerRef.fromJson(v);
      return null;
    }

    List<UserRoleAssignment> parseUserRoles(dynamic v) {
      if (v is List) {
        return v.map<UserRoleAssignment>((e) {
          if (e is UserRoleAssignment) return e;

          if (e is Map<String, dynamic>) {
            final hasRoleKey = e.containsKey('role');
            final hasDeptKey = e.containsKey('department');
            if (hasRoleKey || hasDeptKey) {
              return UserRoleAssignment.fromJson(e);
            }
            // "roles" shape shouldn't come here; guarded below.
            final role = RoleRef.fromJson(e);
            return UserRoleAssignment(
              role: role,
              department: UserDepartment(id: '', departmentName: ''),
            );
          }

          if (e is String) {
            return UserRoleAssignment(
              role: RoleRef(id: e, name: '', isSystemRole: false, permissions: const []),
              department: UserDepartment(id: '', departmentName: ''),
            );
          }

          return UserRoleAssignment(
            role: RoleRef(id: '', name: '', isSystemRole: false, permissions: const []),
            department: UserDepartment(id: '', departmentName: ''),
          );
        }).toList(growable: false);
      }
      return const <UserRoleAssignment>[];
    }

    List<RoleRef> parseGlobalRoles(dynamic v) {
      if (v is List) {
        return v.map<RoleRef>((e) {
          if (e is RoleRef) return e;
          if (e is Map<String, dynamic>) return RoleRef.fromJson(e);
          if (e is String) return RoleRef(id: e, name: '', isSystemRole: false);
          return RoleRef(id: '', name: '', isSystemRole: false);
        }).toList(growable: false);
      }
      return const <RoleRef>[];
    }

    List<EffectiveUserRoleAssignment> parseEffectiveUserRoles(dynamic v) {
      if (v is List) {
        return v.map<EffectiveUserRoleAssignment>((e) {
          if (e is EffectiveUserRoleAssignment) return e;
          if (e is Map<String, dynamic>) return EffectiveUserRoleAssignment.fromJson(e);
          return EffectiveUserRoleAssignment(
            role: RoleRef(id: '', name: '', isSystemRole: false, permissions: const []),
            department: null,
            access: null,
          );
        }).toList(growable: false);
      }
      return const <EffectiveUserRoleAssignment>[];
    }

    // ---- build ----
    return User(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      mobile: json['mobile'],
      profilePhotoUrl: json['profilePhotoUrl'],

      company: parseCompany(json['company']),
      businessUnit: parseBU(json['businessUnit']),

      job: parseJob(json['job']),
      position: parsePosition(json['position']),
      grade: parseGrade(json['grade']),

      salary: (json['salary'] is num) ? (json['salary'] as num).toDouble() : 0.0,
      commissionPct: (json['commissionPct'] is num)
          ? (json['commissionPct'] as num).toDouble()
          : 0.0,

      manager: parseManager(json['manager']),
      department: parseDept(json['department']),

      designation: json['designation'] ?? '',
      employeeId: json['employeeId'] ?? '',

      // Parse the two separate arrays explicitly
      userRoles: parseUserRoles(json['userRoles']),
      globalRoles: parseGlobalRoles(json['roles']),

      effectiveUserRoles: parseEffectiveUserRoles(json['effectiveUserRoles']),
      primaryRole: (json['role'] is Map<String, dynamic>)
          ? RoleRef.fromJson(json['role'])
          : null,

      legacyRole: json['role'] is String ? json['role'] as String? : null,

      status: json['status'] ?? '',
      emailVerified: json['emailVerified'] ?? false,
      emailVerificationToken: json['emailVerificationToken'] ?? '',

      hireDate: json['hireDate'] != null
          ? DateTime.tryParse(json['hireDate'].toString())
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'].toString())
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'].toString())
          : null,

      permissions: parseStringList(json['permissions']),
      permissionFlags: parseBoolMap(json['permissionFlags']),

      managedDepartments: (json['managedDepartments'] as List? ?? const [])
          .map<UserDepartment>((e) {
        if (e is UserDepartment) return e;
        if (e is String) {
          return UserDepartment(id: e, departmentName: '');
        } else if (e is Map<String, dynamic>) {
          return UserDepartment.fromJson(e);
        }
        return UserDepartment(id: '', departmentName: '');
      }).toList(growable: false),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'mobile': mobile,
      'profilePhotoUrl': profilePhotoUrl,
      'company': company?.toJson() ?? company?.id,
      'businessUnit': businessUnit?.toJson() ?? businessUnit?.id,
      'job': job?.toJson() ?? job?.id,
      'position': position?.toJson() ?? position?.id,
      'grade': grade?.toJson() ?? grade?.id,
      'salary': salary,
      'commissionPct': commissionPct,
      'manager': manager?.toJson() ?? manager?.id,
      'department': department?.toJson() ?? department?.id,
      'designation': designation,
      'employeeId': employeeId,

      'userRoles': userRoles.map((r) => r.toJson()).toList(growable: false),
      'roles': globalRoles.map((r) => r.toJson()).toList(growable: false),
      'effectiveUserRoles':
      effectiveUserRoles.map((r) => r.toJson()).toList(growable: false),

      // prefer serializing the primary role if present; otherwise legacy string
      if (primaryRole != null) 'role': primaryRole!.toJson() else 'role': legacyRole,

      'status': status,
      'emailVerified': emailVerified,
      'emailVerificationToken': emailVerificationToken,
      'hireDate': hireDate?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'permissions': permissions,
      'permissionFlags': permissionFlags,
      'managedDepartments':
      managedDepartments.map((d) => d.toJson()).toList(growable: false),
    };
  }

  User copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phoneNumber,
    String? mobile,
    String? profilePhotoUrl,
    CompanyRef? company,
    BusinessUnitRef? businessUnit,
    JobRef? job,
    PositionRef? position,
    GradeRef? grade,
    double? salary,
    double? commissionPct,
    ManagerRef? manager,
    UserDepartment? department,
    String? designation,
    String? employeeId,
    List<UserRoleAssignment>? userRoles,
    List<RoleRef>? globalRoles,
    List<EffectiveUserRoleAssignment>? effectiveUserRoles,
    RoleRef? primaryRole,
    String? legacyRole,
    String? status,
    bool? emailVerified,
    String? emailVerificationToken,
    DateTime? hireDate,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<String>? permissions,
    Map<String, bool>? permissionFlags,
    List<UserDepartment>? managedDepartments,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      mobile: mobile ?? this.mobile,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      company: company ?? this.company,
      businessUnit: businessUnit ?? this.businessUnit,
      job: job ?? this.job,
      position: position ?? this.position,
      grade: grade ?? this.grade,
      salary: salary ?? this.salary,
      commissionPct: commissionPct ?? this.commissionPct,
      manager: manager ?? this.manager,
      department: department ?? this.department,
      designation: designation ?? this.designation,
      employeeId: employeeId ?? this.employeeId,
      userRoles: userRoles ?? this.userRoles,
      globalRoles: globalRoles ?? this.globalRoles,
      effectiveUserRoles: effectiveUserRoles ?? this.effectiveUserRoles,
      primaryRole: primaryRole ?? this.primaryRole,
      legacyRole: legacyRole ?? this.legacyRole,
      status: status ?? this.status,
      emailVerified: emailVerified ?? this.emailVerified,
      emailVerificationToken: emailVerificationToken ?? this.emailVerificationToken,
      hireDate: hireDate ?? this.hireDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      permissions: permissions ?? this.permissions,
      permissionFlags: permissionFlags ?? this.permissionFlags,
      managedDepartments: managedDepartments ?? this.managedDepartments,
    );
  }
}

// --------------------- Simple Refs ---------------------

class CompanyRef {
  final String id;
  final String companyName;

  CompanyRef({required this.id, required this.companyName});

  factory CompanyRef.fromJson(Map<String, dynamic> json) {
    return CompanyRef(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      companyName: json['companyName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'companyName': companyName,
  };
}

class BusinessUnitRef {
  final String id;
  final String businessUnitName;

  BusinessUnitRef({required this.id, required this.businessUnitName});

  factory BusinessUnitRef.fromJson(Map<String, dynamic> json) {
    return BusinessUnitRef(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      businessUnitName: json['businessUnitName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'businessUnitName': businessUnitName,
  };
}

// --------------------- Role & Assignments ---------------------

class RoleRef {
  final String id;
  final String name;
  final bool isSystemRole;

  /// Optional role-level permissions provided by API
  final List<String> permissions;

  RoleRef({
    required this.id,
    required this.name,
    required this.isSystemRole,
    this.permissions = const [],
  });

  factory RoleRef.fromJson(Map<String, dynamic> json) {
    final perms = (json['permissions'] is List)
        ? (json['permissions'] as List).whereType<String>().toList()
        : const <String>[];
    return RoleRef(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      name: json['name'] ?? '',
      isSystemRole: json['isSystemRole'] ?? false,
      permissions: perms,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'isSystemRole': isSystemRole,
    if (permissions.isNotEmpty) 'permissions': permissions,
  };
}

class UserRoleAssignment {
  final RoleRef role;
  final UserDepartment department;

  UserRoleAssignment({
    required this.role,
    required this.department,
  });

  factory UserRoleAssignment.fromJson(Map<String, dynamic> json) {
    return UserRoleAssignment(
      role: RoleRef.fromJson(json['role'] ?? const {}),
      department: UserDepartment.fromJson(json['department'] ?? const {}),
    );
  }

  Map<String, dynamic> toJson() => {
    'role': role.toJson(),
    'department': department.toJson(),
  };
}

/// For API field "effectiveUserRoles"
class EffectiveUserRoleAssignment {
  final RoleRef role;

  /// Department may be null for global/system access
  final UserDepartment? department;

  /// e.g. "ALL"
  final String? access;

  EffectiveUserRoleAssignment({
    required this.role,
    required this.department,
    required this.access,
  });

  factory EffectiveUserRoleAssignment.fromJson(Map<String, dynamic> json) {
    final dept = json['department'];
    return EffectiveUserRoleAssignment(
      role: RoleRef.fromJson(json['role'] ?? const {}),
      department: (dept == null)
          ? null
          : (dept is Map<String, dynamic>
          ? UserDepartment.fromJson(dept)
          : UserDepartment(id: dept.toString(), departmentName: '')),
      access: (json['access']?.toString().isNotEmpty ?? false)
          ? json['access'].toString()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'role': role.toJson(),
    'department': department?.toJson(),
    if (access != null) 'access': access,
  };
}

// --------------------- Other simple refs ---------------------

class UserDepartment {
  final String id;
  final String departmentName;

  UserDepartment({
    required this.id,
    required this.departmentName,
  });

  factory UserDepartment.fromJson(Map<String, dynamic> json) {
    return UserDepartment(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      departmentName: json['departmentName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'departmentName': departmentName,
  };
}

class JobRef {
  final String id;
  final String jobTitle;

  JobRef({required this.id, required this.jobTitle});

  factory JobRef.fromJson(Map<String, dynamic> json) {
    return JobRef(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      jobTitle: json['jobTitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'jobTitle': jobTitle,
  };
}

class PositionRef {
  final String id;
  final String positionTitle;

  PositionRef({required this.id, required this.positionTitle});

  factory PositionRef.fromJson(Map<String, dynamic> json) {
    return PositionRef(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      positionTitle: json['positionTitle'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'positionTitle': positionTitle,
  };
}

class GradeRef {
  final String id;
  final String gradeName;

  GradeRef({required this.id, required this.gradeName});

  factory GradeRef.fromJson(Map<String, dynamic> json) {
    return GradeRef(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      gradeName: json['gradeName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'gradeName': gradeName,
  };
}

class ManagerRef {
  final String id;
  final String firstName;
  final String lastName;

  ManagerRef({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory ManagerRef.fromJson(Map<String, dynamic> json) {
    return ManagerRef(
      id: (json['_id'] ?? json['id'] ?? '').toString(),
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'firstName': firstName,
    'lastName': lastName,
  };
}



