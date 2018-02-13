//
//  SettingViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "SettingViewController.h"
#import "ECSlidingViewController.h"
#import "NavTableViewController.h"
#import "DbManager.h"

@interface SettingViewController ()
@property(strong,nonatomic)NSMutableArray *array_time;
@property(strong,nonatomic)NSMutableArray *array_font;
@property(strong,nonatomic)NSMutableArray *arr_nav_info;
@property (strong,nonatomic)NSString *option;
@property(strong,nonatomic)DbManager *dbManager;
@end

@implementation SettingViewController

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
          self.dbManager = [[DbManager alloc] initWithDatabaseFilename:@"bisnisios.sql"];
    
    self.cell_biru.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_biru.png"]];
    self.cell_kuning.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_kuning.png"]];
    
    if(![self.slidingViewController.underLeftViewController isKindOfClass:[NavTableViewController class]]){
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    // Do any additional setup after loading the view.
    self.array_time = [NSMutableArray arrayWithObjects:@"5 Minute",@"15 Minute",@"30 Minute",@"1 Hour",@"Never", nil];
    self.array_font = [NSMutableArray arrayWithObjects:@"Small",@"Medium",@"Large",@"Extra Large", nil];
    
    //Deelte Bookmark
    NSString *query= [NSString stringWithFormat:@"insert into ios_option values(1,1,1)"];
    
    //NSString *query = @"delete from bookmark";
  
    
   // NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(1, 'model', 'home', 'oke')"];
      NSLog(@"%@",query);
    [self.dbManager executeQuery:query];
    // Execute the query.
    //[self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    [self load_db_option];
    //seend delete Bookmark
    
}
-(void)load_db_option{
    NSString *query = @"select * from ios_option";
    // Get the results.
    if (self.arr_nav_info != nil) {
        self.arr_nav_info = nil;
    }
     //  NSMutableArray *data= [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    self.arr_nav_info = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"font option -> %@",[[self.arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"] ]);
    
    NSString *font=[self.array_font objectAtIndex:[[[self.arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]]integerValue]];
    
    NSString *timer=[self.array_time objectAtIndex:[[[self.arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_time"] ] integerValue]];
    
    [self.label_font setTitle:font forState:UIControlStateNormal];
    [self.label_timer setTitle:timer forState:UIControlStateNormal];
    //  NSLog(@"woke %@",self.arr_nav_info);
    
}

-(void)update_time:(NSInteger)timer{
    //Deelte Bookmark
    NSString *query= [NSString stringWithFormat:@"update ios_option set option_time=%li where option_id=1",(long)timer];
    
    //NSString *query = @"delete from bookmark";
    
    
    // NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(1, 'model', 'home', 'oke')"];
    NSLog(@"%@",query);
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    //end delete Bookmark

}
-(void)update_font:(NSInteger)font{
    //Deelte Bookmark
    NSString *query= [NSString stringWithFormat:@"update ios_option set option_font=%li where option_id=1",(long)font];
    
    //NSString *query = @"delete from bookmark";
    
    
    // NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(1, 'model', 'home', 'oke')"];
    NSLog(@"%@",query);
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    //end delete Bookmark


}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)revealMenu:(id)sender{
    [self.slidingViewController anchorTopViewTo:ECRight];
}
- (IBAction)popClickActionFont:(id)sender
{
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    self.option = @"font";
    poplistview.delegate =(id)self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview setTitle:@"Font Size"];
    [poplistview show];
    //  [poplistview release];
}

- (IBAction)popClickActionTime:(id)sender
{
    CGFloat xWidth = self.view.bounds.size.width - 20.0f;
    CGFloat yHeight = 272.0f;
    CGFloat yOffset = (self.view.bounds.size.height - yHeight)/2.0f;
    UIPopoverListView *poplistview = [[UIPopoverListView alloc] initWithFrame:CGRectMake(10, yOffset, xWidth, yHeight)];
    self.option =@"time";
    poplistview.delegate =(id)self;
    poplistview.datasource = self;
    poplistview.listView.scrollEnabled = FALSE;
    [poplistview setTitle:@"Interval Refresh Time"];
    [poplistview show];
    //[poplistview reloadInputViews];
}

#pragma mark - UIPopoverListViewDataSource

- (UITableViewCell *)popoverListView:(UIPopoverListView *)popoverListView
                    cellForIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                    reuseIdentifier:identifier];
   // int row = indexPath.row;
    if([self.option isEqualToString:@"time"]){
        cell.textLabel.text = [self.array_time objectAtIndex:indexPath.row];

    }else{
        cell.textLabel.text = [self.array_font objectAtIndex:indexPath.row];
    }
       return cell;
}

- (NSInteger)popoverListView:(UIPopoverListView *)popoverListView
       numberOfRowsInSection:(NSInteger)section
{
    if([self.option isEqualToString:@"time"]){
      return [self.array_time count];
    }else{
      return [self.array_font count];
    }
  
}

#pragma mark - UIPopoverListViewDelegate
- (void)popoverListView:(UIPopoverListView *)popoverListView
     didSelectIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s : %ld", __func__, (long)indexPath.row);
    if([self.option isEqualToString:@"time"]){
        NSLog(@"Save time");
        [self update_time:indexPath.row];
        [self.label_timer setTitle:[NSString stringWithFormat:@"%@",[self.array_time objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
   else{
        NSLog(@"Save font");
       [self update_font:indexPath.row];
        [self.label_font setTitle:[NSString stringWithFormat:@"%@",[self.array_font objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
}

- (CGFloat)popoverListView:(UIPopoverListView *)popoverListView
   heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
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
