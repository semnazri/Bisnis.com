//
//  BookMarkViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "BookMarkViewController.h"
#import "ECSlidingViewController.h"
#import "NavTableViewController.h"
#import "DbManager.h"
#import "BeritaTableViewCell.h"
#import "Detail_Object.h"
#import "Frame_Berita.h"

@interface BookMarkViewController ()
@property(strong,nonatomic)DbManager *dbManager;
@property(strong,nonatomic)NSMutableArray *arr_nav_info;
@property(strong,nonatomic)NSArray *arr_nav_info2;
@property(strong,nonatomic)Frame_Berita *b1;
@end

@implementation BookMarkViewController
@synthesize arr_nav_info,b1;

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
    self.cell_biru.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_biru.png"]];
    self.cell_kuning.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_kuning.png"]];
    if(![self.slidingViewController.underLeftViewController isKindOfClass:[NavTableViewController class]]){
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }

      self.dbManager = [[DbManager alloc] initWithDatabaseFilename:@"bisnisios.sql"];
   // self.arr_nav_info = [NSMutableArray arrayWithObjects:@"", nil];
    b1 = [[Frame_Berita alloc] initWhitId_berita2:0 p_judul_berita:@"jwwkwkk" p_tgl_berita:@"" p_pukul:@"" p_catagory:@"" p_datepost:@"" p_img_berita:@"" p_image_content:@""];

    NSString *query = @"select * from bookmark";
    self.arr_nav_info = [NSMutableArray arrayWithObjects:nil];
    NSMutableArray *data= [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    for(int i =0; [data count]>i;i++){
            NSInteger a =[[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_id"]] integerValue];
           NSLog(@"hahah %li",(long)a);
            b1= [[Frame_Berita alloc] initWhitId_berita2:a p_judul_berita:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_judul"]] p_tgl_berita:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"bertai_tgl"]] p_pukul:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_pukul"]] p_catagory:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_catagory"]] p_datepost:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_datepost"]] p_img_berita:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_img"]] p_image_content:@"as"];
        
        [self.arr_nav_info addObject:b1];
        
    }
    self.table_bookmark.delegate=(id)self;
    self.table_bookmark.dataSource=self;


    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.arr_nav_info count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BeritaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
      // NSLog(@"%@",[[self.arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_judul"]]);
    Frame_Berita *b2 = [self.arr_nav_info objectAtIndex:indexPath.row];
    cell.label_judul_berita.text =b2.Judul_Berita;
    cell.label_tgl_berita.text = b2.Pukul;
    cell.label_canal_berita.text =b2.Datepost;
   // cell.label_judul_berita.text =[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_judul"]];
   // cell.label_tgl_berita.text = [NSString stringWithFormat:@"%@ WIB",[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"bertai_tgl"]]];
   // cell.label_canal_berita.text =[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_datepost"]];
    //  NSLog(@"%@",data.Img_Berita);
    dispatch_queue_t queue = dispatch_queue_create("Sibertama.Bisniscom", NULL);
    dispatch_async(queue, ^{
        //code to be executed in the background
        NSURL   *url  = [NSURL URLWithString:b2.Img_Berita];//[[self.json_berita objectAtIndex:indexPath.row] objectForKey:@"title"];2.i
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            //code to be executed on the main thread when background task is finished
            if(image==nil){
                cell.img_berita.image = [UIImage imageNamed:@"img_logo.png"];
            }else{
                cell.img_berita.image=image;
            }
            [cell.img_berita.layer setBorderWidth:1.0f];
            [cell.img_berita.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
            
            CALayer *borderLayer = [CALayer layer];
            CGRect borderFrame = CGRectMake(0, 0, (cell.img_berita.frame.size.width), (cell.img_berita.frame.size.height));
            [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
            [borderLayer setFrame:borderFrame];
            [borderLayer setCornerRadius:4.0];
            [borderLayer setBorderWidth:4.0];
            [borderLayer setBorderColor:[[UIColor whiteColor] CGColor]];
            [cell.img_berita.layer addSublayer:borderLayer];
        });
    });
    
    
    

    
    
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)revealMenu:(id)sender{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(void)load_db_nav{
    
    // Get the results.
    if (self.arr_nav_info != nil) {
        self.arr_nav_info = nil;
        self.arr_nav_info = [NSMutableArray arrayWithObjects:nil];
    }
    
    NSString *query = @"select * from bookmark";

   NSMutableArray *data = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    for(int i =0; [data count]>i;i++){
        NSInteger a =[[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_id"]] integerValue];
        NSLog(@"hahah %li",(long)a);
        b1= [[Frame_Berita alloc] initWhitId_berita2:a p_judul_berita:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_judul"]] p_tgl_berita:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"bertai_tgl"]] p_pukul:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_pukul"]] p_catagory:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_catagory"]] p_datepost:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_datepost"]] p_img_berita:[[data objectAtIndex:i]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"berita_img"]] p_image_content:@"as"];
        
        [self.arr_nav_info addObject:b1];
        
    }

   [self.table_bookmark reloadData];
 
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 100;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 150;
    }
    
return 100;
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.table_bookmark indexPathForSelectedRow];
    // UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    // destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"segue_bookmark"]) {
        [[Detail_Object sharedManager]setSomeProperty:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        [[Detail_Object sharedManager]setSomeDetail:self.arr_nav_info];
    }
    //  if([segue isKindOfClass:[SWRevealViewControllerSegueSetController class]]){
    //  SWRevealViewControllerSegueSetController *swSegue = (SWRevealViewControllerSegueSetController *)segue;
    // swSegue.perform;
    /*
     swSegue.performBlock = ^(SWRevealViewControllerSegueSetController* rvc_segue,UIViewController* vc,UIViewController* dvc) {
     
     UINavigationController* navController =(UINavigationController*)self.revealViewController.frontViewController;
     [navController setViewControllers:@[dvc] animated:NO];
     [self.revealViewController setFrontViewController:FrontViewPositionLeft animated:YES];
     */
    // };
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        Frame_Berita *b2 = [self.arr_nav_info objectAtIndex:indexPath.row];
        NSLog(@"%li",b2.Id_Berita);
        // Delete the selected record.
        NSLog(@"bookmark ");

        //Deelte Bookmark
        NSString *query= [NSString stringWithFormat:@"delete from bookmark where berita_id=%li",b2.Id_Berita];
        
        //NSString *query = @"delete from bookmark";
        NSLog(@"%@",query);
        
        // NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(1, 'model', 'home', 'oke')"];
        
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
        
        
        // Reload the table view.
        [self load_db_nav];
    }
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
