//
//  CDTWorkspace.h
//  CDTSeedCDTDatastorePlugin
//
//  Created by Adam Cox on 1/21/15.
//  Copyright (c) 2015 cloudant. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@interface CDTWorkspace : NSObject

+ (void)setWorkspaceWindow:(NSWindow *)window;
+ (NSString *)currentWorkspacePath;

@end
