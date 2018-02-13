//
//  BookMarkViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookMarkViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(weak,nonatomic)IBOutlet UITableView *table_bookmark;

@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_kuning;
@end
