//
//  MainViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "OldViewController.h"
#import "ECSlidingViewController.h"
#import "NavTableViewController.h"
#import "Canal_Object.h"
#import "Frame_Berita.h"
#import "Detail_Object.h"
#import "BeritaTableViewCell.h"
#import "DbManager.h"
#import "Frame_Color.h"


#define VIEW_HEADLINE 150
#define VIEW_CANAL  100
#define front @"http://services.bisnis.com/newjson/"
#define front1 @"http://services.bisnis.com/newjson/"
#define headline  @"http://services.bisnis.com/newjson/headlines/1/0/3"
#define headline1  @"http://services.bisnis.com/newjson/headlines/1/"
//#define breaking  @"http://services.bisnis.com/newjson/breaking/1/"
//#define breaking1  @"http://services.bisnis.com/newjson/breaking/1/"
#define index     @"http://services.bisnis.com/newjson/indeks_breaking/1"
#define index1     @"http://services.bisnis.com/newjson/indeks_breaking/1"


#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 15.0f


@interface OldViewController ()
{
    UIRefreshControl *refreshControl;
}
@property(strong,nonatomic) BeritaTableViewCell *custom_cell_berita;
@property (strong,nonatomic) NSMutableArray *data_berita;
@property int index_day,index_start,index_page;
@property (strong,nonatomic)Frame_Berita *b1;
@property(strong,nonatomic)DbManager *dbManager;
@property UIFont *font_size_judul_headline;
@property UIFont *font_size_judul;
@property UIFont *font_size_tgl;
@property UIFont *font_size_canal;
@property CGFloat first_height;
@property(strong,nonatomic)NSArray *color_canal;
@end

