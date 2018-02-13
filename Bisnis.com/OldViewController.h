//
//  OldViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/3/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

@interface OldViewController : GAITrackedViewController <UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)IBOutlet UILabel *Label_canal;
@property (weak, nonatomic) IBOutlet UITableView *table_canal;
-(IBAction)revealMenu:(id)sender;

@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_kuning;

@property (strong ,nonatomic) NSMutableDictionary *cachedImages;

@property NSUInteger pageIndex;


@property(strong,nonatomic)NSString *flag_tabs;

@property (strong, nonatomic) IBOutlet UIView *canal_header;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;


@end
