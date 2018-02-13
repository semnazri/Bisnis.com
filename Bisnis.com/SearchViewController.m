//
//  SearchViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "SearchViewController.h"
#import "ECSlidingViewController.h"
#import "NavTableViewController.h"
#import "Frame_Berita.h"
#import "Canal_Object.h"
#import "SearchTableViewCell.h"
#import "Detail_Object.h"
#import "Search_Object.h"

#define url_search @"http://services.bisnis.com/json/search?q="
@interface SearchViewController ()<UIAlertViewDelegate>
@property int index_page;
@property (strong,nonatomic)NSMutableArray *array_search;
@property (strong,nonatomic)NSString        *key_search;
@property (strong,nonatomic)Frame_Berita *b1;
@end

@implementation SearchViewController
@synthesize table_search=_table_search,key_search=_key_search,b1;
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
    self.table_search.delegate=(id)self;
    self.table_search.dataSource=self;
    
    if([[Search_Object Share_Manager]Search_select ]==-1){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Search" message:@"" delegate:self cancelButtonTitle:@"Search" otherButtonTitles:@"Cancel",nil];
        alert.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alert show];
        self.index_page=1;
        
        b1 = [[Frame_Berita alloc] initWhitId_berita2:0 p_judul_berita:@"" p_tgl_berita:@"" p_pukul:@"" p_catagory:@"" p_datepost:@"" p_img_berita:@"" p_image_content:@""];
        self.array_search = [NSMutableArray arrayWithObjects:b1, nil];
    }else{
        self.array_search = [[Search_Object Share_Manager] Search_data];
        self.key_search = [[Search_Object Share_Manager]Search_key];
        self.index_page =[[Search_Object Share_Manager]Search_page];
        [self.table_search reloadData];
        [self.table_search  scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:[[Search_Object Share_Manager]Search_select] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
     //   [self.table_search scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:1] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        
    }
    
      // [self reloadDatasmore:url_search];
  //  [self reloadDatasmore:[NSString stringWithFormat:@"%@motor&per_page=2",url_search]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)revealMenu:(id)sender{
    
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    
    if(buttonIndex==0){
        [self.array_search removeAllObjects];
        [self.table_search reloadInputViews];
        UITextField *textfield =  [alertView textFieldAtIndex: 0];
         self.key_search = textfield.text;
        NSLog(@"%@",[NSString stringWithFormat:@"%@motor&per_page=2",url_search]);

        [self reloadDatasmore:[NSString stringWithFormat:@"%@%@&per_page=1",url_search,self.key_search]];
    }else{
    
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.array_search count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

   SearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_search" forIndexPath:indexPath];
    Frame_Berita *data = [self.array_search objectAtIndex:indexPath.row];
    cell.label_tgl.text=data.Pukul;
    cell.label_judul.text=data.Judul_Berita;
    if([self.array_search count]!=1&&[self.array_search count]-1==indexPath.row){
    
        NSLog(@"%@",[NSString stringWithFormat:@"%@%@&per_page=%i",url_search,self.key_search,self.index_page]);
        [self reloadDatasmore:[NSString stringWithFormat:@"%@%@&per_page=%i",url_search,self.key_search,self.index_page]];
    
    }
    return cell;
    


}
-(void)reloadDatasmore:(NSString *)param{
    NSLog(@"LOLOLO");
   // self.table_canal.sectionFooterHeight=40;
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:param]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSArray *latestLoans = [self fetchData:data];
            NSLog(@" alert %lu",(unsigned long)[latestLoans count]);

            if (latestLoans) {
                //  NSLog(@"%i",[latestLoans count]);
                if([latestLoans count]!=0){
                    for (NSDictionary *loanDic in latestLoans) {
                    b1 = [[Frame_Berita alloc] initWhitId_berita2:[[[loanDic objectForKey:@"id"]substringToIndex:6]intValue] p_judul_berita:[[loanDic objectForKey:@"title"]objectAtIndex:0 ] p_tgl_berita:@"1" p_pukul:@"1" p_catagory:@"1" p_datepost:@"1" p_img_berita:@"1" p_image_content:@"1"];
                       
                        
                        //loan.country = [[loanDic objectForKey:@"location"] objectForKey:@"country"];
                        NSString *date=[loanDic objectForKey:@"last_modified"];
                        NSArray* foo = [date componentsSeparatedByString: @"T"];
                        date = [foo objectAtIndex: 0];
                        NSString *waktu = [[foo objectAtIndex:1] substringWithRange:NSMakeRange(0,5)];
                        NSArray *format_tgl=[date componentsSeparatedByString:@"-"];
                        NSString *DATE2=[foo objectAtIndex:0];
                        date=[NSString stringWithFormat:@"%@/%@/%@",[format_tgl objectAtIndex:2],[format_tgl objectAtIndex:1],[format_tgl objectAtIndex:0]];
                        NSString *sub_category =[loanDic objectForKey:@"category"];
                        
                        NSLog(@" id %i",[[[loanDic objectForKey:@"id"]substringToIndex:6]intValue]);
                        NSLog(@" cat id %@",sub_category);
                        
                        NSLog(@" tgl %@ %@ WIB",date,waktu);
                        NSLog(@" hore %@",sub_category);
                        
                        b1 = [[Frame_Berita alloc] initWhitId_berita2:[[[loanDic objectForKey:@"id"]substringToIndex:6]intValue] p_judul_berita:[[loanDic objectForKey:@"title"]objectAtIndex:0 ] p_tgl_berita:DATE2 p_pukul:[NSString stringWithFormat:@"%@ %@ WIB",date,waktu] p_catagory:[loanDic objectForKey:@"category"] p_datepost:@"1" p_img_berita:@"1" p_image_content:@"1"];

                        
                        
                     //   Frame_Berita *b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"title"] p_tgl_berita:[loanDic objectForKey:@"post_date"] p_pukul:[NSString stringWithFormat:@"%@ %@ WIB" ,date,waktu] p_catagory:[loanDic objectForKey:@"category_id"]  p_datepost:[NSString stringWithFormat:@"%@ - %@",parent_category,sub_category] p_img_berita:[NSString stringWithFormat:@"%@?w=100",[loanDic objectForKey:@"image_uri"] ] p_image_content:[loanDic objectForKey:@"image_caption"]];
                        
                        
                        [self.array_search addObject:b1];
                       // [self.table_search reloadData];
                    }
                    }else{
                    //  NSLog(@" Ganti Hari %i",[latestLoans count]);
                    
                }
            }
            // As this block of code is run in a background thread, we need to ensure the GUI
            // update is executed in the main thread
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            
        }
    }
     
     
     ];
    
}

