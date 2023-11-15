class Session {
  Session({
    this.username,
    this.jwt,
    this.isAdmin,
    this.credit,
  });

  Session copyWith({
    String? username,
    String? jwt,
    bool? isAdmin,
    int? credit,
  }) =>
      Session(
        username: username ?? this.username,
        jwt: jwt ?? this.jwt,
        isAdmin: isAdmin ?? this.isAdmin,
        credit: credit ?? this.credit,
      );

  factory Session.fromJson(final Map<String, dynamic> json) => Session(
        username: json["username"],
        jwt: json["token"],
        isAdmin: json["admin"],
        credit: json["credit"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "token": jwt,
        "admin": isAdmin,
        "credit": credit,
      };

  final String? username;
  final String? jwt;
  final bool? isAdmin;
  final int? credit;

  bool get isAuthenticated => username != null && jwt != null;
}
