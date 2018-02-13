//
//  PagerModelController.h
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/18/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PagerDataViewControllerTerkait;

@interface PagerModelControllerTerkait : NSObject<UIPageViewControllerDataSource>

- (PagerDataViewControllerTerkait *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(PagerDataViewControllerTerkait *)viewController;

@property(weak,nonatomic)NSArray *nav_data;

@end

