//
//  BisnisViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "LiveViewController.h"
#import "Detail_Object.h"

@interface LiveViewController ()<UIWebViewDelegate>
{

}

#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 5.0f


@end
@implementation LiveViewController
@synthesize web_live=_web_live,table_action;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   // self.cell_biru.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_biru.png"]];
    self.cell_kuning.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_kuning.png"]];
    NSString *address;
    NSLog(@"LIve %@",[NSString stringWithFormat: @"http://services.bisnis.com/json/live/%@/latest/",[[Detail_Object sharedManager]id_live]]);
    if([[[Detail_Object sharedManager]url_web]length]>5){
     address  =[NSString stringWithFormat:@"http://services.bisnis.com/json/live/262843/oldnest/"];
    }else{
      address =[NSString stringWithFormat:@"%@",[[Detail_Object sharedManager]url_web]];
    }
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        if(result.height == 480)
        {
            //Load 3.5 inch xib
            
         
          //  self.table_action.frame = CGRectMake(0, 440, 320, 44);
         
        }
        else if(result.height == 568)
        {
            //Load 4 inch xib
        }
    }
    
    
    

    self.live_judul.text=[[Detail_Object sharedManager]url_web];
    NSString *text =self.live_judul.text;
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:self.live_judul.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    // Build the url and loadRequest
    [self.live_judul setFrame:CGRectMake(CELL_CONTENT_MARGIN, 10, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2),size.height)];
    
    [self.cell_biru setFrame:CGRectMake(0, 67, self.view.frame.size.width,size.height+20)];
    
    
    
   
    
    //self.cell_biru.frame=CGRectMake(0,67,self.cell_biru.frame.size.width,self.cell_biru.frame.size.height);
    
    
  
    
   // self.live_judul.frame=CGRectMake(10,0,self.cell_biru.frame.size.width-10,self.cell_biru.frame.size.height);
    

    self.table_action.frame=CGRectMake(0,self.cell_biru.frame.origin.y+self.cell_biru.frame.size.height,self.table_action.frame.size.width,self.table_action.frame.size.height);
    self.web_live.frame=CGRectMake(0,self.table_action.frame.origin.y+self.table_action.frame.size.height,self.web_live.frame.size.width,self.view.frame.size.height-self.web_live.frame.origin.y);
    
    
  [self.web_live loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://services.bisnis.com/json/live/%@/latest/",[[Detail_Object sharedManager]id_live]]]]];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
   
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)Bak_to:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
   // NSLog(@"MODEL %i",[array count]);
    
    NSLog(@"%@",self.navigationController.topViewController);
    
}
-(IBAction)cmd_last:(id)sender{
//    NSLog(@"LAST LAST");
    [self.cmd_old setTitleColor:[UIColor grayColor]  forState:UIControlStateNormal];
    [self.cmd_last setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cmd_last.backgroundColor = [UIColor orangeColor];
    self.cmd_old.backgroundColor = [UIColor lightGrayColor];
//
//    
//    
//    LiveViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewControllerLive"];
//    [self presentViewController:monitorMenuViewController animated:UIModalTransitionStyleFlipHorizontal completion:nil];
    
    // [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewController2"];
    
  //  [self open_link:[NSURL URLWithString:@"http://services.bisnis.com/json/live/262843/latest/"]];
     [self.web_live loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://services.bisnis.com/json/live/%@/latest/",[[Detail_Object sharedManager]id_live]]]]];
    
    
}
-(IBAction)cmd_old:(id)sender{
    NSLog(@"OLD OLD");
    [self.cmd_last setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.cmd_old setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cmd_last.backgroundColor = [UIColor lightGrayColor];
    self.cmd_old.backgroundColor = [UIColor orangeColor];
   // [self open_link:[NSURL URLWithString:@"http://services.bisnis.com/json/live/262843/oldnest/"]];
     [self.web_live loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat: @"http://services.bisnis.com/json/live/%@/oldnest/",[[Detail_Object sharedManager]id_live]]]]];
    
}




@end