- (void)reloadData
{
    // End the refreshing
    // Reload table data
    //[self.data_berita removeAllObjects];
    // [self.data_berita addObject:@"qwe"];
    // [self.data_berita addObject:@"qwe"];
    
    //  [self.data_berita addObject:@"qwe"];
    [self.table_search reloadData];
    self.index_page++;
}

- (NSArray *)fetchData:(NSData *)response
{
    
    NSError *error = nil;
    NSMutableDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error.description);
     ///   self.table_canal.sectionFooterHeight=0;
        return nil;
    }
    //self.table_canal.sectionFooterHeight=0;
    
    
    NSArray* latestLoans = [[parsedData objectForKey:@"response"] objectForKey:@"docs"];
    
    NSLog(@" data %lu",(unsigned long)[latestLoans count]);

    return latestLoans;
    
}
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.table_search indexPathForSelectedRow];
    // UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    // destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"segue_search"]) {
        [[Detail_Object sharedManager]setSomeProperty:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        [[Detail_Object sharedManager]setSomeDetail:self.array_search];
        [[Search_Object Share_Manager]setSearch_data:self.array_search];
        [[Search_Object Share_Manager]setSearch_key:self.key_search];
        [[Search_Object Share_Manager]setSearch_select:indexPath.row];
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