@implementation OldViewController
@synthesize Label_canal=_Label_canal,table_canal=_table_canal,data_berita=_data_berita,b1,first_height,loading;

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
    // Do any additional setup after loading the view.
    //self.view.layer.shadowOpacity = 0.75f;
    //self.view.layer.shadowRadius= 10.0f;
    //self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
    
    self.loading  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.loading.color=[UIColor brownColor];
    self.loading.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    //    // Set Center Position for ActivityIndicator
    
    self.loading.center = CGPointMake(self.view.frame.size.width / 2, self.table_canal.frame.size.height / 2.5);
    
    [self.loading setAlpha:0.0];
    [self.loading startAnimating];
    [self.view addSubview:loading];

    
  
    Frame_Color *color1=[[Frame_Color alloc]initWithcolor_id:@"186" p_color:[UIColor colorWithRed:39.0f/255.0f green:116.0f/255.0f blue:186.0f/255.0f alpha:1.0f]];
    Frame_Color *color2=[[Frame_Color alloc]initWithcolor_id:@"194" p_color:[UIColor  colorWithRed:228.0f/255.0f green:174.0f/255.0f blue:56.0f/255.0f alpha:1.0f]];
    Frame_Color *color3=[[Frame_Color alloc]initWithcolor_id:@"5" p_color:[UIColor colorWithRed:27.0f/255.0f green:128.0f/255.0f blue:138.0f/255.0f alpha:1.0f]];
    Frame_Color *color4=[[Frame_Color alloc]initWithcolor_id:@"43" p_color:[UIColor colorWithRed:52.0f/255.0f green:73.0f/255.0f blue:94.0f/255.0f alpha:1.0f]];
    Frame_Color *color5=[[Frame_Color alloc]initWithcolor_id:@"272" p_color:[UIColor colorWithRed:104.0f/255.0f green:146.0f/255.0f blue:204.0f/255.0f alpha:1.0f]];
    Frame_Color *color6=[[Frame_Color alloc]initWithcolor_id:@"382" p_color:[UIColor colorWithRed:225.0f/255.0f green:94.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    Frame_Color *color7=[[Frame_Color alloc]initWithcolor_id:@"392" p_color:[UIColor colorWithRed:30.0f/255.0f green:184.0f/255.0f blue:72.0f/255.0f alpha:1.0f]];
    Frame_Color *color8=[[Frame_Color alloc]initWithcolor_id:@"197" p_color:[UIColor colorWithRed:225.0/255.0f green:111.0f/255.0f blue:186.0f/255.0f alpha:1.0f]];
    Frame_Color *color9=[[Frame_Color alloc]initWithcolor_id:@"277" p_color:[UIColor colorWithRed:74.0f/255.0f green:83.0f/255.0f blue:114.0f/255.0f alpha:1.0f]];
    Frame_Color *color10=[[Frame_Color alloc]initWithcolor_id:@"222" p_color:[UIColor colorWithRed:155.0f/255.0f green:88.0f/255.0f blue:181.0f/255.0f alpha:1.0f]];
    Frame_Color *color11=[[Frame_Color alloc]initWithcolor_id:@"47" p_color:[UIColor colorWithRed:233.0f/255.0f green:168.0f/255.0f blue:128.0f/255.0f alpha:1.0f]];
    Frame_Color *color12=[[Frame_Color alloc]initWithcolor_id:@"57" p_color:[UIColor colorWithRed:240.0f/255.0f green:22.0f/255.0f blue:68.0f/255.0f alpha:1.0f]];
    Frame_Color *color13=[[Frame_Color alloc]initWithcolor_id:@"242" p_color:[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f]];
    Frame_Color *color14=[[Frame_Color alloc]initWithcolor_id:@"231" p_color:[UIColor colorWithRed:16.0f/255.0f green:186.0f/255.0f blue:141.0f/255.0f alpha:1.0f]];
    Frame_Color *color15=[[Frame_Color alloc]initWithcolor_id:@"52" p_color:[UIColor colorWithRed:180.0f/255.0f green:204.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    Frame_Color *color16=[[Frame_Color alloc]initWithcolor_id:@"258" p_color:[UIColor colorWithRed:80.0f/255.0f green:104.0f/255.0f blue:255.0f/255.0f alpha:1.0f]];
    Frame_Color *color17=[[Frame_Color alloc]initWithcolor_id:@"243" p_color:[UIColor colorWithRed:255.0f/255.0f green:109.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    Frame_Color *color18=[[Frame_Color alloc]initWithcolor_id:@"73" p_color:[UIColor colorWithRed:255.0f/255.0f green:204.0f/255.0f blue:0.0f/255.0f alpha:1.0f]];
    
    self.color_canal =[NSArray arrayWithObjects:color1,color2,color3,color4,color5,color6,color7,color8,color9,color10,color11,color12,color13,color14,color15,color16,color17,color18, nil];
    

   // Frame_Color *color_select = [self.color_canal objectAtIndex:1];
    
    
    for(int a=0;a<[self.color_canal count];a++){
     Frame_Color *color_select = [self.color_canal objectAtIndex:a];
        if([[[Canal_Object Share_Manager] Canal_active_id]isEqualToString:color_select.color_id]){
            self.canal_header.backgroundColor = color_select.color;
            break;
        }
    }
    
    

    
    self.first_height=[[Canal_Object Share_Manager] index_height];
    self.index_day=0;
    self.index_start=20;
    
    self.cell_biru.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_biru.png"]];
    self.cell_kuning.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_kuning.png"]];
       self.flag_tabs =[[Canal_Object Share_Manager] Canal_active_id];
    
    if(![self.slidingViewController.underLeftViewController isKindOfClass:[NavTableViewController class]]){
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    self.Label_canal.text = [[[Canal_Object Share_Manager]Canal_active] uppercaseString];
    self.screenName= [NSString stringWithFormat:@"apps/%@",[[Canal_Object Share_Manager]Canal_active]];
    
    //Data Table
    self.table_canal.delegate=(id)self;
    self.table_canal.dataSource=self;
    b1 = [[Frame_Berita alloc] initWhitId_berita2:0 p_judul_berita:@"" p_tgl_berita:@"" p_pukul:@"" p_catagory:@"" p_datepost:@"" p_img_berita:@"" p_image_content:@""];
    self.data_berita = [NSMutableArray arrayWithObjects:b1,b1,b1,b1,b1,b1,b1,b1, nil];
    //cek front page
    
    
    if([[[Canal_Object Share_Manager]Canal_active_id] length]<4){
        if(([[[Canal_Object Share_Manager]Canal_active_id ] isEqualToString:[[Canal_Object Share_Manager]Canal_old]])&&([[[Detail_Object sharedManager]someDetail]count]>5))
        {
            
            self.loading.alpha=0.0f;
            self.data_berita = [NSMutableArray arrayWithArray:[[Detail_Object sharedManager]someDetail]];
            self.index_day= [[Canal_Object Share_Manager]index_day];
            self.index_start=[[Canal_Object Share_Manager] index_start];
            self.table_canal.sectionFooterHeight=0;
            [self.table_canal reloadData];
            [self.table_canal  scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:[[[Detail_Object sharedManager]someProperty]integerValue] inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            
            
        }else{
            [self reloadDatashead];
            [[Canal_Object Share_Manager]setCanal_old:[[Canal_Object Share_Manager]Canal_active_id]];
        }
    }else{
        [self.data_berita removeAllObjects];
        [[Canal_Object Share_Manager]setCanal_old:[[Canal_Object Share_Manager]Canal_active_id]];
       // [self reloadDatasmore:[NSString  stringWithFormat:@"%@%@",front,[[Canal_Object Share_Manager] Canal_active_id]]];
    }
    
    //end cek front page
    //end data load table
    
    // Refresh control
    UIView *refreshView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.table_canal insertSubview:refreshView atIndex:0]; //the tableView is a IBOutlet
    
    refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.tintColor = [UIColor blueColor];
    [refreshControl addTarget:self action:@selector(reloadDatashead) forControlEvents:UIControlEventValueChanged];
    /* NSMutableAttributedString *refreshString = [[NSMutableAttributedString alloc] initWithString:@"Pull To Refresh"];
     [refreshString addAttributes:@{NSForegroundColorAttributeName : [UIColor grayColor]} range:NSMakeRange(0, refreshString.length)];
     refreshControl.attributedTitle = refreshString; */
    [refreshView addSubview:refreshControl];
    //end refresh control
    
    NSLog(@"%li",(long)[self selish_hari:@"2014-09-22"]);
    [self insert_option];
    [self load_db_option];
    
    self.cachedImages = [[NSMutableDictionary alloc] init];
    
}

-(void)insert_option{
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
    
}
-(IBAction)revealMenu:(id)sender{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(void)load_db_option{
    
    NSString *query = @"select * from ios_option";
    
    NSArray *arr_nav_info = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"data %@",arr_nav_info);
    NSLog(@"font option -> %@",[[arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]]);
    NSInteger timer;
    // NSString *font=[self.array_font objectAtIndex:[[[self.arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]]integerValue]];
    
    //NSString *timer=[self.array_time objectAtIndex:[[[self.arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_time"] ] integerValue]];
    
    if([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_time"]] intValue]==0){
        timer=5*60;
    }
    else if([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_time"]] intValue]==1){
        timer=15*60;
    }else if([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_time"]] intValue]==2){
        timer=30*60;
    }else if ([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_time"]] intValue]==3){
        timer=60*60;
    }
    else if ([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_time"]] intValue]==4){
        timer=99999999*60;
    }
    
    if([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]] intValue]==0){
        self.font_size_judul_headline=[UIFont boldSystemFontOfSize:17];
        self.font_size_judul= [UIFont  fontWithName:@"OpenSans" size:15];
        self.font_size_tgl= [UIFont  systemFontOfSize:9];
        self.font_size_canal= [UIFont boldSystemFontOfSize:9];
    }
    else if([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]] intValue]==1){
        self.font_size_judul_headline=[UIFont boldSystemFontOfSize:20];
        self.font_size_judul= [UIFont  fontWithName:@"OpenSans" size:18];
        self.font_size_tgl= [UIFont systemFontOfSize:12];
        self.font_size_canal= [UIFont boldSystemFontOfSize:12];
    }else if([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]] intValue]==2){
        self.font_size_judul_headline=[UIFont boldSystemFontOfSize:24];
        self.font_size_judul= [UIFont fontWithName:@"OpenSans" size:22];
        self.font_size_tgl= [UIFont systemFontOfSize:14];
        self.font_size_canal= [UIFont systemFontOfSize:14];
    }else if ([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]] intValue]==3){
        self.font_size_judul_headline=[UIFont boldSystemFontOfSize:26];
        self.font_size_judul= [UIFont fontWithName:@"OpenSans" size:24];
        self.font_size_tgl= [UIFont systemFontOfSize:16];
        self.font_size_canal= [UIFont systemFontOfSize:16];
    }
    
    
    
    NSTimer *start = [NSTimer scheduledTimerWithTimeInterval:timer target:self selector:@selector(increaseTimerCount) userInfo:nil repeats:YES];
    NSLog(@"%@",start);
    
}

-(void)increaseTimerCount{
    
    NSLog(@"Kampete ");
    [self reloadDatashead];
    
}


-(NSInteger)selish_hari:(NSString *)hari{
    //contoh cari selish hari
    NSDate *now = [NSDate date];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *start =hari;
    NSString *end = [formatter stringFromDate:now];
    
    // NSString *start = @"2014-09-01";
    NSDateFormatter *f = [[NSDateFormatter alloc] init];
    [f setDateFormat:@"yyyy-MM-dd"];
    NSDate *startDate = [f dateFromString:start];
    NSDate *endDate = [f dateFromString:end];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit
                                                        fromDate:startDate
                                                          toDate:endDate
                                                         options:0];
    // NSLog(@" Selisih %i", [components day]);
    //end selish hari
    
    
    return [components day];
    
}

-(void)reloadDatashead{
    
        [self.loading setAlpha:1.0f];
        [self.loading setAlpha:1.0];
    NSString *url;
    self.table_canal.sectionFooterHeight=40;
    //cek front page
    if([[[Canal_Object Share_Manager]Canal_active_id] length]<4){
        url = [NSString stringWithFormat:@"%@%@/1",headline1,[[Canal_Object Share_Manager] Canal_active_id]];
    }else{
        url = [NSString stringWithFormat:@"%@%@",front1,[[Canal_Object Share_Manager] Canal_active_id]];
        self.table_canal.sectionFooterHeight=0;
    }
    //end cek front page
    NSLog(@"modar sampen %@",url);
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            [self.data_berita removeAllObjects];
            NSArray *latestLoans = [self fetchData:data];
            
            if (latestLoans) {
                for (NSDictionary *loanDic in latestLoans) {
                    // NSLog(@"%@",[loanDic objectForKey:@"post_id"]);
                    //loan.country = [[loanDic objectForKey:@"location"] objectForKey:@"country"];
                    NSString *date=[loanDic objectForKey:@"post_date"];
                    NSArray* foo = [date componentsSeparatedByString: @" "];
                    date = [foo objectAtIndex: 0];
                    NSString *waktu = [[foo objectAtIndex:1] substringWithRange:NSMakeRange(0,5)];
                    NSArray *format_tgl=[date componentsSeparatedByString:@"-"];
                    date=[NSString stringWithFormat:@"%@/%@/%@",[format_tgl objectAtIndex:2],[format_tgl objectAtIndex:1],[format_tgl objectAtIndex:0]];
                  //  NSString *parent_category =[loanDic objectForKey:@"parent_category"];
                    NSString *sub_category =[loanDic objectForKey:@"category_link"];
                    sub_category = [sub_category stringByReplacingOccurrencesOfString:@"-" withString:@" "];
                    sub_category= [sub_category capitalizedString];
                    
                    
                    Frame_Berita *b2;
                    
                    if(self.index_day<1){
                        
                        b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"title"] p_tgl_berita:[loanDic objectForKey:@"post_date"] p_pukul:[NSString stringWithFormat:@" - %@ WIB",waktu] p_catagory:[loanDic objectForKey:@"category_id"]  p_datepost:[NSString stringWithFormat:@"%@ ",sub_category] p_img_berita:[NSString stringWithFormat:@"%@?w=250",[loanDic objectForKey:@"image_uri"] ] p_image_content:[loanDic objectForKey:@"is_live"]];
                        
                    }else{
                        
                        b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"title"] p_tgl_berita:[loanDic objectForKey:@"post_date"] p_pukul:[NSString stringWithFormat:@"   %@ - %@ WIB" ,date,waktu] p_catagory:[loanDic objectForKey:@"category_id"]  p_datepost:[NSString stringWithFormat:@"%@ ",sub_category] p_img_berita:[NSString stringWithFormat:@"%@?w=250",[loanDic objectForKey:@"image_uri"] ] p_image_content:[loanDic objectForKey:@"is_live"]];
                        
                    }
                    
                    
                    [self.data_berita addObject:b2];
                    
                    
                    
                    
                    //                    Frame_Berita *b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"title"] p_tgl_berita:[loanDic objectForKey:@"post_created"] p_pukul:[loanDic objectForKey:@"slug"] p_catagory:[loanDic objectForKey:@"category_id"] p_datepost:[loanDic objectForKey:@"post_created"] p_img_berita:[NSString stringWithFormat:@"%@?w=350",[loanDic objectForKey:@"image_uri"] ] p_image_content:[loanDic objectForKey:@"is_live"]];
                    //                    //  Loan *loan = [[Loan alloc] init];
                    //                    //loan.name = [loanDic objectForKey:@"name"];
                    //                    //loan.amount = [loanDic objectForKey:@"loan_amount"];
                    //                    //loan.use = [loanDic objectForKey:@"use"];
                    //                    //loan.country = [[loanDic objectForKey:@"location"] objectForKey:@"country"];
                    //
                    //                    [self.data_berita addObject:b2];
                }
            }
            
            
            
            
            if([[[Canal_Object Share_Manager]Canal_active_id] length]<4){
                NSLog(@"BAPET");
                //NSLog([NSString stringWithFormat:@"%@",breaking1]);
                //  [self reloadDatasmore:[NSString stringWithFormat:@"%@%@",breaking1,[[Canal_Object Share_Manager]Canal_active_id]]];
                
            }else{
                NSLog(@"ANIN");
            }
            
            // As this block of code is run in a background thread, we need to ensure the GUI
            // update is executed in the main thread
            [self remove_load];
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            
            
            
        }
        
        
        
    }];
    
}
-(void)reloadDatasmoreindex:(NSString *)param{
        [self.loading setAlpha:1.0];
    self.table_canal.sectionFooterHeight=40;
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:param]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSArray *latestLoans = [self fetchData:data];
            if (latestLoans) {
                NSLog(@"%lu",(unsigned long)[latestLoans count]);
                if([latestLoans count]!=0){
                    for (NSDictionary *loanDic in latestLoans) {
                        if([[[Canal_Object Share_Manager]Canal_active_id] length]>4&&[latestLoans count]<10){
                            break;
                        }
                        //  NSLog(@"%@",[loanDic objectForKey:@"post_id"]);
                        //  Loan *loan = [[Loan alloc] init];
                        //loan.name = [loanDic objectForKey:@"name"];
                        //loan.amount = [loanDic objectForKey:@"loan_amount"];
                        //loan.use = [loanDic objectForKey:@"use"];
                        //loan.country = [[loanDic objectForKey:@"location"] objectForKey:@"country"];
                        NSString *date=[loanDic objectForKey:@"post_date"];
                        NSArray* foo = [date componentsSeparatedByString: @" "];
                        date = [foo objectAtIndex: 0];
                        NSString *waktu = [[foo objectAtIndex:1] substringWithRange:NSMakeRange(0,5)];
                        NSArray *format_tgl=[date componentsSeparatedByString:@"-"];
                        date=[NSString stringWithFormat:@"%@/%@/%@",[format_tgl objectAtIndex:2],[format_tgl objectAtIndex:1],[format_tgl objectAtIndex:0]];
                        //NSString *parent_category =[loanDic objectForKey:@"parent_category"];
                        NSString *sub_category =[loanDic objectForKey:@"category_link"];
                        sub_category = [sub_category stringByReplacingOccurrencesOfString:@"-" withString:@" "];
                        sub_category= [sub_category capitalizedString];
                        
                        Frame_Berita *b2;
                        
                        if(self.index_day<1){
                            
                            b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"title"] p_tgl_berita:[loanDic objectForKey:@"post_date"] p_pukul:[NSString stringWithFormat:@" - %@ WIB",waktu] p_catagory:[loanDic objectForKey:@"category_id"]  p_datepost:[NSString stringWithFormat:@"%@ ",sub_category] p_img_berita:[NSString stringWithFormat:@"%@?w=250",[loanDic objectForKey:@"image_uri"] ] p_image_content:[loanDic objectForKey:@"is_live"]];
                            
                        }else{
                            
                            b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"title"] p_tgl_berita:[loanDic objectForKey:@"post_date"] p_pukul:[NSString stringWithFormat:@"   %@ - %@ WIB" ,date,waktu] p_catagory:[loanDic objectForKey:@"category_id"]  p_datepost:[NSString stringWithFormat:@"%@ ",sub_category] p_img_berita:[NSString stringWithFormat:@"%@?w=250",[loanDic objectForKey:@"image_uri"] ] p_image_content:[loanDic objectForKey:@"is_live"]];
                            
                        }
                        
                        
                        [self.data_berita addObject:b2];
                    }
                    self.index_start+=10;
                    [self remove_load];
                }else{
                    //  NSLog(@" Ganti Hari %i",[latestLoans count]);
                    self.index_start=0;
                    self.index_day+=1;
                    
                    
                }
            }
            // As this block of code is run in a background thread, we need to ensure the GUI
            // update is executed in the main thread
            [self performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
            
        }
    }
     
     
     ];
}

