# 📘️ openapi-dart

🚀 Build Dart models from Open Api ([Swagger]((https://swagger.io/specification/v2/))) documentation for given path and method.

## Usage

### Reading specs from file system
```bash
dart bin/openapi_dart.dart -j path/to/swagger.json -p /books
```

### Reading specs from remote resource
```bash
dart bin/openapi_dart.dart -r https://exemple.com/swagger.json -p /books
```

### Options

- Displays help information.
```bash
dart bin/openapi_dart.dart --help
```

- Freezed class
```bash
dart bin/openapi_dart.dart -r https://exemple.com/swagger.json -p /books -f
```

- Add header for remote resource
```bash
dart bin/openapi_dart.dart -r https://exemple.com/swagger.json -p /books - h 'Authorization: Bearer ACCESS_TOKEN'
```

## Todo
- openApi v3.
