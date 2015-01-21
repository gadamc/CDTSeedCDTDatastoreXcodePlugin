//
//  CDTStartReplicationViewController.h
//  CDTSeedCDTDatastorePlugin
//
//  Created by Adam Cox on 1/21/15.
//  Copyright (c) 2015 cloudant. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "CDTReplicatorDelegate.h"

@interface CDTStartReplicationViewController : NSWindowController <CDTReplicatorDelegate>

@property (weak) IBOutlet NSTextField *urlTextField;
- (IBAction)startPullReplicationButton:(id)sender;
@property (weak) IBOutlet NSButton *pullButton;
@property (weak) IBOutlet NSTextField *logTextField;
@property (weak) IBOutlet NSTextField *localDatastorePath;

@end
