# Reading and Writing Steps from HealthKit in Swift 5.0

## Overview

### General

- Swift version 5.0
- iOS 12.2
- iPhone (portrait orientation) only
- XCode 10.2.1
- macOS 10.15 Beta 2
- Code based UI
- No external libraries

### Initial run

Request `HealthKit` data access

Initial data for `Achievements` inserted in `CoreData` from plist

```json
{
  "steps": 1000,
  "isUnlocked": true
}
```

### UI Flow

```swift
enum State {
    case content
    case error
    case empty
}
```
#### Launch Screen

#### SplashController  ————>  AuthFailed  ————>  HealthKit

#### StepsController

##### User Profile Cell

`Content`

- `Error`
- `Empty`

##### Steps Cell

- `Content`

#####  Chart Cell
	- `Content`

##### No Steps
```swift
- `Error`
- `Empty`
```

##### Achievements

	- `Content`
	- `Error`
	- `Empty`

## States

- Authenticating
- Authenticated
  - Steps available
  - Steps unavailable
    - Loading
    - Empty
  - Achievments available
  - Achievments unavailable 
- Authentication failed

### Managers

- HealthKitManager
- CoreDataManager
- BootstrapManager

### Localization

- Main.storyboard - Not used in project
- Localizable.strings

> Sample note

```

```
