//
//  Frame_Color.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/4/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Frame_Color : NSObject

@property (strong,nonatomic)NSString* color_id;
@property  (strong,nonatomic)UIColor *color;

-(id)initWithcolor_id:(NSString *)v_color_id p_color:(UIColor *)v_color;

@end
