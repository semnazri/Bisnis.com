//
//  FavoriteTableViewCell.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FavoriteTableViewCell : UITableViewCell
@property(strong,nonatomic)IBOutlet UIImageView *favorite_img;
@property(strong,nonatomic)IBOutlet UILabel *favorite_name;
@property(strong,nonatomic)IBOutlet UISwitch *favorite_status;
@end
