//
//  XcodeIDEHeaders.h
//  CDTSeedCDTDatastorePlugin
//
//  Created by Adam Cox on 1/21/15.
//  Copyright (c) 2015 cloudant. All rights reserved.
//

#ifndef CDTSeedCDTDatastorePlugin_XcodeIDEHeaders_h
#define CDTSeedCDTDatastorePlugin_XcodeIDEHeaders_h

#import <Cocoa/Cocoa.h>

@class IDEWorkspace;

@interface DVTFilePath : NSObject
@property(readonly) DVTFilePath *symbolicLinkDestinationFilePath;
@property(readonly) NSURL *fileReferenceURL;
@property(readonly) NSDictionary *fileSystemAttributes;
@property(readonly) NSDictionary *fileAttributes;
@property(readonly) NSString *fileTypeAttribute;
@property(readonly) NSArray *sortedDirectoryContents;
@property(readonly) NSArray *directoryContents;
@property(readonly) NSDate *modificationDate;
@property(readonly) BOOL isExcludedFromBackup;
@property(readonly) BOOL isExecutable;
@property(readonly) BOOL isDeletable;
@property(readonly) BOOL isWritable;
@property(readonly) BOOL isReadable;
@property(readonly) BOOL existsInFileSystem;
@property(readonly) NSString *fileName;
@property(readonly) NSURL *fileURL;
@property(readonly) NSString *pathString;
@property(readonly) DVTFilePath *volumeFilePath;
@property(readonly) DVTFilePath *parentFilePath;
@end

@interface IDEWorkspaceWindowController : NSWindowController
@end

@interface IDEWorkspaceArenaInfo : NSObject
@property(readonly) DVTFilePath *workspacePath;

@end

@interface IDEWorkspaceArena : NSObject
@property(readonly) IDEWorkspace *workspace;
@property(readonly) IDEWorkspaceArenaInfo *workspaceArenaInfo;
@property(readonly) DVTFilePath *testResultsFolderPath;
@property(readonly) DVTFilePath *logFolderPath;
@property(readonly) DVTFilePath *indexPrecompiledHeadersFolderPath;
@property(readonly) DVTFilePath *indexFolderPath;
@property(readonly) DVTFilePath *precompiledHeadersFolderPath;
@property(readonly) DVTFilePath *installingBuildFolderPath;
@property(readonly) DVTFilePath *archivingBuildFolderPath;
@property(readonly) DVTFilePath *buildIntermediatesFolderPath;
@end


@interface IDEWorkspaceSettings : NSObject
@end

@interface IDEWorkspaceUserSettings : IDEWorkspaceSettings
@end

@interface IDEWorkspace : NSObject
@property BOOL isCleaningBuildFolder;
@property(nonatomic) BOOL finishedLoading;
@property(nonatomic) BOOL pendingFileReferencesAndContainers;
@property BOOL initialContainerScanComplete;
@property(retain, nonatomic) IDEWorkspaceArena *workspaceArena;
@property(readonly) DVTFilePath *wrappedXcode3ProjectPath;
@property(readonly) NSString *representingTitle;
@property(readonly) DVTFilePath *representingFilePath;
@property(retain, nonatomic) IDEWorkspaceUserSettings *userSettings;
@end

#endif
