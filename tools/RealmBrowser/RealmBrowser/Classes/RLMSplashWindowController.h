//
//  RLMSplashWindowController.h
//  RealmBrowser
//
//  Created by Gustaf Kugelberg on 23/09/14.
//  Copyright (c) 2014 Realm inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface RLMSplashFileItem : NSObject

@property (nonatomic) BOOL isCategoryName;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *metaData;
@property (nonatomic) NSString *path;
@property (nonatomic) NSDate *creationDate;
@property (nonatomic) NSDate *modificationDate;

@end


@interface RLMSplashWindowController : NSWindowController

-(void)setupWithFileItems:(NSArray *)fileItems;

@end
