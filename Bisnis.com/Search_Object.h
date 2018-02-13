//
//  Search_Object.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/28/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search_Object : NSObject
{
    NSString *Search_key;
    NSMutableArray *Search_data;
    int       Search_page;
    NSInteger       Search_select;
}
@property(nonatomic,retain)NSString *Search_key;
@property(nonatomic,retain)NSMutableArray *Search_data;
@property int Search_page;
@property NSInteger Search_select;
+(id)Share_Manager;
@end
