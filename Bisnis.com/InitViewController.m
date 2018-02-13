//
//  InitViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "InitViewController.h"
#import "Canal_Object.h"

@interface InitViewController ()

@end

@implementation InitViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
      NSString * ada =[[Canal_Object Share_Manager]Tabs_old];
    // Do any additional setup after loading the view.
    if([[[Canal_Object Share_Manager]Canal_active_id] length]==9){
        [[Canal_Object Share_Manager]setCanal_active:@"Berita Terbaru"];
        [[Canal_Object Share_Manager]setCanal_active_id:@"0"];
    }
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        self.shouldAdjustChildViewHeightForStatusBar = YES;
        self.statusBarBackgroundView.backgroundColor = [UIColor blackColor];
    }
    
    UIStoryboard *storyboard;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
         storyboard = [UIStoryboard storyboardWithName:@"Main_iPad" bundle:nil];
    }
    
  
    
    if([ada isEqualToString:@"MainOld"]){
        self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"MainOld"];
    }else if([ada isEqualToString:@"frontpage" ]||[ada isEqualToString:@"allchannels" ]||[ada isEqualToString:@"allfavorites" ]){
        self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"Main"];
    }
    else if([ada isEqualToString:@"Search" ]){
        self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"search"];
    }else if([ada isEqualToString:@"Bookmark" ]){
        self.topViewController = [storyboard instantiateViewControllerWithIdentifier:@"bookmark"];
    }
    

    self.shouldAddPanGestureRecognizerToTopViewSnapshot = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
