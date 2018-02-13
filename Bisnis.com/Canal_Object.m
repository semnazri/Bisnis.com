//
//  Canal_Object.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "Canal_Object.h"

@implementation Canal_Object

@synthesize Canal_active,Canal_active_id,index_day,index_start,Canal_old,index_height,Tabs_old;
#pragma mark Singleton Methods

+ (id)Share_Manager {
    static Canal_Object *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        Canal_active = @"Berita terbaru";
        Canal_active_id = @"0";
        index_start=0;
        index_day=0;
        Canal_old=@"";
        index_height=190;
        Tabs_old=@"frontpage";
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
