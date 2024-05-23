# flutter_contacts

A Contacts Management app written in Flutter

## Getting started

### Backend

- Download the backend source code here https://github.com/minhluong-gft/grpc-contacts
- Run the backend using docker compose

  ```
  docker compose up
  ```

### Mobile

- Download the source code
- Install dependences

  ```
  flutter pub get
  ```

- Run build_runner to generate code

  ```
  dart run build_runner build
  ```

- Update your backend host url in line 22 of `lib/services/contacts_service.dart`
  ```
    const host = "YOUR HOST URL";
  ```
- Launch the simulator and then run the app

  ```
  flutter run
  ```

### Testing

- Generate testing snapshots

  ```
  flutter test --update-goldens
  ```

- Run test and generate coverage report

  ```
  flutter test --coverage
  ```

- Convert the coverage report to html format
  ```
  genhtml coverage/lcov.info -o coverage/html
  ```
  The generated report is located at `coverage/html/index.html`
