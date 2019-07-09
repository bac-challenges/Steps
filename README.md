# Reading and writing steps from HealthKit in Swift 5.0

## Overview

### General

- Swift version **5.0** - No changes to the **4.2** source.
- No external libraries

### First run

- Request to access `HealthKit` data
- Initial data for `Achievements` populated in `CoreData`

### States

- Authenticated
  - Steps available
  - No steps
  - Achievments
  - No achievments 
- Authentication failed

### Managers

- HealthKitManager
- CoreDataManager
- BootstrapManager

### Localization

- Main.storyboard - Not used in project
- Localizable.strings
