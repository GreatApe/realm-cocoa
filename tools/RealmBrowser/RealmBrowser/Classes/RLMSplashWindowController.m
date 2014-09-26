////////////////////////////////////////////////////////////////////////////
//
// Copyright 2014 Realm Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
////////////////////////////////////////////////////////////////////////////

#import "RLMSplashWindowController.h"
#import "RLMSplashTableCellView.h"
#import <QuartzCore/QuartzCore.h>

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
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end


@implementation RLMSplashWindowController

-(void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)windowDidLoad {
    [super windowDidLoad];
    NSSize screenSize = [self.window screen].frame.size;
    NSSize windowSize = self.window.frame.size;
    
    [self.window setFrameOrigin:NSMakePoint(screenSize.width/2 - windowSize.width/2, screenSize.height/2 - windowSize.height/2)];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
}

-(void)setFileItems:(NSArray *)fileItems
{
    _fileItems = fileItems;
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
        cellView.metaInfo.stringValue = item.metaData ?: [item.path stringByDeletingLastPathComponent];
        cellView.modificationDate.stringValue = [self simpleDate:item.modificationDate];
        return cellView;
    }
}

-(NSString *)simpleDate:(NSDate *)date
{
    CGFloat min = 60;
    CGFloat hour = 60*min;
    CGFloat day = 24*hour;
    
    NSDate *now = [NSDate date];
    CGFloat t = [now timeIntervalSinceDate:date];

    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSUInteger preservedComponents = (NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit);
    NSDate *midnight = [calendar dateFromComponents:[calendar components:preservedComponents fromDate:now]];
    
    if (t < 5*min) {
        return @"Just now";
    }
    else if (t < 2*hour) {
        return [NSString stringWithFormat:@"%.0f minutes ago", roundf(t/min)];
    }
    else if (t < 5*hour) {
        return [NSString stringWithFormat:@"%.0f hours ago", roundf(t/hour)];
    }
    else if ([date timeIntervalSinceDate:midnight] > 0) {
        self.dateFormatter.dateStyle = NSDateFormatterNoStyle;
        self.dateFormatter.timeStyle = NSDateFormatterShortStyle;
        
        return [self.dateFormatter stringFromDate:date];
    }
    else if ([date timeIntervalSinceDate:midnight] + day > 0) {
        return @"Yesterday";
    }
    else if ([date timeIntervalSinceDate:midnight] + 5*day > 0) {
        self.dateFormatter.dateFormat = @"EEEE";
        
        return [self.dateFormatter stringFromDate:date];
    }

    self.dateFormatter.dateStyle = NSDateFormatterShortStyle;
    self.dateFormatter.timeStyle = NSDateFormatterNoStyle;
    
    return [self.dateFormatter stringFromDate:date];
}

@end


