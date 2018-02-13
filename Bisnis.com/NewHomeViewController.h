//
//  NewHomeViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 2/25/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageContentViewController.h"

@interface NewHomeViewController : UIPageViewController
- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageImages;

@end
