import 'package:dio/dio.dart';

class ApiClient {
  late final Dio _dio;
  
  static const String _baseUrl = String.fromEnvironment(
    'BASE_URL',
    // 
    defaultValue: 'http://localhost:8000',
  );

  ApiClient() {
    final options = BaseOptions(
      baseUrl: _baseUrl,
      // 30 segundos para dar tiempo al backend RAG
      connectTimeout: const Duration(seconds: 30), 
      // 30 segundos para esperar la respuesta
      receiveTimeout: const Duration(seconds: 30), 
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    _dio = Dio(options);
  }

  // Método POST genérico
  Future<Map<String, dynamic>> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response.data;
    } on DioException catch (e) {
      // Manejo de errores de Dio específicos
      print('Error en ApiClient POST: $e');
      // Damos un mensaje de error más claro al usuario
      if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
        throw Exception('El servidor está tardando mucho en responder. Intenta de nuevo.');
      }
      throw Exception('Error de conexión: ${e.message}');
    } catch (e) {
      // Otros errores
      print('Error inesperado: $e');
      throw Exception('Error inesperado: $e');
    }
  }

  // Método GET (ejemplo para /health)
  Future<Map<String, dynamic>> get(String path) async {
    try {
      final response = await _dio.get(path);
      return response.data;
    } on DioException catch (e) {
      throw Exception('Error de conexión: ${e.message}');
    } catch (e) {
      throw Exception('Error inesperado: $e');
    }
  }
}


