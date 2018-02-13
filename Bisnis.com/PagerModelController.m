//
//  PagerModelController.m
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/18/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "PagerModelController.h"
#import "PagerDataViewController.h"
#import "Detail_Object.h"
#import "Canal_Object.h"


@interface PagerModelController ()
@property (strong,nonatomic)NSArray *pageData;
@property (strong,nonatomic)NSArray *data_json;
@end

@implementation PagerModelController
- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
       // Detail_Object *sharedManager = [Detail_Object sharedManager];
        
        NSString *da = [[Detail_Object sharedManager] someProperty];
        NSArray *wa = [NSArray arrayWithArray:[[Detail_Object sharedManager]someDetail ]];
        NSLog(@"path %@ jumlah %lu ",da,(unsigned long)[wa count]);
        _pageData = [NSArray arrayWithArray:wa];
        
       // _pageData = [NSArray arrayWithObjects:@"A",@"B",@"C", nil];
      //  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     //   _pageData = [[dateFormatter   monthSymbols] copy];
       // [_pageData arrayByAddingObject:@"asd"];
        
      //  [_pageData arr
    }
    return self;
}

- (PagerDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    PagerDataViewController *dataViewController ;
//    // Create a new view controller and pass suitable data.
//    if([[[Canal_Object Share_Manager]Canal_active]isEqualToString:@"Search"]){
//       dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewController2"];
//        dataViewController.dataObject = self.pageData[index];
//        dataViewController.pagenumber=index;
//    }else{
        dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewController"];
        dataViewController.dataObject = self.pageData[index];
        dataViewController.pagenumber=index;
    
   // }

    
    
    return dataViewController;
    
}

- (NSUInteger)indexOfViewController:(PagerDataViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PagerDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PagerDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
