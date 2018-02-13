//
//  Frame_Menu.m
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/15/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "Frame_Menu.h"

@implementation Frame_Menu
@synthesize nav_id,nav_name,nav_img,nav_position,nav_status;
-(id)initWithNavId:(NSString *)v_nav_id p_nav_name:(NSString *)v_nav_name p_nav_img:(NSString *)v_nav_img p_nav_position:(int)v_nav_position p_nav_status:(NSString *)v_nav_status{
    self = [super init];
    if(self){
        self.nav_id=v_nav_id;
        self.nav_name=v_nav_name;
        self.nav_img=v_nav_img;
        self.nav_position=v_nav_position;
        self.nav_status=v_nav_status;
    }

    return self;
}

@end
