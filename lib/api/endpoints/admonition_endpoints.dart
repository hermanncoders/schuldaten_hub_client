part of '../endpoints.dart';

class EndpointsAdmonition {
  //- POST
  static const postAdmonition = '/admonitions/new';

  //- GET
  static const fetchAdmonitions = '/admonitions/all';

  String getAdmonition(String id) {
    return '/admonitions/$id';
  }

  String getAdmonitionFile(String id) {
    return '/admonitions/$id/file';
  }

  //- PATCH
  String patchAdmonition(String id) {
    return '/admonition/$id/patch';
  }

  String patchAdmonitionFile(String id) {
    return '/admonition/$id/file';
  }

  //- DELETE
  String deleteAdmonition(String id) {
    return '/admonitions/$id/delete';
  }

//- DELETE
  String deleteAdmonitionFile(String id) {
    return '/admonitions/$id/file';
  }
}
