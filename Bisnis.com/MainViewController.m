//
//  MainViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "MainViewController.h"
#import "ECSlidingViewController.h"
#import "NavTableViewController.h"
#import "DbManager.h"
#import "Frame_Menu.h"
#import "Canal_Object.h"
#import "Frame_Color.h"

@interface MainViewController ()
{
    UIRefreshControl *refreshControl;
}

@property(strong,nonatomic)DbManager *dbManager;

//pageslidingdrawler
@property (nonatomic, strong) NSArray *carMakes;
@property (nonatomic, strong) UILabel *selectedItemLabel;
@property (nonatomic, strong) HMSegmentedControl *segmentedControl1;
@property (nonatomic, strong) NSArray *viewControllers;

@property(nonatomic,strong)NSArray *menuItems;
@property(strong,nonatomic)NSArray *nav_item;
@property(strong,nonatomic)NSArray *canal_item;
@property(strong,nonatomic)NSArray *color_canal;
@property(strong,nonatomic)NSMutableArray *arr_nav_info;
@property(strong,nonatomic)  PageContentViewController *startingViewController;
//endpageslidingdrawler

@end

@implementation MainViewController

@synthesize flag_tabs;



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
    //self.view.layer.shadowColor = [UIColor blackColor].CGColor
    if(![self.slidingViewController.underLeftViewController isKindOfClass:[NavTableViewController class]]){
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Menu"];
    }
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    
    
    self.flag_tabs = [[Canal_Object Share_Manager] Tabs_old];
    
    
    
    
    
    Frame_Menu *f1= [[Frame_Menu alloc]initWithNavId:@"0" p_nav_name:@"Berita Terbaru" p_nav_img:@"berita_terbaru.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *f2= [[Frame_Menu alloc]initWithNavId:@"editorchoices" p_nav_name:@"Headline" p_nav_img:@"headline.png" p_nav_position:2 p_nav_status:@"0"];
    Frame_Menu *f3= [[Frame_Menu alloc]initWithNavId:@"saham" p_nav_name:@"Terpopuler" p_nav_img:@"terpopuler.png" p_nav_position:3 p_nav_status:@"0"];
    Frame_Menu *f4= [[Frame_Menu alloc]initWithNavId:@"hargaemas" p_nav_name:@"Unggulan" p_nav_img:@"unggulan.png" p_nav_position:4 p_nav_status:@"0"];
    Frame_Menu *f5= [[Frame_Menu alloc]initWithNavId:@"finansial" p_nav_name:@"Trending News" p_nav_img:@"trending_news.png" p_nav_position:1 p_nav_status:@"0"];

    Frame_Menu *c1= [[Frame_Menu alloc]initWithNavId:@"186" p_nav_name:@"Kabar24" p_nav_img:@"quick_news.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c2= [[Frame_Menu alloc]initWithNavId:@"194" p_nav_name:@"Market" p_nav_img:@"market.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c3= [[Frame_Menu alloc]initWithNavId:@"5" p_nav_name:@"Finansial" p_nav_img:@"finansial.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c4= [[Frame_Menu alloc]initWithNavId:@"43" p_nav_name:@"Industri" p_nav_img:@"industri.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c6= [[Frame_Menu alloc]initWithNavId:@"272" p_nav_name:@"Otomotif" p_nav_img:@"otomotif.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c19= [[Frame_Menu alloc]initWithNavId:@"382" p_nav_name:@"Jakarta" p_nav_img:@"jakarta_raya.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c25= [[Frame_Menu alloc]initWithNavId:@"392" p_nav_name:@"Bola" p_nav_img:@"bola.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c14= [[Frame_Menu alloc]initWithNavId:@"197" p_nav_name:@"Life & Style" p_nav_img:@"lifestyle.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c7= [[Frame_Menu alloc]initWithNavId:@"277" p_nav_name:@"Gadget" p_nav_img:@"gadget.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c13= [[Frame_Menu alloc]initWithNavId:@"222" p_nav_name:@"Traveling" p_nav_img:@"traveler.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c5= [[Frame_Menu alloc]initWithNavId:@"47" p_nav_name:@"Properti" p_nav_img:@"properti.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c8= [[Frame_Menu alloc]initWithNavId:@"57" p_nav_name:@"Sport" p_nav_img:@"sport.png" p_nav_position:1 p_nav_status:@"0"];
   // Frame_Menu *c11= [[Frame_Menu alloc]initWithNavId:@"242" p_nav_name:@"Koran Bisnis" p_nav_img:@"bisnis_indonesia.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c10= [[Frame_Menu alloc]initWithNavId:@"231" p_nav_name:@"Bisnis Syariah" p_nav_img:@"bisnis_syariah.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c12= [[Frame_Menu alloc]initWithNavId:@"52" p_nav_name:@"Manajemen" p_nav_img:@"manajemen.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c17= [[Frame_Menu alloc]initWithNavId:@"258" p_nav_name:@"Entrepreneur" p_nav_img:@"inspirasi_bisnis.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c16= [[Frame_Menu alloc]initWithNavId:@"243" p_nav_name:@"Info" p_nav_img:@"indonesia_today.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c24= [[Frame_Menu alloc]initWithNavId:@"73" p_nav_name:@"Inforial" p_nav_img:@"inforial" p_nav_position:1 p_nav_status:@"0"];
    
   
    
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
    
    _menuItems = @[@"menu_search", @"section_front", @"menu_front", @"section_favorite", @"menu_favorite", @"section_canal",@"menu_canal",@"section_other", @"menu_about",@"menu_setting"];
    
    self.nav_item = [NSArray arrayWithObjects:f1,f2,f3,f4,f5, nil];
    
    //self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c6,c19,c25,c14,c7,c13,c5,c8,c11,c10,c12,c17,c16,c24, nil];
    self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c6,c19,c25,c14,c7,c13,c5,c8,c10,c12,c17,c16,c24, nil];

 
    //setup pagesliding
    self.edgesForExtendedLayout = UIRectEdgeNone;

    //end pagesliding
    
    
    // Segmented control with scrolling
 //
    
    
    if([self.flag_tabs isEqualToString:@"allchannels"]){
        
        NSMutableArray *pageTitles2 =[NSMutableArray arrayWithObjects:nil];
        for (NSInteger a =0; a < [self.canal_item count]; a++) {
            
            Frame_Menu *f_copy = [self.canal_item objectAtIndex:a];
            [pageTitles2 addObject:f_copy.nav_name];
            
        //    NSLog(@"JUML:AH DATA %i",[pageTitles2 count]);
            
            
        }
        
        _pageTitles = [pageTitles2 copy];
    }else if([self.flag_tabs isEqualToString:@"allfavorites"]){
        self.dbManager = [[DbManager alloc] initWithDatabaseFilename:@"bisnisios.sql"];
        
        NSMutableArray *pageTitles2 =[NSMutableArray arrayWithObjects:nil];
        
        NSString *query = @"select * from nav_info where nav_status=1  order by nav_position ";
        [self.arr_nav_info removeAllObjects];    // Get the results.
        if (self.arr_nav_info != nil) {
            self.arr_nav_info = nil;
        }
        self.arr_nav_info = [NSMutableArray arrayWithArray:[self.dbManager loadDataFromDB:query]];
        
        for (NSInteger a =0; a < [self.arr_nav_info count]; a++) {

            [pageTitles2 addObject:[[[self arr_nav_info] objectAtIndex:a] objectAtIndex:1]];
           // NSLog(@"JUML:AH DATA %i isi %@ ",[pageTitles2 count],[[self arr_nav_info] objectAtIndex:a]);
            
        }
        
        
          // _pageTitles = @[@"BERITA TERBARU", @"EDITOR CHOICE", @"REKOMENDASI SAHAM", @"HARGA EMAS", @"FINANSIAL"];
        
        _pageTitles = [pageTitles2 copy];
        
        //[self load_db_nav];
        
    }else if([self.flag_tabs isEqualToString:@"frontpage"]){
        _pageTitles = @[@"BERITA TERBARU", @"EDITOR CHOICE", @"REKOMENDASI SAHAM", @"HARGA EMAS", @"FINANSIAL"];
    }


    self.segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:_pageTitles];
    self.segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    self.segmentedControl1.frame = CGRectMake(0,45, self.view.frame.size.width, 32);
    self.segmentedControl1.segmentEdgeInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleBox;
    self.segmentedControl1.segmentWidthStyle=HMSegmentedControlSegmentWidthStyleDynamic;
    
    self.segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    if([self.flag_tabs isEqualToString:@"allfavorites"]){
        
        
        for (NSInteger a =0; a < [self.color_canal count]; a++) {
            Frame_Color *f_copy = [self.color_canal objectAtIndex:a];
           // NSLog(@"JUML:AH DATA %@ isi %@ ",f_copy.color_id,[[self.arr_nav_info objectAtIndex:0] objectAtIndex:0]);
            if([f_copy.color_id isEqualToString:[[self.arr_nav_info objectAtIndex:0] objectAtIndex:0]]){
               // batas_atas.backgroundColor=f_copy.color;
                  self.segmentedControl1.selectionIndicatorColor = f_copy.color;
                
                break;
            }
            
        }

        
        }else if(([self.flag_tabs isEqualToString:@"allchannels"] || [[[Canal_Object Share_Manager]Canal_active_id]length]<4)&![[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"0"]){
        self.segmentedControl1.selectionIndicatorColor = color1.color;

    }else{
        self.segmentedControl1.selectionIndicatorColor = [UIColor colorWithRed:51.0f/255.f green:51.0f/255.0f blue:51.0f/255.0f alpha:1.0f];

    }
    
    self.segmentedControl1.verticalDividerEnabled = YES;
    self.segmentedControl1.verticalDividerColor = [UIColor clearColor];
    self.segmentedControl1.verticalDividerWidth = 1.0f;
    
    self.segmentedControl1.selectionIndicatorHeight = 4.0f;
    self.segmentedControl1.backgroundColor = [UIColor colorWithRed:245.0f/255.0f green:245.0f/255.0f blue:245.0f/255.0f alpha:0.5];
     self.segmentedControl1.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};
    self.segmentedControl1.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor redColor]};

    
   
    [self.segmentedControl1 addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentedControl1];
    
    
    //Page
    
    // Create the data model
 
  //  _pageImages = @[@"page1.png", @"page2.png", @"page3.png", @"page4.png"];
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self;
    
    self.startingViewController = [self viewControllerAtIndex:0];
    self.viewControllers = @[self.startingViewController];
    [self.pageViewController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, (self.segmentedControl1.frame.size.height +45), self.view.frame.size.width, self.view.frame.size.height-40 );
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    //end pagecontet
    
//    self.selectedItemLabel = [[UILabel alloc] init];
//    self.selectedItemLabel.text = @"MODEAADDA";
//    self.selectedItemLabel.translatesAutoresizingMaskIntoConstraints = NO;
//    self.selectedItemLabel.frame=CGRectMake(400, (200), self.view.frame.size.width, self.view.frame.size.height);
//    [self.view addSubview:self.selectedItemLabel];
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedItemLabel
//                                                          attribute:NSLayoutAttributeCenterX
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeLeftMargin
//                                                         multiplier:1.0
//                                                           constant:50.0]];
//    
//    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.selectedItemLabel
//                                                          attribute:NSLayoutAttributeCenterY
//                                                          relatedBy:NSLayoutRelationEqual
//                                                             toItem:self.view
//                                                          attribute:NSLayoutAttributeBottomMargin
//                                                         multiplier:1.0
//                                                           constant:-50.0]];
//    [self.view bringSubviewToFront:self.selectedItemLabel];
    
}

-(void)load_db_nav{
    NSString *query = @"select * from nav_info where nav_status=1  order by nav_position ";
    [self.arr_nav_info removeAllObjects];    // Get the results.
    if (self.arr_nav_info != nil) {
        self.arr_nav_info = nil;
    }
    self.arr_nav_info = [NSMutableArray arrayWithArray:[self.dbManager loadDataFromDB:query]];
    
    //  NSLog(@"woke %@",self.arr_nav_info);
}

- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
    if(([[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"allchannels"] || [[[Canal_Object Share_Manager]Canal_active_id]length]<4)&![[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"0"]){
        Frame_Color *color_select = [self.color_canal objectAtIndex:segmentedControl.selectedSegmentIndex];
        self.segmentedControl1.selectionIndicatorColor = color_select.color;
    }
    
    self.startingViewController = [self viewControllerAtIndex:segmentedControl.selectedSegmentIndex];
    self.viewControllers = @[self.startingViewController];
    [self.pageViewController setViewControllers:self.viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
}

- (void)uisegmentedControlChangedValue:(UISegmentedControl *)segmentedControl {
    NSLog(@"Selected index %ld", (long)segmentedControl.selectedSegmentIndex);
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - HTHorizontalSelectionListDataSource Protocol Methods

- (NSInteger)numberOfItemsInSelectionList:(HTHorizontalSelectionList *)selectionList {
    return self.carMakes.count;
}

- (NSString *)selectionList:(HTHorizontalSelectionList *)selectionList titleForItemWithIndex:(NSInteger)indexpage {
    return self.carMakes[indexpage];
}

- (PageContentViewController *)viewControllerAtIndex:(NSUInteger)indexpcvc
{
    if (([self.pageTitles count] == 0) || (indexpcvc >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    PageContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    //pageContentViewController.imageFile = self.pageImages[indexpcvc];
   // pageContentViewController.titleText = self.pageTitles[indexpcvc];
    pageContentViewController.pageIndex = indexpcvc;
    Frame_Menu *menu_data ;
    NSLog(@"MODEL %@",[[Canal_Object Share_Manager]Canal_active_id]);
    if(([self.flag_tabs isEqualToString:@"allchannels"] || [self.flag_tabs length]<4)&![self.flag_tabs isEqualToString:@"0"]){
        menu_data = [self.canal_item objectAtIndex:indexpcvc];
    }else if([self.flag_tabs isEqualToString:@"allfavorites"]){
        menu_data = [[Frame_Menu alloc] initWithNavId:[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:0]  p_nav_name:[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:1] p_nav_img:[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:2] p_nav_position:[[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:3] integerValue] p_nav_status:[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:4]];
    }else{
        menu_data = [self.nav_item objectAtIndex:indexpcvc];
    }
    
   
    [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"%@",menu_data.nav_name]];
    [[Canal_Object Share_Manager]setCanal_active_id:[NSString stringWithFormat:@"%@",menu_data.nav_id]];
    
    return pageContentViewController;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger indexpcvc = ((PageContentViewController*) viewController).pageIndex;
     [self.segmentedControl1 setSelectedSegmentIndex:indexpcvc animated:YES];
     if([self.flag_tabs isEqualToString:@"allfavorites"]){
         for (NSInteger a =0; a < [self.color_canal count]; a++) {
             Frame_Color *f_copy = [self.color_canal objectAtIndex:a];
             NSLog(@"JUML:AH DATA %@ isi %@ ",f_copy.color_id,[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:0]);
             if([f_copy.color_id isEqualToString:[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:0]]){
                 // batas_atas.backgroundColor=f_copy.color;
                 self.segmentedControl1.selectionIndicatorColor = f_copy.color;
                 
                 break;
             }
             
         }
    }else
    if(([self.flag_tabs isEqualToString:@"allchannels"] || [[[Canal_Object Share_Manager]Canal_active_id]length]<4)&![[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"0"]){
        Frame_Color *color_select = [self.color_canal objectAtIndex:indexpcvc];
        self.segmentedControl1.selectionIndicatorColor = color_select.color;
    }
    
    if ((indexpcvc == 0) || (indexpcvc == NSNotFound)) {
        [self.segmentedControl1 setSelectedSegmentIndex:0 animated:YES];
        return nil;
    }
    
    indexpcvc--;
   
    return [self viewControllerAtIndex:indexpcvc];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger indexpcvc = ((PageContentViewController*) viewController).pageIndex;
    
    if (indexpcvc == NSNotFound) {
        return nil;
    }
     [self.segmentedControl1 setSelectedSegmentIndex:indexpcvc animated:YES];
    
    NSLog(@"MODEL %@",[[Canal_Object Share_Manager]Canal_active_id]);
     if([self.flag_tabs isEqualToString:@"allfavorites"]){
         
         for (NSInteger a =0; a < [self.color_canal count]; a++) {
             Frame_Color *f_copy = [self.color_canal objectAtIndex:a];
             NSLog(@"JUML:AH DATA %@ isi %@ ",f_copy.color_id,[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:0]);
             if([f_copy.color_id isEqualToString:[[self.arr_nav_info objectAtIndex:indexpcvc] objectAtIndex:0]]){
                 // batas_atas.backgroundColor=f_copy.color;
                 self.segmentedControl1.selectionIndicatorColor = f_copy.color;
                 
                 break;
             }
             
         }
         
    }else
    if(([[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"allchannels"] || [[[Canal_Object Share_Manager]Canal_active_id]length]<4)&![[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"0"]){
        Frame_Color *color_select = [self.color_canal objectAtIndex:indexpcvc];
        self.segmentedControl1.selectionIndicatorColor = color_select.color;
    }

 
    indexpcvc++;
    if (indexpcvc == [self.pageTitles count]) {
        //[self.segmentedControl1 setSelectedSegmentIndex:indexpcvc animated:YES];
        return nil;
    }
   
    return [self viewControllerAtIndex:indexpcvc];
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
 
    if([[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"allchannels"]){
         return [self.canal_item count];
    }else if([[[Canal_Object Share_Manager]Canal_active_id] isEqualToString:@"allfavorites"]){
        return  [self.arr_nav_info count];
    }else{
          return [self.nav_item count];
    }
    
  
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}



@end
