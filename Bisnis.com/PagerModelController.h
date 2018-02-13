//
//  PagerModelController.h
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/18/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PagerDataViewController;

@interface PagerModelController : NSObject<UIPageViewControllerDataSource>

- (PagerDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PagerDataViewController *)viewController;

@property(weak,nonatomic)NSArray *nav_data;

@end

