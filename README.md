# Reading and Writing Steps from HealthKit in Swift 5.0

### General

- Swift version 5.0
- iPhone iOS 12.2 - portrait orientation only
- XCode 10.2.1
- macOS 10.15 Beta 3
- Code based UI
- No external libraries

### Initial run

Requests `HealthKit` data access

Initial data for `Badges` (*Achievements*) inserted in `CoreData`

### Model

```swift
class Badge: NSManagedObject {
	@NSManaged public var steps: Int32
	@NSManaged public var name: String
	@NSManaged public var image: String
}

class Steps: NSManagedObject {
	@NSManaged public var steps: Int32
	@NSManaged public var date: Date
}
```

### Managers

- BootstrapManager
- HealthKitStore

### Data Store

- CoreDataStore

### Localization

- English

- Arabic

- Hebrew

- Spanish

- Greek

- German

- Japanese

> All translations, provied by [Lokalise.co](https://www.Lokalise.co), are automated and used for test purposes only. Default localisation is `de_DE` and can be changed in `Edit Scheme>Run>Application Language`.

