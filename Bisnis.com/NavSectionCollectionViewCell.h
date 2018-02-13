//
//  NavSectionCollectionViewCell.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/9/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavSectionCollectionViewCell : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(strong,nonatomic)IBOutlet UITableView *menu_nav;

@end
