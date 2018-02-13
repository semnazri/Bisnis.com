//
//  Detail_Object.m
//  Bisinscom
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "Detail_Object.h"

@implementation Detail_Object

@synthesize  someProperty,someDetail,url_web,id_live;
#pragma mark Singleton Methods

+ (id)sharedManager {
    static Detail_Object *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        someProperty = @"Default Property Value";
        someDetail = [NSArray arrayWithObjects:@"asd",@"asd", nil];
        url_web=@"http://m.bisnis.com";
        id_live=@"as";
        
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}
@end
