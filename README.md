# 📘️ openapi-dart

🚀 Bild Dart class from Open Api ([Swagger]((https://swagger.io/specification/v2/))) documentation.

## Usage

### Provision required packages

run `pub get`

### Reading specs from remote resource
```bash
dart bin/openapi_dart.dart -r https://petstore.swagger.io/v2/swagger.json -p /pet/{petId}/uploadImage
```

### Todo
- use freezed option.
- openApi v3.
- generate api call method option
- make work all options (POST, PUT, DELETE)