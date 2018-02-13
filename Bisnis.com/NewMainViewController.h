//
//  MainViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface NewMainViewController : GAITrackedViewController <UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)IBOutlet UILabel *Label_canal;
@property (weak, nonatomic) IBOutlet UITableView *table_canal;
-(IBAction)revealMenu:(id)sender;

@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_kuning;

@property (strong ,nonatomic) NSMutableDictionary *cachedImages;

@property NSUInteger pageIndex;


@end
