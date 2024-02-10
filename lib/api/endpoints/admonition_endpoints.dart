part of '../endpoints.dart';

class EndpointsAdmonition {
  //- POST
  static const postAdmonition = '/admonition';

  //- GET
  static const fetchAdmonitions = '/api/admonition/all';

  String getAdmonition(String id) {
    return '/admonition/$id';
  }

  String getAdmonitionFile(String id) {
    return '/admonition/$id/file';
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
    return '/admonition/$id/delete';
  }

//- DELETE
  String deleteAdmonitionFile(String id) {
    return '/admonition/$id/file';
  }
}
