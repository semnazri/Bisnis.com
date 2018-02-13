//
//  Canal_Object.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Canal_Object : NSObject
{
 NSString *Canal_active;
 NSString *Canal_active_id;
    int index_day;
    int index_start;
    CGFloat index_height;
NSString *Canal_old;
NSString *Tabs_old;
}
@property(nonatomic,retain)NSString *Canal_active;
@property(nonatomic,retain)NSString *Canal_active_id;
@property int index_day;
@property int index_start;
@property CGFloat index_height;
@property(nonatomic,retain)NSString *Canal_old;
@property(nonatomic,retain)NSString *Tabs_old;
+(id)Share_Manager;
@end
