//
//  MainViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"
#import "PageContentViewController.h"
#import "HMSegmentedControl.h"

@interface MainViewController : GAITrackedViewController <UIPageViewControllerDataSource>
-(IBAction)revealMenu:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;


@property(strong,nonatomic)NSString *flag_tabs;

@end
