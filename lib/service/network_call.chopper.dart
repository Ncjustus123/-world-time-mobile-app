// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_call.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$AuthenticationClient extends AuthenticationClient {
  _$AuthenticationClient([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = AuthenticationClient;

  Future<Response> login(Map<String, dynamic> json) {
    final $url = '/api/token';
    final $body = json;
    final $request = Request('POST', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getProfile() {
    final $url = '/api/Account/GetProfile';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> updateProfile(Map<String, dynamic> json) {
    final $url = '/UpdateProfile';
    final $body = json;
    final $request = Request('GET', $url, client.baseUrl, body: $body);
    return client.send<dynamic, dynamic>($request);
  }
}
