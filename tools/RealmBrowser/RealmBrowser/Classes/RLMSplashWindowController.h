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

#import <Cocoa/Cocoa.h>

@interface RLMSplashFileItem : NSObject

@property (nonatomic) BOOL isCategoryName;
@property (nonatomic) NSString *path;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *metaData;
@property (nonatomic) NSDate *creationDate;
@property (nonatomic) NSDate *modificationDate;
@property (nonatomic) BOOL hideFromMenu;

+ (instancetype)splashItemForCategory:(NSString *)category;
+ (instancetype)splashItemWithMetaData:(NSMetadataItem *)metaDataItem;

@end


@interface RLMSplashWindowController : NSWindowController

@property (nonatomic) NSArray *fileItems;

@end

//
//
//- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
//    ATDesktopEntity *entity = [self _entityForRow:row];
//    if ([entity isKindOfClass:[ATDesktopFolderEntity class]]) {
//        NSTextField *textField = [tableView makeViewWithIdentifier:@"TextCell" owner:self];
//        [textField setStringValue:entity.title];
//        return textField;
//    } else {
//        ATTableCellView *cellView = [tableView makeViewWithIdentifier:@"MainCell" owner:self];
//        ATDesktopImageEntity *imageEntity = (ATDesktopImageEntity *)entity;
//        cellView.textField.stringValue = entity.title;
//        cellView.subTitleTextField.stringValue = imageEntity.fillColorName;
//        cellView.colorView.backgroundColor = imageEntity.fillColor;
//        cellView.colorView.drawBorder = YES;
//        
//        // Use KVO to observe for changes of the thumbnail image
//        if (_observedVisibleItems == nil) {
//            _observedVisibleItems = [NSMutableArray new];
//        }
//        if (![_observedVisibleItems containsObject:entity]) {
//            [imageEntity addObserver:self forKeyPath:ATEntityPropertyNamedThumbnailImage options:0 context:NULL];
//            [imageEntity loadImage];
//            [_observedVisibleItems addObject:imageEntity];
//        }
//        
//        // Hide/show progress based on the thumbnail image being loaded or not.
//        if (imageEntity.thumbnailImage == nil) {
//            [cellView.progessIndicator setHidden:NO];
//            [cellView.progessIndicator startAnimation:nil];
//            [cellView.imageView setHidden:YES];
//        } else {
//            [cellView.imageView setImage:imageEntity.thumbnailImage];
//        }
//        
//        // Size/hide things based on the row size
//        [cellView layoutViewsForSmallSize:_useSmallRowHeight animated:NO];
//        return cellView;
//    }
//}    
