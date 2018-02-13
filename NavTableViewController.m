//
//  NavTableViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/9/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import "NavTableViewController.h"
#import "ECSlidingViewController.h"
#import "MenuTableViewCell.h"
#import "MainViewController.h"
#import "Canal_Object.h"
#import "Frame_Menu.h"
#import "MenuTableViewCell.h"
#import "DbManager.h"
#import "Search_Object.h"
#import "KGModal.h"

@interface NavTableViewController () <UIAlertViewDelegate>
@property(strong,nonatomic)NSArray *menu;
@property(nonatomic,strong)NSArray *menuItems;
@property(strong,nonatomic)NSArray *nav_item;
@property(strong,nonatomic)NSArray *canal_item;
@property(strong,nonatomic)NSArray *nav_about;
//@property(strong,nonatomic)NSArray *favorite_item;
@property(strong,nonatomic)NSArray *section;
@property(strong,nonatomic)NSMutableArray *arr_nav_info;
@property (nonatomic, strong) DbManager *dbManager;

@property NSInteger max_menu;
@end


@implementation NavTableViewController

@synthesize nav_scroll;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [super viewDidLoad];
    self.dbManager = [[DbManager alloc] initWithDatabaseFilename:@"bisnisios.sql"];
    NSLog(@"NAV MODAR");
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.menu = [NSArray arrayWithObjects:@"Main",@"Second", nil];
    
    CGRect screen_rect =[[UIScreen mainScreen]bounds];
    CGFloat screen_width = screen_rect.size.width;
    [self.slidingViewController setAnchorRightRevealAmount:screen_width];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    [self load_db_nav];
    
    
    Frame_Menu *f1= [[Frame_Menu alloc]initWithNavId:@"0" p_nav_name:@"Home Page" p_nav_img:@"berita_terbaru.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *f2= [[Frame_Menu alloc]initWithNavId:@"allchannels" p_nav_name:@"All Channels" p_nav_img:@"headline.png" p_nav_position:2 p_nav_status:@"0"];
    Frame_Menu *f3= [[Frame_Menu alloc]initWithNavId:@"allfavorites" p_nav_name:@"All Favorite" p_nav_img:@"terpopuler.png" p_nav_position:3 p_nav_status:@"0"];
    Frame_Menu *f4= [[Frame_Menu alloc]initWithNavId:@"bookmarks" p_nav_name:@"Bookmarks" p_nav_img:@"unggulan.png" p_nav_position:4 p_nav_status:@"0"];
    
    Frame_Menu *c1= [[Frame_Menu alloc]initWithNavId:@"186" p_nav_name:@"Kabar24" p_nav_img:@"quick_news.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c2= [[Frame_Menu alloc]initWithNavId:@"194" p_nav_name:@"Market" p_nav_img:@"market.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c3= [[Frame_Menu alloc]initWithNavId:@"5" p_nav_name:@"Finansial" p_nav_img:@"finansial.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c4= [[Frame_Menu alloc]initWithNavId:@"43" p_nav_name:@"Industri" p_nav_img:@"industri.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c5= [[Frame_Menu alloc]initWithNavId:@"47" p_nav_name:@"Properti" p_nav_img:@"properti.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c19= [[Frame_Menu alloc]initWithNavId:@"382" p_nav_name:@"Jakarta" p_nav_img:@"jakarta_raya.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c8= [[Frame_Menu alloc]initWithNavId:@"57" p_nav_name:@"Sport" p_nav_img:@"sport.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c25= [[Frame_Menu alloc]initWithNavId:@"392" p_nav_name:@"Bola" p_nav_img:@"bola.png" p_nav_position:1 p_nav_status:@"0"];
    
    Frame_Menu *c14= [[Frame_Menu alloc]initWithNavId:@"197" p_nav_name:@"Life & Style" p_nav_img:@"lifestyle.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c13= [[Frame_Menu alloc]initWithNavId:@"222" p_nav_name:@"Traveling" p_nav_img:@"traveler.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c6= [[Frame_Menu alloc]initWithNavId:@"272" p_nav_name:@"Otomotif" p_nav_img:@"otomotif.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c7= [[Frame_Menu alloc]initWithNavId:@"277" p_nav_name:@"Gadget" p_nav_img:@"gadget.png" p_nav_position:1 p_nav_status:@"0"];
    
    
    // Frame_Menu *c9= [[Frame_Menu alloc]initWithNavId:@"227" p_nav_name:@"Showbiz" p_nav_img:@"showbiz.png" p_nav_position:1 p_nav_status:@"0"];
   // Frame_Menu *c11= [[Frame_Menu alloc]initWithNavId:@"242" p_nav_name:@"Koran Bisnis" p_nav_img:@"bisnis_indonesia.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c10= [[Frame_Menu alloc]initWithNavId:@"231" p_nav_name:@"Bisnis Syariah" p_nav_img:@"bisnis_syariah.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c12= [[Frame_Menu alloc]initWithNavId:@"52" p_nav_name:@"Manajemen" p_nav_img:@"manajemen.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c17= [[Frame_Menu alloc]initWithNavId:@"258" p_nav_name:@"Entrepreneur" p_nav_img:@"inspirasi_bisnis.png" p_nav_position:1 p_nav_status:@"0"];
    
    
    //Frame_Menu *c15= [[Frame_Menu alloc]initWithNavId:@"212" p_nav_name:@"Pemilu" p_nav_img:@"pemilu.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c16= [[Frame_Menu alloc]initWithNavId:@"243" p_nav_name:@"Info" p_nav_img:@"indonesia_today.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c24= [[Frame_Menu alloc]initWithNavId:@"73" p_nav_name:@"Inforial" p_nav_img:@"inforial" p_nav_position:1 p_nav_status:@"0"];
    
    //Frame_Menu *c18= [[Frame_Menu alloc]initWithNavId:@"264" p_nav_name:@"Inspirasi Bisnis" p_nav_img:@"inspirasi_bisnis.png" p_nav_position:1 p_nav_status:@"0"];
    
    //Frame_Menu *c20= [[Frame_Menu alloc]initWithNavId:@"338" p_nav_name:@"Dari Redaksi" p_nav_img:@"dari_redaksi.png" p_nav_position:1 p_nav_status:@"0"];
    //Frame_Menu *c21= [[Frame_Menu alloc]initWithNavId:@"285" p_nav_name:@"Aspirasi Anda" p_nav_img:@"aspirasi_anda.png" p_nav_position:1 p_nav_status:@"0"];
    //Frame_Menu *c22= [[Frame_Menu alloc]initWithNavId:@"390" p_nav_name:@"Rhamadhan" p_nav_img:@"ramadan.png" p_nav_position:1 p_nav_status:@"0"];
    //Frame_Menu *c23= [[Frame_Menu alloc]initWithNavId:@"269" p_nav_name:@"Kolom" p_nav_img:@"kolom.png" p_nav_position:1 p_nav_status:@"0"];
    
    
    Frame_Menu *a1= [[Frame_Menu alloc]initWithNavId:@"0" p_nav_name:@"About" p_nav_img:@"ic_menu_info_details.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *a2= [[Frame_Menu alloc]initWithNavId:@"0" p_nav_name:@"Setting" p_nav_img:@"ic_action_settings.png" p_nav_position:1 p_nav_status:@"0"];
    
    
    _menuItems = @[@"menu_search", @"section_front", @"menu_front", @"section_favorite", @"menu_favorite", @"section_canal",@"menu_canal",@"section_other", @"menu_about",@"menu_setting"];
    
    self.nav_item = [NSArray arrayWithObjects:f1,f2,f3,f4, nil];
    // self.favorite_item = [NSArray arrayWithObjects:f4,f5,f6,f7, nil];
    
    // self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24, nil];
    
    //self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c19,c8,c25,c14,c13,c6,c7,c11,c10,c12,c17,c16,c24, nil];
    self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c19,c8,c25,c14,c13,c6,c7,c10,c12,c17,c16,c24, nil];

    self.nav_about = [NSArray arrayWithObjects:a1,a2, nil];
    //
    self.section =[NSArray arrayWithObjects:self.nav_item,self.canal_item, nil];
    

    
    
    
    self.nav_scroll.delegate=(id)self;
    
    
   
    
    self.grid_front.delegate=(id)self;
    self.grid_front.dataSource=self;
    self.grid_favorite.delegate=(id)self;
    self.grid_favorite.dataSource=self;
    self.grid_channels.delegate=(id)self;
    self.grid_channels.dataSource=self;
    self.grid_about.delegate=(id)self;
    self.grid_about.dataSource=self;
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;

    self.grid_channels.frame= CGRectMake(0, 231, self.view.frame.size.width,55* ([self.canal_item count]/2));
    
    
    self.menu_channels.frame=CGRectMake(0, self.grid_channels.frame.origin.y+self.grid_channels.frame.size.height, self.menu_channels.frame.size.width, self.menu_channels.frame.size.height);
    
    self.grid_favorite.frame=CGRectMake(0, self.menu_channels.frame.origin.y+self.menu_channels.frame.size.height, self.grid_channels.frame.size.width, 55*round([self.arr_nav_info count]/2.0f));
    
    self.menu_other.frame=CGRectMake(0, self.grid_favorite.frame.origin.y+self.grid_favorite.frame.size.height, self.menu_other.frame.size.width, self.menu_other.frame.size.height);
    
    self.grid_about.frame=CGRectMake(0, self.menu_other.frame.origin.y+self.menu_other.frame.size.height, self.grid_about.frame.size.width, 55);
    
    
     [self.nav_scroll setContentSize:(CGSizeMake(self.view.frame.size.width,6*45+self.grid_channels.frame.size.height+self.grid_favorite.frame.size.height+self.grid_front.frame.size.height))];
    
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


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    NSLog(@"collectionView %@",collectionView.description);
    
    
    if([collectionView.description isEqualToString:self.grid_front.description]){
    
        return [self.nav_item count];
    }else if([collectionView.description isEqualToString:self.grid_favorite.description]){
    
        return [self.arr_nav_info count];
    }else if([collectionView.description isEqualToString:self.grid_channels.description])
    {
        return [self.canal_item count];
    }
    
    return 2;
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if([collectionView.description isEqualToString:self.grid_front.description]){
        
        Frame_Menu *menu_data = [self.nav_item objectAtIndex:indexPath.row];
    
        UIImageView *img_menu = (UIImageView *)[cell viewWithTag:100];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:200];
        
        
        
        
        [nameLabel setText:menu_data.nav_name];
        img_menu.image=[UIImage imageNamed:menu_data.nav_img];
        
  
    }else if([collectionView.description isEqualToString:self.grid_favorite.description]){
        
        UIImageView *img_menu = (UIImageView *)[cell viewWithTag:100];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:200];
        
        [nameLabel setText:[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_name"]]];
        img_menu.image=[UIImage imageNamed:[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_img"]]];
        // NSLog(@"%i",[self.arr_nav_info count]);
        //   NSLog(@"%@",[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_id"]]);
 
        
    }else if([collectionView.description isEqualToString:self.grid_channels.description])
    {
        
        Frame_Menu *menu_data = [self.canal_item objectAtIndex:indexPath.row];
        
        UIImageView *img_menu = (UIImageView *)[cell viewWithTag:100];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:200];

        [nameLabel setText:menu_data.nav_name];
        img_menu.image=[UIImage imageNamed:menu_data.nav_img];

       
    }else if([collectionView.description isEqualToString:self.grid_about.description]){
        
        Frame_Menu *menu_data = [self.nav_about objectAtIndex:indexPath.row];
        
        UIImageView *img_menu = (UIImageView *)[cell viewWithTag:100];
        UILabel *nameLabel = (UILabel *)[cell viewWithTag:200];
        
        [nameLabel setText:menu_data.nav_name];
        img_menu.image=[UIImage imageNamed:menu_data.nav_img];

    }

    
    
    return cell;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //  Frame_Menu *menu_data = [self.menu2 objectAtIndex:indexPath.row];
    NSString *indetifer = @"Main";
    //    NSLog(@"%@",indetifer);
    
    Frame_Menu *menu_data;
   // [[Search_Object Share_Manager]setSearch_select:-1];
    
    if([collectionView.description isEqualToString:self.grid_front.description]){
        // menu front
        menu_data = [self.nav_item objectAtIndex:indexPath.row];
        [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"%@",menu_data.nav_name]];
        [[Canal_Object Share_Manager]setCanal_active_id:[NSString stringWithFormat:@"%@",menu_data.nav_id]];
        
        if(indexPath.row==0){
                [[Canal_Object Share_Manager]setTabs_old:@"frontpage"];
        }else if(indexPath.row==1){
                [[Canal_Object Share_Manager]setTabs_old:@"allchannels"];
        } else if(indexPath.row==2){
                [[Canal_Object Share_Manager]setTabs_old:@"allfavorites"];
            
        }else
        if(indexPath.row==3){
            //bookmark
            [[Canal_Object Share_Manager]setTabs_old:@"Bookmark"];
            [[Canal_Object Share_Manager]setCanal_old:@"bookmark"];
            indetifer =@"bookmark";
            [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"Bookmark"]];
        }
        
        
    }else if([collectionView.description isEqualToString:self.grid_favorite.description]){
        
        NSLog(@" SELECTED grid_favorite %i",indexPath.row );
       [[Canal_Object Share_Manager]setTabs_old:@"MainOld"];
        indetifer =@"MainOld";
        [[Canal_Object Share_Manager]setCanal_active:[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_name"]]];
        
        [[Canal_Object Share_Manager]setCanal_active_id:[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_id"]]];
        
    
    
    }else if([collectionView.description isEqualToString:self.grid_channels.description]){
        [[Canal_Object Share_Manager]setTabs_old:@"MainOld"];
        
        NSLog(@" SELECTED %i",indexPath.row );
        indetifer =@"MainOld";
        menu_data = [self.canal_item objectAtIndex:(indexPath.row)];
        [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"%@",menu_data.nav_name]];
        [[Canal_Object Share_Manager]setCanal_active_id:[NSString stringWithFormat:@"%@",menu_data.nav_id]];
        
        
    }else{
        if(indexPath.row==0){
            [self about];
        }else{
           indetifer =@"setting";
        }
    }
    
    
    
    if(![collectionView.description isEqualToString:self.grid_about.description]|[indetifer isEqualToString:@"setting"]){
        UIViewController *newTopViewController =[self.storyboard instantiateViewControllerWithIdentifier:indetifer];
        // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
        
        // Configure the cell...
        
        if(![collectionView.description isEqualToString:self.grid_front.description]){
            self.slidingViewController.topViewController = newTopViewController;

        }else if([collectionView.description isEqualToString:self.grid_front.description]){
            if(indexPath.row!=2){
            self.slidingViewController.topViewController = newTopViewController;
            }else{
                if([self.arr_nav_info count]!=0){
                    self.slidingViewController.topViewController = newTopViewController;
                }else{
                 [self no_favorite];
                }
            }
        }

    }
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
    

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    

}
-(IBAction)action_search:(id)sender{
    //search
    [[Canal_Object Share_Manager]setTabs_old:[NSString stringWithFormat:@"Search"]];

    UIViewController *newTopViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
        
    }];
}
-(IBAction)action_favorite:(id)sender{

    [self load_db_nav];
    UIViewController *newTopViewController =[self.storyboard instantiateViewControllerWithIdentifier:@"favorite"];
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];

    
}


-(void)no_favorite{
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 50, 50);
    infoLabelRect.origin.y = 10;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = CGRectGetMaxY(infoLabelRect);
    welcomeLabelRect.size.height = 75;
    
    UIFont *welcomeLabelFont =  [UIFont  fontWithName:@"Open Sans" size:18];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"ANDA BELUM MEMILIH FAVORITE CHANNELS";
    welcomeLabel.numberOfLines = 0;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    welcomeLabel.font = welcomeLabelFont;
    [contentView addSubview:welcomeLabel];
    
    
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES ];
}


-(void)about{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 50, 50);
    infoLabelRect.origin.y = 10;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    UIImageView *img_logo = [[UIImageView alloc] initWithFrame:infoLabelRect];
    img_logo.image = [UIImage imageNamed:@"ikon_bi"];
    
    [contentView addSubview:img_logo];
    
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = CGRectGetMaxY(infoLabelRect);
    welcomeLabelRect.size.height = 75;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:12];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Bisnis.com \n Version 2.2.1 Copyright \u00A9  2014 Bisnis Indonesia Group \n All right reserved";
    welcomeLabel.numberOfLines = 0;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    welcomeLabel.font = welcomeLabelFont;
    [contentView addSubview:welcomeLabel];
    
    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+75;
    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(infoLabelRect.origin.x-50, btnY, infoLabelRect.size.width+100, btnH);
    [btn setTitle:@"Powered by Sibertama" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
    [contentView addSubview:btn];
    
    
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}


- (void)changeCloseButtonType:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://sibertama.com"]];
}


-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    //1. Setup the CATransform3D structure
    CATransform3D rotation;
    rotation = CATransform3DMakeRotation( 0, 0.0, 0.7, 0.4);
    rotation.m34 = 1.0/ -600;
    
    
    //2. Define the initial state (Before the animation)
    view.layer.shadowColor = [[UIColor blackColor]CGColor];
    view.layer.shadowOffset = CGSizeMake(10, 10);
    view.alpha = 0;
    
    view.layer.transform = rotation;
    view.layer.anchorPoint = CGPointMake(0, 0.5);
    
    //!!!FIX for issue #1 Cell position wrong------------
    //if(view.layer.position.x != 0){
    //    cell.layer.position = CGPointMake(0, cell.layer.position.y);
    //}
    
    //4. Define the final state (After the animation) and commit the animation
    [UIView beginAnimations:@"rotation" context:NULL];
    [UIView setAnimationDuration:0.8];
    view.layer.transform = CATransform3DIdentity;
    view.alpha = 1;
    view.layer.shadowOffset = CGSizeMake(0, 0);
    [UIView commitAnimations];

}


@end
