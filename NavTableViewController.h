//
//  NavTableViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/9/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavTableViewController :UIViewController<UIScrollViewAccessibilityDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(weak)IBOutlet UIScrollView *nav_scroll;

@property (strong, nonatomic) IBOutlet UITableViewCell *menur_search;

@property (strong, nonatomic) IBOutlet UICollectionView *grid_front;
@property (strong, nonatomic) IBOutlet UITableViewCell *menu_favorite;
@property (strong, nonatomic) IBOutlet UITableViewCell *menu_channels;

@property (strong, nonatomic) IBOutlet UICollectionView *grid_favorite;
@property (strong, nonatomic) IBOutlet UICollectionView *grid_channels;
@property (strong, nonatomic) IBOutlet UITableViewCell *menu_other;

@property (strong, nonatomic) IBOutlet UICollectionView *grid_about;

@property (strong, nonatomic) IBOutlet UIView *test;

-(IBAction)action_search:(id)sender;
-(IBAction)action_favorite:(id)sender;

@end
