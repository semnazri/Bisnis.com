//
//  Terkait_Object.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 10/7/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "Terkait_Object.h"

@implementation Terkait_Object
@synthesize  array_terkait,page_terkait;
#pragma mark Singleton Methods

+ (id)sharedManager {
    static Terkait_Object *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        page_terkait = @"Default Property Value";
        array_terkait = [NSArray arrayWithObjects:@"asd",@"asd", nil];
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

@end
