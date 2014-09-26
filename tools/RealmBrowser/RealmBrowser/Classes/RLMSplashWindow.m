//
//  RLMSplashWindow.m
//  RealmBrowser
//
//  Created by Gustaf Kugelberg on 26/09/14.
//  Copyright (c) 2014 Realm inc. All rights reserved.
//

#import "RLMSplashWindow.h"

@implementation RLMSplashWindow

-(id)initWithContentRect:(NSRect)contentRect styleMask:(NSUInteger)aStyle backing:(NSBackingStoreType)bufferingType defer:(BOOL)flag
{
    self = [super initWithContentRect:contentRect styleMask:aStyle backing:bufferingType defer:flag];
    if (self) {
        self.opaque = NO;
        self.backgroundColor = [NSColor clearColor];
        self.movableByWindowBackground = YES;
    }
    
    return self;
}

- (void)setContentView:(NSView *)aView {
    NSView *backView = [[NSView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    backView.wantsLayer             = YES;
    backView.layer.masksToBounds    = NO;
    backView.layer.shadowColor      = [NSColor shadowColor].CGColor;
    backView.layer.shadowOpacity    = 0.5;
    backView.layer.shadowOffset     = CGSizeMake(0, -3);
    backView.layer.shadowRadius     = 5.0;
    backView.layer.shouldRasterize  = YES;
    
    
    NSView *frontView = [aView initWithFrame:CGRectMake(backView.frame.origin.x + 15, backView.frame.origin.y + 15, backView.frame.size.width - 30, backView.frame.size.height - 30)];
    [backView addSubview: frontView];
    frontView.layer.cornerRadius    = 8;
    frontView.layer.masksToBounds   = YES;
    frontView.layer.borderColor     = [[NSColor darkGrayColor] CGColor];
    frontView.layer.borderWidth     = 0.5;
    
    frontView.layer.backgroundColor = [NSColor whiteColor].CGColor;
    
    [super setContentView:backView];
}

@end
