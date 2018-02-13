//
//  PageContentViewController.h
//  PageViewDemo
//
//  Created by Simon on 24/11/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//


//
//  MainViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "HTHorizontalSelectionList.h"
#import "PageContentViewController.h"

@interface PageContentViewController : GAITrackedViewController <UITableViewDelegate,UITableViewDataSource>
@property(weak,nonatomic)IBOutlet UILabel *Label_canal;
@property (weak, nonatomic) IBOutlet UITableView *table_canal;

@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_kuning;

@property (strong ,nonatomic) NSMutableDictionary *cachedImages;


@property(strong,nonatomic)NSString *flag_tabs;

@property NSUInteger pageIndex;

@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *loading;

@property (strong, nonatomic) IBOutlet UIView *batas_atas;


@end

