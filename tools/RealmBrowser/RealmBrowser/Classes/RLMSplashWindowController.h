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
