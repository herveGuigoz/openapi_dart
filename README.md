# 📘️ openapi-dart

🚀 Convert [2.0 (Swagger)](https://swagger.io/specification/v2/) path to Dart classes.

## Usage

### Provision required packages

run `pub get`

### Reading specs from remote resource
```bash
dart bin/openapi_dart.dart -u https://petstore.swagger.io/v2/swagger.json -p /pet/{petId}/uploadImage
```