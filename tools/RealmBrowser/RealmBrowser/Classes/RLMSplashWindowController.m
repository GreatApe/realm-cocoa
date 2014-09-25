//
//  RLMSplashWindowController.m
//  RealmBrowser
//
//  Created by Gustaf Kugelberg on 23/09/14.
//  Copyright (c) 2014 Realm inc. All rights reserved.
//

#import "RLMSplashWindowController.h"
#import "RLMSplashTableCellView.h"

@implementation RLMSplashFileItem

-(NSString *)description
{
    return [NSString stringWithFormat:@"%@ %@", self.name, self.path ?: @""];
}

+ (instancetype)splashItemForCategory:(NSString *)category
{
    RLMSplashFileItem *item = [[self alloc] init];
    if (item) {
        item.isCategoryName = YES;
        item.name = category;
    }
    return item;
}

+ (instancetype)splashItemWithMetaData:(NSMetadataItem *)metaDataItem
{
    RLMSplashFileItem *item = [[self alloc] init];
    if (item) {
        item.isCategoryName = NO;
        item.path = [metaDataItem valueForAttribute:NSMetadataItemPathKey];
        item.name = [item.path lastPathComponent];
        
        item.modificationDate = [metaDataItem valueForAttribute:NSMetadataItemFSContentChangeDateKey];
    }
    return item;
}

@end


@interface RLMSplashWindowController () <NSTableViewDelegate, NSTableViewDataSource>

@property (weak) IBOutlet NSTableView *tableView;

@end


@implementation RLMSplashWindowController

-(void)awakeFromNib
{
    [super awakeFromNib];
    [self.window setFrameOrigin:NSMakePoint(255, 255)];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

-(void)setFileItems:(NSArray *)fileItems
{
    _fileItems = fileItems;
    NSLog(@"----- reloadData! ------");
//    NSLog(@"fileItems:\n%@", fileItems);

    [self.tableView reloadData];
}

-(NSInteger)numberOfRowsInTableView:(NSTableView *)tableView
{
    return self.fileItems.count;
}

- (BOOL)tableView:(NSTableView *)tableView isGroupRow:(NSInteger)row
{
    RLMSplashFileItem *item = self.fileItems[row];
    return item.isCategoryName;
}

- (CGFloat)tableView:(NSTableView *)tableView heightOfRow:(NSInteger)row {
    RLMSplashFileItem *item = self.fileItems[row];
    return item.isCategoryName ? 40.0 : 50.0;
}

-(NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    RLMSplashFileItem *item = self.fileItems[row];
    
    if (item.isCategoryName) {
        NSTableCellView *cellView = [tableView makeViewWithIdentifier:@"GroupCell" owner:self];
        cellView.textField.stringValue = item.name;
        return cellView;
    }
    else {
        RLMSplashTableCellView *cellView = [tableView makeViewWithIdentifier:@"SplashCell" owner:self];
        cellView.textField.stringValue = item.name;
        cellView.metaInfo.stringValue = item.metaData ?: item.path ?: @" - CATEGORY -";
        return cellView;
    }
}



@end
