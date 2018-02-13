//
//  LiveViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 10/7/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LiveViewController : UIViewController
@property(strong,nonatomic)IBOutlet UIWebView *web_live;
@property(strong,nonatomic)IBOutlet UIButton *cmd_last;
@property(strong,nonatomic)IBOutlet UIButton *cmd_old;
@property(strong,nonatomic)IBOutlet UITableViewCell *table_action;

@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_kuning;
@property(strong,nonatomic)IBOutlet UILabel *live_judul;
@end
