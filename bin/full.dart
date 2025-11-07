import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

void main() async {
  final router = Router();

  final reports = [
    {
        'titulo': 'Reporte de ventas',
        'descripcion': 'Ventas totales: \$12,000',
        'fecha': '2025-11-07'
      },
      {
        'titulo': 'Reporte de inventario',
        'descripcion': 'Faltan 5 productos en stock',
        'fecha': '2025-11-06'
      },
    ];

  final users = [{
    "name":"Ian",
    "age": 21,
    "phone": "6121599287",
  },
  {
    "name":"David",
    "age": 28,
    "phone": "6121542366",
  },
  ];
  router.get('/hello', (Request request) {
    return Response.ok('Hello, World');
  });

  router.get('/reports', (Request request){
    final jsonResponse = jsonEncode(reports);
    return Response.ok(
      jsonResponse,
      headers: {'content-type': 'application/json'},
    );
  });

  router.get('/users', (Request request){
    final jsonResponse = jsonEncode(users);
    return Response.ok(
      jsonResponse,
      headers: {'content-type': 'application/json'},
    );
  });
  final handler = const Pipeline()
    .addMiddleware(logRequests())
    .addHandler(router);

  await io.serve(handler, 'localhost', 8080);
  print('El servidor esta corriendo en el puerto 8080');
}