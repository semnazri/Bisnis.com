//
//  MenuTableViewCell.m
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/15/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "MenuTableViewCell.h"

@implementation MenuTableViewCell
{
    CAGradientLayer* _gradientLayer;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // add a layer that overlays the cell adding a subtle gradient effect
        _gradientLayer = [CAGradientLayer layer];
        _gradientLayer.frame = self.bounds;
        _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                                  (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                                  (id)[[UIColor clearColor] CGColor],
                                  (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
        _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
        [self.layer insertSublayer:_gradientLayer atIndex:0];
    }
    return self;
}

-(void) layoutSubviews {
    [super layoutSubviews];
    // ensure the gradient layers occupies the full bounds
    _gradientLayer.frame = self.bounds;
}

@synthesize img_menu,menu_name;


@end
