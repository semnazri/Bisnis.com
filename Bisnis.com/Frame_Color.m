//
//  Frame_Color.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/4/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import "Frame_Color.h"

@implementation Frame_Color

@synthesize color_id,color;

-(id)initWithcolor_id:(NSString *)v_color_id p_color:(UIColor *)v_color{
    self = [super init];

    if(self){
        self.color_id=v_color_id;
        self.color = v_color;
        
    }
    return self;
}


@end
