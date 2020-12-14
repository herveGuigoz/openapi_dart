# 📘️ openapi-dart

🚀 Bild Dart class from Open Api ([Swagger]((https://swagger.io/specification/v2/))) documentation.

## Usage

### Provision required packages

run `pub get`

### Reading specs from file system
```bash
dart bin/openapi_dart.dart -j path/to/swagger.json -p /ressource
```

### Reading specs from remote resource
```bash
dart bin/openapi_dart.dart -r https://exemple.com/swagger.json -p /ressource
```

### Todo
- openApi v3.