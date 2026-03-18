
class ApiResponse<T> {
  final bool success;
  final String message;
  final T? data;
  final List<String>? errors;

//constructor to initalize apiresponse object
  const ApiResponse({
    required this.success,
    required this.message,
    this.data,
    this.errors,
  });

//factory constructor
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, //json data from the api
    T Function(dynamic)? fromData, //function to convert json 'data' into type T
  ) {
    return ApiResponse(
      success: json['success'] as bool,
      message: json['message'] as String,

      // Handle 'data' safely:
      // - Check if 'data' exists in JSON
      // - Check if conversion function is provided
      // - If yes → convert JSON to type T
      // - If no → keep it null
      data: json['data'] != null && fromData != null
          ? fromData(json['data'])
          : null,


      // Handle 'errors':
      // - If 'errors' exists → convert to List<String>
      // - If not → null
      errors: json['errors'] != null ? List<String>.from(json['errors']) : null,
    );
  }
}
