//
//  CDTWorkspace.m
//  CDTSeedCDTDatastorePlugin
//
//  Created by Adam Cox on 1/21/15.
//  Copyright (c) 2015 cloudant. All rights reserved.
//

#import "CDTWorkspace.h"
#import "XcodeIDEHeaders.h"

@implementation CDTWorkspace

static NSWindow *gCurrentCDTWorkspaceWindow;


//+ (NSString *)currentWorkspacePath
//{
//    NSArray *workspaceWindowControllers = [NSClassFromString(@"IDEWorkspaceWindowController") valueForKey:@"workspaceWindowControllers"];
//    
//    // THIS IS WRONG. IF THERE ARE MORE THAN ONE WORKSPACES OPEN, THIS WILL
//    // ONLY PICK THE ONE THAT WAS OPENED FIRST
//    id workSpace = [workspaceWindowControllers[0] valueForKey:@"_workspace"];
//    
//    // OR, WE ASK THE USER WHERE TO PUT THE DATABASE
//    return [[workSpace valueForKey:@"representingFilePath"] valueForKey:@"_pathString"];
//}


//or maybe this is wrong too... in the beginning we should grab NSApp keyWindow before showing
//this window. 
//

+ (NSString *)currentWorkspacePath
{
    return [self directoryPathForWorkspace:[self workspaceForWindow:gCurrentCDTWorkspaceWindow]];
}

+ (NSString *)directoryPathForWorkspace:(id)workspace
{
    NSString *workspacePath = [[workspace valueForKey:@"representingFilePath"] valueForKey:@"_pathString"];
    return [workspacePath stringByDeletingLastPathComponent];
}

+ (void)setWorkspaceWindow:(NSWindow *)window
{
    gCurrentCDTWorkspaceWindow = window;
}

+ (id)workspaceForWindow:(NSWindow *)window
{
    NSArray *workspaceWindowControllers = [NSClassFromString(@"IDEWorkspaceWindowController") valueForKey:@"workspaceWindowControllers"];
    
    for (id controller in workspaceWindowControllers) {
        if ([[controller valueForKey:@"window"] isEqual:window]) {
            
//            id workspace = [controller valueForKey:@"_workspace"];
//            id arena = [workspace workspaceArena];
//            id arenainfo = [arena workspaceArenaInfo];
//            NSDictionary *arenaInfoDic = [arenainfo valueForKey:@"_infoDict"];
//            NSLog(@"Arena Info: %@", arenaInfoDic);
//            
//            id usersettings = [workspace userSettings];
//            NSDictionary *workspaceSettings = [usersettings valueForKey:@"_workspaceSettings"];
//            NSLog(@"user settings: %@", workspaceSettings);
            
            return [controller valueForKey:@"_workspace"];
        }
    }
    return nil;
}

@end
