CDTSeedCDTDatastoreXcodePlugin
---------------------------------

This plugin downloads a remote CouchDB database into your current Xcode workspace path. The database is stored in the CDTDatastore format (based on TouchDB). With a local copy of the datastore in the CDTDatastore format, you can bundle this with your application, eliminating the need to for any initial database download upon the first time the application launches (which would be useful under poor network conditions or large databases). 


This plugin shows up under Xcode -> Edit -> Seed CDTDatastore


Install by

1. clone this repo
2. cd into repo
3. pod install (requires cocoapods)
4. build
5. restart xcode

This plugin cannot be installed via Alcatraz.io because it relies upon cocoapods. However, Alcatraz.io plans to support this in the future. 


Uninstall by

```
rm -rf ~/Library/Application\ Support/Developer/Shared/Xcode/Plug-ins/CDTSeedCDTDatastorePlugin.xcplugin/
```

Still todo:

* automatically bundle database into Xcode project so that it ships with the application without requiring the developer to do anything by hand. Currently this plugin just downloads the database and places it somewhere reasonable (in the same directory as your workspace or project file). It's up the to developer to import this into their project.