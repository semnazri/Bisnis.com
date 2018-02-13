//
//  Search_Object.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/28/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "Search_Object.h"

@implementation Search_Object

@synthesize Search_data,Search_key,Search_page,Search_select;
#pragma mark Singleton Methods

+ (id)Share_Manager {
    static Search_Object *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        Search_key = @"Default Property Value";
        Search_data = [NSMutableArray arrayWithObjects:@"NULL", nil];
        Search_page =0;
        Search_select =-1;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}


@end
