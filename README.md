# Health Sync Dashboard

A Flutter health dashboard assignment that recreates the provided UI and reads real step data from:

- `Health Connect` on Android
- `HealthKit` on iOS

The app uses:

- `flutter_bloc` for state management
- `get_it` for dependency injection
- `Hive` for local step caching
- a modular feature structure with `presentation`, `domain`, and `data` layers for the steps flow

## Features

- Dashboard-style health UI
- Real step count integration through platform health APIs
- Cached step count loaded first on app launch
- Live step polling after startup
- Hive-based local storage for step history
- Clean dependency flow:
  - `presentation -> domain usecases -> domain repository -> data repository -> data sources`

## Project Structure

```text
lib/
  common/
  core/
    constants/
    error/
    services/
    storage/
  features/
    health_dashboard/
      data/
      domain/
      presentation/
  injection_container.dart
  main.dart
```

## Requirements

Before running the project, make sure you have:

- Flutter SDK installed
- Dart SDK installed
- Android Studio or Xcode
- A physical Android or iOS device is preferred for health data access



## Packages Used

Main dependencies:

- `health`
- `flutter_bloc`
- `bloc`
- `get_it`
- `hive`
- `hive_flutter`
- `dartz`
- `syncfusion_flutter_gauges`
- `syncfusion_flutter_charts`

## Setup

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd health_sync_dashboard
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Run code generation

Hive uses a generated adapter for the step history model.

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 4. Run the app

```bash
flutter run
```

## Steps Data Flow

The steps feature currently works like this:

1. App starts
2. Hive is initialized in `get_it`
3. `StepsBloc` is created
4. Cached steps are loaded from Hive first
5. UI shows cached data if available
6. Live polling starts for Health Connect / HealthKit
7. Fresh step values update the UI
8. Fresh values are stored back into Hive





### Important notes for iOS

- Run on a real iPhone for HealthKit testing
- HealthKit data is not reliably testable on a simulator
- The app must be granted Health access when prompted

If HealthKit capabilities are not yet added in Xcode for your signing target, add the `HealthKit` capability before running on device.
(not tested on a real ios device due to system unavailablity)



### Android

1. Install and open `Health Connect`
2. Grant the app access to steps
3. Make sure there is a valid step data source on the device
4. Launch the app
5. Confirm cached steps load first
6. Confirm live step updates continue after startup

### iOS

1. Run on a physical iPhone
2. Grant Health access
3. Ensure Health app contains step data
4. Launch the app
5. Confirm steps appear and update

## Common Issues




## Commands

Useful commands during development:

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter analyze
flutter test
flutter run
```

## Notes

- Steps use real health data
- Other dashboard values can remain demo data
- The app is designed around assignment requirements, with Hive cache first and fresh health sync afterward
