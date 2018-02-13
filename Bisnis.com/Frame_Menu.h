//
//  Frame_Menu.h
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/15/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Frame_Menu : NSObject
@property(strong)NSString *nav_id;
@property(strong)NSString *nav_name;
@property(strong)NSString *nav_img;
@property int      nav_position;
@property(strong)NSString *nav_status;

-(id)initWithNavId:(NSString *)v_nav_id p_nav_name:(NSString *)v_nav_name p_nav_img:(NSString *)v_nav_img p_nav_position:(int)v_nav_position p_nav_status:(NSString *)v_nav_status;
@end
