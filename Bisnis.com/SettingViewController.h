//
//  SettingViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPopoverListView.h"

@interface SettingViewController : UIViewController <UIPopoverListViewDataSource,UIPopoverListViewDataSource>
@property(strong,nonatomic)IBOutlet UIButton *label_timer;
@property(strong,nonatomic)IBOutlet UIButton *label_font;

@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_kuning;

@end