-(void)remove_load{
    
    self.table_canal.sectionFooterHeight=0;
    
}
- (NSArray *)fetchData:(NSData *)response
{
    
    NSError *error = nil;
    NSArray *parsedData = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"Error: %@", error.description);
        //  self.table_canal.sectionFooterHeight=0;
        return nil;
    }
    //self.table_canal.sectionFooterHeight=0;
    ///   self.table_canal.sectionFooterHeight=0;
    return parsedData;
    
}

- (void)reloadData
{
    // End the refreshing
    if (refreshControl) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMM d, h:mm a"];
        NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
        NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                    forKey:NSForegroundColorAttributeName];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
        refreshControl.attributedTitle = attributedTitle;
        
        
        [refreshControl endRefreshing];
    }
    [refreshControl endRefreshing];
    // Reload table data
    //[self.data_berita removeAllObjects];
    // [self.data_berita addObject:@"qwe"];
    // [self.data_berita addObject:@"qwe"];
    
    //  [self.data_berita addObject:@"qwe"];
    //[self remove_load];
        [self.loading setAlpha:0.0];
    [self.table_canal reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.data_berita count];
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIImage *myImage = [UIImage imageNamed:@"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
    imageView.frame = CGRectMake(10,10,1,30);
    
    
    
    //UITableView *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"cell_loading"];
    
    return nil;
    
    
}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//
//   // return 40;
//}
- (UIImage*)loadImage
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* path = [documentsDirectory stringByAppendingPathComponent:
                      @"test.png" ];
    UIImage* image = [UIImage imageWithContentsOfFile:path];
    return image;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BeritaTableViewCell *cell;
    // NSLog(@" okok %i",[self.data_berita count]);
    Frame_Berita *data = [self.data_berita objectAtIndex:indexPath.row];
    if(indexPath.row==0){
        
        // cell.label_judul_berita.text = data.Judul_Berita ;//[[self.data_berita objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell= [tableView dequeueReusableCellWithIdentifier:@"cell_head" forIndexPath:indexPath];
        
        cell.label_judul_berita.font=self.font_size_judul_headline;
        cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, 145,cell.view_judul_berita.frame.size.width, cell.view_judul_berita.frame.size.height);
        
        cell.label_tgl_berita.font=self.font_size_tgl;
        cell.label_canal_berita.font=self.font_size_canal;
        if([data.Img_Content integerValue]==0){
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"%@",data.Judul_Berita];
        }else{
            //  cell.label_judul_berita.font=self.font_size_judul;
            cell.img_live.hidden=NO;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"       %@",data.Judul_Berita];
        }
        NSString *text = cell.label_judul_berita.text;
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:cell.label_judul_berita.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        [cell.label_judul_berita setFrame:CGRectMake(CELL_CONTENT_MARGIN, 0, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2),size.height)];
        
        
        
        //cell.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, self.first_height);
        //cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, self.first_height-3);
        if(self.first_height<70){
            //cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, 145,cell.view_judul_berita.frame.size.width, cell.view_judul_berita.frame.size.height);
            //cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, 185);
            [[Canal_Object Share_Manager]setIndex_height:self.first_height];
        }else{
            // cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, 160,cell.view_judul_berita.frame.size.width, cell.view_judul_berita.frame.size.height);
            // cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, 205);
            [[Canal_Object Share_Manager]setIndex_height:self.first_height];
        }
        dispatch_queue_t queue = dispatch_queue_create("Sibertama.Bisniscom", NULL);
        dispatch_async(queue, ^{
            //code to be executed in the background
            NSURL   *url  = [NSURL URLWithString:data.Img_Berita];//[[self.json_berita objectAtIndex:indexPath.row] objectForKey:@"title"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //code to be executed on the main thread when background task is finished
                if(image==nil){
                    cell.img_berita.image = [UIImage imageNamed:@"img_logo.png"];
                    // cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, 155,cell.view_judul_berita.frame.size.width, cell.view_judul_berita.frame.size.height);
                    // cell.label_judul_berita.frame =CGRectMake(cell.label_judul_berita.frame.origin.x,0,cell.label_judul_berita.frame.size.width,cell.view_judul_berita.frame.size.height);
                }else{
                    cell.img_berita.image=image;
                    self.first_height=image.size.height;
                    [[Canal_Object Share_Manager]setIndex_height:self.first_height];
                    if(size.height>=536870912){
                        cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, (cell.frame.size.height/2.5),cell.view_judul_berita.frame.size.width, cell.label_judul_berita.frame.size.height);
                        cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, 185);
                        
                    }else{
                        cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, (cell.frame.size.height/2.4),cell.view_judul_berita.frame.size.width, cell.label_judul_berita.frame.size.height);
                        cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, 205);
                    }
                    //cell.label_judul_berita.frame =CGRectMake(cell.label_judul_berita.frame.origin.x,0,cell.label_judul_berita.frame.size.width,cell.view_judul_berita.frame.size.height);
                    cell.img_berita.contentMode=UIViewContentModeScaleToFill;
                    
                    
                    //  cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, self.first_height-3);
                    // cell.frame=CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, image.size.height);
                    //                    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
                    //                        if(self.first_height<70){
                    //                            cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, 350);
                    //                            cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, 270,cell.view_judul_berita.frame.size.width, cell.view_judul_berita.frame.size.height);
                    //
                    //                        }else{
                    //                            cell.img_berita.frame = CGRectMake(cell.img_berita.frame.origin.x, cell.img_berita.frame.origin.y,cell.img_berita.frame .size.width, 400);
                    //                            cell.view_judul_berita.frame =CGRectMake(cell.view_judul_berita.frame.origin.x, 320,cell.view_judul_berita.frame.size.width, cell.view_judul_berita.frame.size.height);
                    //
                    //                        }
                    //                    }
                    
                    
                    
                    
                    //                    if (image != nil)
                    //                    {
                    //                        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                    //                                                                             NSUserDomainMask, YES);
                    //                        NSString *documentsDirectory = [paths objectAtIndex:0];
                    //                        NSString* path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"test.png"]];
                    //                        NSData* data = UIImagePNGRepresentation(image);
                    //                        [data writeToFile:path atomically:YES];
                    //                    }
                }
                
            });
        });
        
        NSMutableAttributedString *s =
        [[NSMutableAttributedString alloc] initWithString:cell.label_judul_berita.text];
        
        [s addAttribute:NSBackgroundColorAttributeName
                  value:[UIColor colorWithRed:238.0f/225.0f green:191.0f/255.0f blue:42.0f/255.0f alpha:1.0f]
                  range:NSMakeRange(0, s.length)];
        
        
        cell.label_judul_berita.attributedText =s;
        
        //tableView.estimatedRowHeight = 68.0;
        tableView.rowHeight = UITableViewAutomaticDimension;
        
        
    }else if(indexPath.row==1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell_head2" forIndexPath:indexPath];
        cell.label_judul_berita.text =  data.Judul_Berita ;
        cell.label_judul_berita.font=self.font_size_judul_headline;
        [ cell.label_judul_berita setNumberOfLines:0];
        [ cell.label_judul_berita sizeToFit];
        cell.label_judul_berita.frame =CGRectMake( 10,0,cell.frame.size.width - 25,50);
        
        if([data.Img_Content integerValue]==0){
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"%@",data.Judul_Berita];
        }else{
            //  cell.label_judul_berita.font=self.font_size_judul;
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"%@",data.Judul_Berita];
        }
        tableView.rowHeight = UITableViewAutomaticDimension;
        NSMutableAttributedString *s =
        [[NSMutableAttributedString alloc] initWithString:  cell.label_judul_berita.text];
        
        [s addAttribute:NSBackgroundColorAttributeName
                  value:[UIColor colorWithRed:238.0f/225.0f green:191.0f/255.0f blue:42.0f/255.0f alpha:1.0f]
                  range:NSMakeRange(0, s.length)];
        
        
        [cell.label_judul_berita sizeToFit];
        NSString *text = cell.label_judul_berita.text;
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:cell.label_judul_berita.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        [cell.label_judul_berita setText:text];
        [cell.label_judul_berita setFrame:CGRectMake(CELL_CONTENT_MARGIN, 10, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2),size.height)];
        
        
        cell.label_judul_berita.attributedText =s;
        
        
        
        
        
    }else if(indexPath.row==2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell_head3" forIndexPath:indexPath];
        
        cell.label_judul_berita.font=self.font_size_judul_headline;
        [ cell.label_judul_berita setNumberOfLines:0];
        
        // cell.label_judul_berita.frame =CGRectMake( 10,0,cell.frame.size.width - 25,50);
        
        tableView.rowHeight = UITableViewAutomaticDimension;
        if([data.Img_Content integerValue]==0){
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"%@",data.Judul_Berita];
        }else{
            //  cell.label_judul_berita.font=self.font_size_judul;
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"%@",data.Judul_Berita];
        }
        
        NSMutableAttributedString *s =
        [[NSMutableAttributedString alloc] initWithString: cell.label_judul_berita.text];
        
        [s addAttribute:NSBackgroundColorAttributeName
                  value:[UIColor colorWithRed:238.0f/225.0f green:191.0f/255.0f blue:42.0f/255.0f alpha:1.0f]
                  range:NSMakeRange(0, s.length)];
        
        NSString *text = cell.label_judul_berita.text;
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:cell.label_judul_berita.font constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        [cell.label_judul_berita setText:text];
        [cell.label_judul_berita setFrame:CGRectMake(CELL_CONTENT_MARGIN, 10, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2),size.height)];
        
        
        
        cell.label_judul_berita.attributedText =s;
        
        [cell sizeToFit];
        
        
        
        
        
        cell.view_latest.frame = CGRectMake(0,cell.label_judul_berita.frame.origin.x+cell.label_judul_berita.frame.size.height+10,cell.view_latest.frame.size.width ,cell.view_latest.frame.size.height);
        
        
    }else if(indexPath.row==[self.data_berita count]-1){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell_canal" forIndexPath:indexPath];
        cell.label_judul_berita.text =  data.Judul_Berita ; //[[self.data_berita objectAtIndex:indexPath.row] objectForKey:@"title"];
        cell.label_tgl_berita.text = data.Pukul;
        cell.label_canal_berita.text = data.Datepost;
        
        cell.label_judul_berita.font=self.font_size_judul;
        cell.label_tgl_berita.font=self.font_size_tgl;
        cell.label_canal_berita.font=self.font_size_canal;
        
        if(  [data.Img_Content integerValue]==0){
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text = [NSString stringWithFormat:@"%@",data.Judul_Berita];
        }else{
            //  cell.label_judul_berita.font=self.font_size_judul;
            cell.img_live.hidden=NO;
            cell.label_judul_berita.text =[NSString stringWithFormat:@"       %@",data.Judul_Berita];
        }
        
        
        NSString *text = cell.label_judul_berita.text;
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:self.font_size_judul constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        [cell.label_judul_berita setText:text];
        [cell.label_judul_berita setFrame:CGRectMake(CELL_CONTENT_MARGIN, 20, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), size.height)];
        
        
        
        if(  [data.Img_Content integerValue]==0){
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text = [NSString stringWithFormat:@"%@",data.Judul_Berita];
        }else{
            cell.img_live.hidden=NO;
            cell.label_judul_berita.text =[NSString stringWithFormat:@"       %@",data.Judul_Berita];
        }
        
        
        //  cell.label_judul_berita.numberOfLines=3;
        //  [cell.label_judul_berita sizeToFit];
        
        cell.view_latest.backgroundColor=[UIColor colorWithPatternImage:[[UIImage imageNamed:@"shape-line.png"]stretchableImageWithLeftCapWidth:13 topCapHeight:0]];
        cell.view_latest.frame = CGRectMake(0, cell.label_judul_berita.frame.origin.y+cell.label_judul_berita.frame.size.height+10, cell.frame.size.width, 1.5);
        

        
        
