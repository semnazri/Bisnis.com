//
//  Detail_Object.h
//  Bisinscom
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Detail_Object : NSObject
{
    NSString *someProperty;
    NSString *url_web;
    NSString *id_live;
    NSArray *someDetail;
}


@property (nonatomic, retain) NSString *someProperty;
@property (nonatomic, retain) NSString *url_web;
@property (nonatomic, retain) NSString *id_live;
@property (nonatomic, retain) NSArray *someDetail;

+ (id)sharedManager;

@end
