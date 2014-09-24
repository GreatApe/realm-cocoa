//
//  RLMSplashWindowController.m
//  RealmBrowser
//
//  Created by Gustaf Kugelberg on 23/09/14.
//  Copyright (c) 2014 Realm inc. All rights reserved.
//

#import "RLMSplashWindowController.h"

@implementation RLMSplashFileItem

- (instancetype)initWithMetaDataItem
{
    self = [super init];
    if (self) {

    }
    return self;
}

@end


@interface RLMSplashWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@property (nonatomic) NSArray *fileItems;

@end

@implementation RLMSplashWindowController

-(void)awakeFromNib
{
    [super awakeFromNib];
    NSLog(@"awake!");
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)setupWithFileItems:(NSArray *)fileItems
{
    self.fileItems = fileItems;
    NSLog(@"setupWithFileItems");
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return 0;
}


@end