//        dispatch_queue_t queue = dispatch_queue_create("Sibertama.Bisniscom", NULL);
//        dispatch_async(queue, ^{
//            //code to be executed in the background
//            NSURL   *url  = [NSURL URLWithString:data.Img_Berita];//[[self.json_berita objectAtIndex:indexPath.row] objectForKey:@"title"];
//            NSData *data = [NSData dataWithContentsOfURL:url];
//            UIImage *image = [UIImage imageWithData:data];
//            dispatch_async(dispatch_get_main_queue(), ^{
//                
//                //code to be executed on the main thread when background task is finished
//                if(image==nil){
//                    cell.img_berita.image = [UIImage imageNamed:@"img_logo.png"];
//                }else{
//                    cell.img_berita.image=image;
//                }
//                
//            });
//        });
        //    NSLog(@" muali satar %@",[[Canal_Object Share_Manager]Canal_active_id]);
        if([[[Canal_Object Share_Manager]Canal_active_id]length]<4){
            if([self.data_berita count]>=10){
                //  new DataDownloaderOfIndex(adapter_list_berita,proses,index_start,index_much,index_day).execute(con.URL+"indeks_breaking/1/"+canal+"/"+index_day.getContentDescription()+"/"+index_start.getContentDescription()+"/10");
                NSLog(@"%@/%@/%i/%i/10",index,[[Canal_Object Share_Manager]Canal_active_id],self.index_day,self.index_start);
                [self reloadDatasmoreindex:[NSString stringWithFormat:@"%@/%@/%i/%i/10",index,self.flag_tabs,self.index_day,self.index_start]];
            }else{
                //  [self reloadDatasmore:[NSString stringWithFormat:@"%@%@",breaking1,[[Canal_Object Share_Manager]Canal_active_id]]];
            }
        }
    }else if(indexPath.row>2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell_canal" forIndexPath:indexPath];
        cell.label_tgl_berita.text = data.Pukul;
        cell.label_canal_berita.text = data.Datepost;
        
        cell.label_judul_berita.font=self.font_size_judul;
        cell.label_tgl_berita.font=self.font_size_tgl;
        cell.label_canal_berita.font=self.font_size_canal;
        
        
        [cell.label_canal_berita sizeToFit];
        cell.label_tgl_berita.frame = CGRectMake(15+cell.label_canal_berita.frame.size.width,cell.label_tgl_berita.frame.origin.y, cell.frame.size.width, cell.label_canal_berita.frame.size.height);
        
        
        
        
        //
        //        //  NSLog(@"%@",data.Img_Berita);
        //        dispatch_queue_t queue = dispatch_queue_create("Sibertama.Bisniscom", NULL);
        //
        //        dispatch_async(queue, ^{
        //            //code to be executed in the background
        //            NSURL   *url  = [NSURL URLWithString:data.Img_Berita];//[[self.json_berita objectAtIndex:indexPath.row] objectForKey:@"title"];
        //            NSData *data = [NSData dataWithContentsOfURL:url];
        //            UIImage *image = [UIImage imageWithData:data];
        //            dispatch_async(dispatch_get_main_queue(), ^{
        //
        //                //code to be executed on the main thread when background task is finished
        //                if(image==nil){
        //                    cell.img_berita.image = [UIImage imageNamed:@"img_logo.png"];
        //                }else{
        //                    cell.img_berita.image=image;
        //
        //                }
        //
        //            });
        //        });
        
        // NSString *identifier = [NSString stringWithFormat:@"%@" ,data.Img_Berita];
        /*
         if([self.cachedImages objectForKey:identifier] != nil){
         cell.img_berita.image = [self.cachedImages valueForKey:identifier];
         }else{
         
         char const * s = [identifier  UTF8String];
         
         dispatch_queue_t queue = dispatch_queue_create(s, 0);
         
         dispatch_async(queue, ^{
         
         NSString *url = data.Img_Berita;
         
         UIImage *img = nil;
         
         NSData *data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:url]];
         
         img = [[UIImage alloc] initWithData:data];
         
         dispatch_async(dispatch_get_main_queue(), ^{
         
         if ([tableView indexPathForCell:cell].row == indexPath.row) {
         
         [self.cachedImages setValue:img forKey:identifier];
         
         
         if(img==nil){
         cell.img_berita.image = [UIImage imageNamed:@"img_logo.png"];
         }else{
         cell.img_berita.image = [self.cachedImages valueForKey:identifier];
         }
         
         
         
         }
         });//end
         });//end
         }
         */
        
        if(  [data.Img_Content integerValue]==0){
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"%@",data.Judul_Berita];
        }else{
            //  cell.label_judul_berita.font=self.font_size_judul;
            cell.img_live.hidden=NO;
            cell.label_judul_berita.text=[NSString stringWithFormat:@"       %@",data.Judul_Berita];
        }
        
        
        //        [cell.img_berita.layer setBorderWidth:1.0f];
        //        [cell.img_berita.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        
        //        CALayer *borderLayer = [CALayer layer];
        //        CGRect borderFrame = CGRectMake(0, 0, (cell.img_berita.frame.size.width), (cell.img_berita.frame.size.height));
        //        [borderLayer setBackgroundColor:[[UIColor clearColor] CGColor]];
        //        [borderLayer setFrame:borderFrame];
        //        [borderLayer setCornerRadius:4.0];
        //        [borderLayer setBorderWidth:4.0];
        //        [borderLayer setBorderColor:[[UIColor whiteColor] CGColor]];
        //        [cell.img_berita.layer addSublayer:borderLayer];
        
        //        cell.img_berita .layer.cornerRadius = 10;
        //        cell.img_berita .layer.shadowColor = [[UIColor blackColor] CGColor];
        //        cell.img_berita .layer.shadowOpacity = 1;
        //        cell.img_berita .layer.shadowRadius = 10;
        //        cell.img_berita .layer.shadowOffset = CGSizeMake(-2, 7);
        //[cell.img_berita  setBackgroundColor:[UIColor redColor]];
        //cell.img_berita .center=  CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
        
        
        // cell.label_judul_berita.frame = CGRectMake(10, 20,cell.frame.size.width-25, 80);
        
        
        
        [cell.label_judul_berita sizeToFit];
        
        NSString *text = cell.label_judul_berita.text;
        
        
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:self.font_size_judul constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        [cell.label_judul_berita setText:text];
        [cell.label_judul_berita setFrame:CGRectMake(CELL_CONTENT_MARGIN, 20, CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), MAX(size.height, 44.0f))];
        
        cell.view_latest.backgroundColor=[UIColor colorWithPatternImage:[[UIImage imageNamed:@"shape-line.png"]stretchableImageWithLeftCapWidth:13 topCapHeight:0]];
        cell.view_latest.frame = CGRectMake(0, cell.label_judul_berita.frame.origin.y+cell.label_judul_berita.frame.size.height+10, cell.frame.size.width, 1.5);
        
        
        
        if(  [data.Img_Content integerValue]==0){
            cell.img_live.hidden=YES;
            cell.label_judul_berita.text = [NSString stringWithFormat:@"%@",data.Judul_Berita];
        }else{
            cell.img_live.hidden=NO;
            cell.label_judul_berita.text =[NSString stringWithFormat:@"       %@",data.Judul_Berita];
        }
        
        
        cell.img_berita.image=[UIImage imageNamed:@"img_logo.png"];
        
    }
    
    // Configure the cell...
    
    // cell.textLabel.text = [NSString stringWithFormat:@"CELL %i",indexPath.row];
    //cell.detailTextLabel.text=@"wo14";
    //    if(indexPath.row>0){
    //
    //    }
    
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    
    
    
    
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!self.custom_cell_berita){
        self.custom_cell_berita = [self.table_canal dequeueReusableHeaderFooterViewWithIdentifier:@"cell_head"];
    }
    //CGFloat height=0;
    Frame_Berita *data = [self.data_berita objectAtIndex:indexPath.row];
    
    NSString *text = data.Judul_Berita;
    
    
    if(indexPath.row==0){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if(self.first_height<70){
                return 190;
            }else{
                return 210;
            }
            
        }
    }else if(indexPath.row<2){
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:self.font_size_judul_headline constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height +20 ;
    }
    else if(indexPath.row==2){
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:self.font_size_judul_headline constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height +95 ;
    }
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:self.font_size_judul constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGSize tgl_size = [[NSString stringWithString:@"kabar"] sizeWithFont:self.font_size_judul constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap ];
    
    
    return size.height +tgl_size.height + 20 ;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    // calculate a hight base on cell
    
    if(!self.custom_cell_berita){
        self.custom_cell_berita = [self.table_canal dequeueReusableHeaderFooterViewWithIdentifier:@"cell_head"];
    }
    //CGFloat height=0;
    Frame_Berita *data = [self.data_berita objectAtIndex:indexPath.row];
    
    NSString *text = data.Judul_Berita;
    
    
    NSLog(@"CANAL %@",[[Canal_Object Share_Manager] Canal_active_id]);
    
    
    if(indexPath.row==0){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            if(self.first_height<70){
                return 190;
            }else{
                return 210;
            }
            
        }
    }else if(indexPath.row<2){
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:self.font_size_judul_headline constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height +20 ;
    }
    else if(indexPath.row==2){
        CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
        
        CGSize size = [text sizeWithFont:self.font_size_judul_headline constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        return size.height +95 ;
    }
    
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:self.font_size_judul constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    
    CGSize tgl_size = [[NSString stringWithString:@"kabar"] sizeWithFont:self.font_size_judul constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap ];
    
    
    return size.height +tgl_size.height + 20 ;
    

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //[[Detail_Object sharedManager] setSomeProperty:[NSString stringWithFormat:@"%i",indexPath.row]];
    //[[Detail_Object sharedManager]setSomeDetail:self.data_berita];
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.table_canal indexPathForSelectedRow];
    // UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    // destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"segue_detail"]) {
        [[Detail_Object sharedManager]setSomeProperty:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        [[Detail_Object sharedManager]setSomeDetail:self.data_berita];
        [[Canal_Object Share_Manager]setIndex_day:self.index_day];
        [[Canal_Object Share_Manager]setIndex_start:self.index_start];
    }
    if ([segue.identifier isEqualToString:@"segue_detail2"]) {
        [[Detail_Object sharedManager]setSomeProperty:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        [[Detail_Object sharedManager]setSomeDetail:self.data_berita];
        [[Canal_Object Share_Manager]setIndex_day:self.index_day];
        [[Canal_Object Share_Manager]setIndex_start:self.index_start];
        
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

//This function is where all the magic happens
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( 0, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    cell.layer.shadowColor = [[UIColor blackColor]CGColor];
    cell.layer.shadowOffset = CGSizeMake(10, 10);
    cell.alpha = 0;
    
    cell.layer.transform = rotation;
    cell.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //!!!FIX for issue #1 Cell position wrong------------
    if(cell.layer.position.x != 0){
        cell.layer.position = CGPointMake(0, cell.layer.position.y);
    }
    
    //4. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.7];
    cell.layer.transform = CATransform3DIdentity;
    cell.alpha = 1;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];
}


//Helper function to get a random float
- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}





@end
