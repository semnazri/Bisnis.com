//
//  PagerModelController.m
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/18/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "PagerModelControllerTerkait.h"
#import "PagerDataViewControllerTerkait.h"
#import "Terkait_Object.h"


@interface PagerModelControllerTerkait ()
@property (strong,nonatomic)NSArray *pageData;
@property (strong,nonatomic)NSArray *data_json;
@end

@implementation PagerModelControllerTerkait
- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
       // Detail_Object *sharedManager = [Detail_Object sharedManager];
        
        NSString *da = [[Terkait_Object sharedManager] page_terkait];
        NSArray *wa = [NSArray arrayWithArray:[[Terkait_Object sharedManager]array_terkait]];
        NSLog(@"path %@ jumlah %i ",da,[wa count]);
        _pageData = [NSArray arrayWithArray:wa];
        
       // _pageData = [NSArray arrayWithObjects:@"A",@"B",@"C", nil];
      //  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     //   _pageData = [[dateFormatter   monthSymbols] copy];
       // [_pageData arrayByAddingObject:@"asd"];
        
      //  [_pageData arr
    }
    return self;
}

- (PagerDataViewControllerTerkait *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    PagerDataViewControllerTerkait *dataViewController ;
//    // Create a new view controller and pass suitable data.
//    if([[[Canal_Object Share_Manager]Canal_active]isEqualToString:@"Search"]){
//       dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewController2"];
//        dataViewController.dataObject = self.pageData[index];
//        dataViewController.pagenumber=index;
//    }else{
        dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewControllerTerkait"];
        dataViewController.dataObject = self.pageData[index];
        dataViewController.pagenumber=index;
    
   // }

    
    
    return dataViewController;
    
}

- (NSUInteger)indexOfViewController:(PagerDataViewControllerTerkait *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.pageData indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PagerDataViewControllerTerkait *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(PagerDataViewControllerTerkait *)viewController];
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
