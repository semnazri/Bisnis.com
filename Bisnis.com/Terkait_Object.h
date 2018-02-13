//
//  Terkait_Object.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 10/7/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Terkait_Object : NSObject
{
    NSString *page_terkait;
    NSArray *array_terkait;
}


@property (nonatomic, retain) NSString *page_terkait;
@property (nonatomic, retain) NSArray *array_terkait;

+ (id)sharedManager;


@end
