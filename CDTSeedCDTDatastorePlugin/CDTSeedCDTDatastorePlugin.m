//
//  CDTSeedCDTDatastorePlugin.m
//  CDTSeedCDTDatastorePlugin
//
//  Created by Adam Cox on 1/21/15.
//  Copyright (c) 2015 cloudant. All rights reserved.
//

#import "CDTSeedCDTDatastorePlugin.h"
#import "CDTStartReplicationViewController.h"
#import "CDTWorkspace.h"

static CDTSeedCDTDatastorePlugin *sharedPlugin;

@interface CDTSeedCDTDatastorePlugin()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@property (nonatomic, strong) CDTStartReplicationViewController *replicationWindow;
@end

@implementation CDTSeedCDTDatastorePlugin

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[self alloc] initWithBundle:plugin];
        });
    }
}

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _replicationWindow = nil;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        
        // Create menu items, initialize UI, etc.

        // Sample Menu Item:
        NSMenuItem *menuItem = [[NSApp mainMenu] itemWithTitle:@"Edit"];
        if (menuItem) {
            [[menuItem submenu] addItem:[NSMenuItem separatorItem]];
            NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:@"Seed CDTDatastore" action:@selector(doMenuAction:) keyEquivalent:@""];
            [actionMenuItem setTarget:self];
            [[menuItem submenu] addItem:actionMenuItem];
        }
    }
    return self;
}

//  Action
- (void)doMenuAction:(id)sender
{
    // get the window of the current workspace
    NSWindow *appWindow = [NSApp keyWindow];
    [CDTWorkspace setWorkspaceWindow:appWindow];
    
    if (!self.replicationWindow) {
        self.replicationWindow = [[CDTStartReplicationViewController alloc]
                              initWithWindowNibName:NSStringFromClass([CDTStartReplicationViewController class])];
    }
    
    [self.replicationWindow showWindow:sender];
}

@end
