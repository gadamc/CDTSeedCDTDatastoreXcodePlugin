//
//  CDTStartReplicationViewController.m
//  CDTSeedCDTDatastorePlugin
//
//  Created by Adam Cox on 1/21/15.
//  Copyright (c) 2015 cloudant. All rights reserved.
//

#import "CDTStartReplicationViewController.h"
#import <CloudantSync.h>
#import "CDTWorkspace.h"

@interface CDTStartReplicationViewController ()

@property (nonatomic, strong) CDTDatastoreManager* dsManager;
@property (nonatomic, strong) CDTDatastore *datastore;
@property (nonatomic, strong) CDTReplicatorFactory *replicatorFactory;
@property (nonatomic, strong) CDTReplicator *replicator;

@property (nonatomic, strong) NSString *currentWorkingDir;

@end

@implementation CDTStartReplicationViewController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
}

- (void)setupLocalDirectory:(NSString *)dirName
{
    NSString *currentWorkspace = [CDTWorkspace currentWorkspacePath];
    if (currentWorkspace) {
        
        self.currentWorkingDir = [[currentWorkspace stringByDeletingPathExtension]
                                  stringByAppendingPathComponent:dirName];
        
        self.localDatastorePath.stringValue  = [NSString stringWithFormat:
                                                @"DB Path: %@",self.currentWorkingDir];
        
        NSError *error;
        self.dsManager = [[CDTDatastoreManager alloc] initWithDirectory:self.currentWorkingDir
                                                                  error:&error];
        
        if (nil != error) {
            [self log:[NSString stringWithFormat:@"Error creating manager: %@", error]];
            return;
        }
        
        
        self.replicatorFactory = [[CDTReplicatorFactory alloc]
                                  initWithDatastoreManager:self.dsManager];
        
        [self log:[NSString stringWithFormat:@"Found workspace path: %@",self.currentWorkingDir]];
        
    }
    else {
        [self log:@"Failed to get current workspace path"];
    }
    
}

- (IBAction)startPullReplicationButton:(id)sender
{
    if (sender != self.pullButton) {
        NSLog(@"wrong button");
    }
    if ([self.urlTextField.stringValue isEqualToString:@""]) {
        [self log:[NSString stringWithFormat:@"Remote URL not set"]];
        return;
    }
    
    
    NSURL *sourceURL = [NSURL URLWithString:self.urlTextField.stringValue];
    
    if (sourceURL == nil) {
        [self log:[NSString stringWithFormat:@"invalid URL format: %@",
                   self.urlTextField.stringValue]];
        return;
    }
    
    NSArray *stringArray = [[sourceURL host] componentsSeparatedByString: @"."];
    NSString *reverseHost = nil;
    for (NSString *comp in [stringArray reverseObjectEnumerator]) {
        if (reverseHost == nil) {
            reverseHost = [NSString stringWithString:comp];
        }
        else {
            reverseHost = [reverseHost stringByAppendingFormat:@".%@", comp];
        }
    }
    
    [self setupLocalDirectory:reverseHost];
    
    NSError *error;
    self.datastore = nil;
    self.replicator = nil;
    
    self.datastore = [self.dsManager datastoreNamed:sourceURL.lastPathComponent error:&error];
    
    if (!self.datastore) {
        [self log:[NSString stringWithFormat:@"Error creating local datastore: %@", error]];
        
        return;
    }
    
    NSLog(@"starting replication. last sequence: %lld", [self.datastore.database lastSequence]);
    NSLog(@"last sequence: %lld", [self.datastore.database lastSequence]);
    //NSLog(@"checkpoint ID: %@", [self.replicator.tdReplicator remoteCheckpointDocID]);
    //NSLog(@"last sequence from checkpoint doc: %@", [self.datastore.database lastSequenceWithCheckpointID:[self.replicator.tdReplicator remoteCheckpointDocID]]);
    
    CDTPullReplication *config = [CDTPullReplication replicationWithSource:sourceURL
                                                                    target:self.datastore];
    
    [self log:[NSString stringWithFormat:@"Creating replication: %@", config]];
    
    self.replicator = [self.replicatorFactory oneWay:config error:&error];
    
    self.replicator.delegate = self;
    
    if (!self.replicator) {
        [self log:[NSString stringWithFormat:@"Error creating replicator: %@", error]];
        return;
    }
    
    if (![self.replicator startWithError:&error]) {
        [self log:[NSString stringWithFormat:@"Error starting replicator: %@", error]];
        return;
    }

    [self.pullButton setEnabled: NO];
    
}

-(void)log:(NSString *)message
{
    NSLog(@"%@", message);
    self.logTextField.stringValue = [NSString stringWithFormat:@"Status:\n%@",message];
}

-(void) replicatorDidChangeState:(CDTReplicator *)replicator
{
    [self log:[NSString stringWithFormat:@"new replication state: %@",
               [CDTReplicator stringForReplicatorState:replicator.state]]];
}

-(void) replicatorDidChangeProgress:(CDTReplicator *)replicator
{
    [self log:[NSString stringWithFormat:@"replicator made progress. changes processed/total: %ld "
               @"/ %ld", replicator.changesProcessed, replicator.changesTotal]];
}

-(void)replicatorDidComplete:(CDTReplicator *)replicator
{

    [self log:[NSString stringWithFormat:@"Replication Complete with %ld changes",
               replicator.changesProcessed]];
    

    NSLog(@"last sequence: %lld", [self.datastore.database lastSequence]);
    //NSLog(@"checkpoint ID: %@", [self.replicator.tdReplicator remoteCheckpointDocID]);
    //NSLog(@"last sequence from checkpoint doc: %@", [self.datastore.database lastSequenceWithCheckpointID:[self.replicator.tdReplicator remoteCheckpointDocID]]);
    
    [self.pullButton setEnabled: YES];
    
    
    //Now that the replication is complete, we've gotta add the databse to the SupportingFiles
    //of the current project

}

-(void)replicatorDidError:(CDTReplicator *)replicator info:(NSError *)info
{
    [self log:[NSString stringWithFormat:@"replicator did error. info %@", info]];
        
    [self.pullButton setEnabled: YES];

}

@end