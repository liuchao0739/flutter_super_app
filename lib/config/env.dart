enum Environment {
  dev,
  prod,
}

class Env {
  static Environment current = Environment.dev;

  static String get apiBaseUrl {
    switch (current) {
      case Environment.dev:
        return 'https://dev-api.example.com';
      case Environment.prod:
        return 'https://api.example.com';
    }
  }

  static bool get isDev => current == Environment.dev;
  static bool get isProd => current == Environment.prod;
}

