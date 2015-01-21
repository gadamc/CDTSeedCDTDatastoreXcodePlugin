//
//  CDTSeedCDTDatastorePlugin.h
//  CDTSeedCDTDatastorePlugin
//
//  Created by Adam Cox on 1/21/15.
//  Copyright (c) 2015 cloudant. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface CDTSeedCDTDatastorePlugin : NSObject

+ (instancetype)sharedPlugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end