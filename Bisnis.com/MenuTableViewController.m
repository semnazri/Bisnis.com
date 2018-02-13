//
//  MenuTableViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/23/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "MenuTableViewController.h"
#import "ECSlidingViewController.h"
#import "MenuTableViewCell.h"
#import "MainViewController.h"
#import "Canal_Object.h"
#import "Frame_Menu.h"
#import "MenuTableViewCell.h"
#import "DbManager.h"
#import "Search_Object.h"
#import "KGModal.h"

@interface MenuTableViewController ()<UIAlertViewDelegate>
@property(strong,nonatomic)NSArray *menu;
@property(nonatomic,strong)NSArray *menuItems;
@property(strong,nonatomic)NSArray *nav_item;
@property(strong,nonatomic)NSArray *canal_item;
//@property(strong,nonatomic)NSArray *favorite_item;
@property(strong,nonatomic)NSArray *section;
@property(strong,nonatomic)NSMutableArray *arr_nav_info;
@property (nonatomic, strong) DbManager *dbManager;

@property NSInteger max_menu;
@end

@implementation MenuTableViewController
@synthesize menu;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dbManager = [[DbManager alloc] initWithDatabaseFilename:@"bisnisios.sql"];
    NSLog(@"NAV MODAR");
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.menu = [NSArray arrayWithObjects:@"Main",@"Second", nil];
    
    CGRect screen_rect =[[UIScreen mainScreen]bounds];
    CGFloat screen_width = screen_rect.size.width;
    [self.slidingViewController setAnchorRightRevealAmount:screen_width*0.8];
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
  //  Frame_Menu *c11= [[Frame_Menu alloc]initWithNavId:@"242" p_nav_name:@"Koran Bisnis" p_nav_img:@"bisnis_indonesia.png" p_nav_position:1 p_nav_status:@"0"];
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

    
    
    
    _menuItems = @[@"menu_search", @"section_front", @"menu_front", @"section_favorite", @"menu_favorite", @"section_canal",@"menu_canal",@"section_other", @"menu_about",@"menu_setting"];
    
    self.nav_item = [NSArray arrayWithObjects:f1,f2,f3,f4, nil];
    // self.favorite_item = [NSArray arrayWithObjects:f4,f5,f6,f7, nil];
    
   // self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24, nil];
    
   // self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c19,c8,c25,c14,c13,c6,c7,c11,c10,c12,c17,c16,c24, nil];
    self.canal_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c19,c8,c25,c14,c13,c6,c7,c10,c12,c17,c16,c24, nil];
    //
    self.section =[NSArray arrayWithObjects:self.nav_item,self.canal_item, nil];
    
    
    
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    self.max_menu =[self.nav_item count]+[self.arr_nav_info count]+[self.canal_item count]+7;
    return [self.nav_item count]+[self.arr_nav_info count]+[self.canal_item count]+7;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell ;
    NSString *CellIdentifier ;
    if(indexPath.row==0){
        CellIdentifier = @"menu_search";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_nav.png"]];
        return cell;
    }else if(indexPath.row==1){
        CellIdentifier = @"section_front";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_label.png"]];
        return cell;
    }else if(indexPath.row<6){
        CellIdentifier = @"menu_front";
        MenuTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        Frame_Menu *menu_data = [self.nav_item objectAtIndex:indexPath.row -2];
        cell2.menu_name.text =  menu_data.nav_name;
        cell2.img_menu.image = [UIImage imageNamed:menu_data.nav_img];
        //cell2.backgroundColor = [self colorWithHexString:@"1f2638"];
        cell2.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_nav.png"]];
        return cell2;
    }else if(indexPath.row==6){
        CellIdentifier = @"section_favorite";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_label.png"]];
        return cell;
    } else if(indexPath.row>6&&indexPath.row<=6+[self.arr_nav_info count]){
        CellIdentifier = @"menu_favorite";
        MenuTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell2.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_nav.png"]];
        //  Frame_Menu *menu_data = [self.arr_nav_info objectAtIndex:indexPath.row - 10];
        // cell2.menu_name.text =  menu_data.nav_name;
        //  cell2.img_menu.image = [UIImage imageNamed:menu_data.nav_img];
        
        cell2.menu_name.text = [[self.arr_nav_info objectAtIndex:indexPath.row - 7]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_name"]];
        
        // NSLog(@"%i",[self.arr_nav_info count]);
        //   NSLog(@"%@",[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_id"]]);
        cell2.img_menu.image = [UIImage imageNamed:[[self.arr_nav_info objectAtIndex:indexPath.row - 7]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_img"]]];
        
        return cell2;
        
    }else if(indexPath.row==7+[self.arr_nav_info count]){
        CellIdentifier = @"section_canal";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_label.png"]];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.userInteractionEnabled = NO;
        return cell;
    }else if(indexPath.row>7+[self.arr_nav_info count]&&indexPath.row<self.max_menu-3){
        CellIdentifier = @"menu_canal";
        MenuTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        Frame_Menu *menu_data = [self.canal_item objectAtIndex:indexPath.row - 8- [self.arr_nav_info count]];
        cell2.menu_name.text =  menu_data.nav_name;
        cell2.img_menu.image = [UIImage imageNamed:menu_data.nav_img];
        cell2.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_nav.png"]];
        return cell2;
        
    }else if(self.max_menu-3==indexPath.row){
        CellIdentifier = @"section_other";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_label.png"]];
        cell.userInteractionEnabled = NO;
        return cell;
    }else if (self.max_menu-2==indexPath.row){
        CellIdentifier = @"menu_about";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_nav.png"]];
        // cell.backgroundColor = [self colorWithHexString:@"1f2638"];
        return cell;
    }
    else{
        CellIdentifier = @"menu_setting";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_nav.png"]];
        //cell.backgroundColor = [self colorWithHexString:@"1f2638"];
        return cell;
    }
    
    
    
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //  Frame_Menu *menu_data = [self.menu2 objectAtIndex:indexPath.row];
    NSString *indetifer = @"Main";
    //    NSLog(@"%@",indetifer);
    
    Frame_Menu *menu_data;
    [[Search_Object Share_Manager]setSearch_select:-1];
    
    // [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"%@",menu_data.nav_name]];
    if(indexPath.row==0){
        //search
        [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"Search"]];
        indetifer =@"search";
    }else if(indexPath.row==1){
        // front page
        
    }else if(indexPath.row==5){
        //bookmark
        indetifer =@"bookmark";
        [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"Bookmark"]];
    }
    else if(indexPath.row<6){
        // menu front
        menu_data = [self.nav_item objectAtIndex:indexPath.row-2];
        [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"%@",menu_data.nav_name]];
        [[Canal_Object Share_Manager]setCanal_active_id:[NSString stringWithFormat:@"%@",menu_data.nav_id]];
    }
    else if(indexPath.row==6){
        //favorite
        indetifer =@"favorite";
        [self load_db_nav];
    } else if(indexPath.row>6&&indexPath.row<=6+[self.arr_nav_info count]){
        //menu favorite
        // menu_data = [self.arr_nav_info objectAtIndex:indexPath.row-10];
                indetifer =@"MainOld";
        [[Canal_Object Share_Manager]setCanal_active:[[self.arr_nav_info objectAtIndex:indexPath.row - 7]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_name"]]];
        
        [[Canal_Object Share_Manager]setCanal_active_id:[[self.arr_nav_info objectAtIndex:indexPath.row - 7]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_id"]]];
    }else if(indexPath.row==7+[self.arr_nav_info count]){
        //canal
    }else if(indexPath.row>7+[self.arr_nav_info count]&&indexPath.row<self.max_menu-3){
        // menu canal
        // NSLog(@"wodel %i",(indexPath.row-11-[self.arr_nav_info count]));
        indetifer =@"MainOld";
        menu_data = [self.canal_item objectAtIndex:(indexPath.row-8-[self.arr_nav_info count])];
        [[Canal_Object Share_Manager]setCanal_active:[NSString stringWithFormat:@"%@",menu_data.nav_name]];
        [[Canal_Object Share_Manager]setCanal_active_id:[NSString stringWithFormat:@"%@",menu_data.nav_id]];
    }else if(self.max_menu-3==indexPath.row){
        // other
    }else if (self.max_menu-2==indexPath.row){
        //menu obout
        //indetifer =@"about";
        [self about];
    }
    else{
        //menu setting
        indetifer =@"setting";}
    
    
    UIViewController *newTopViewController =[self.storyboard instantiateViewControllerWithIdentifier:indetifer];
    // UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
        
    }];
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
    welcomeLabel.text = @"Bisins.com \n Version 1.0.0 Copyright \u00A9  2014 Bisnis Indonesia Group \n All right reserved";
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

- (void)willShow:(NSNotification *)notification{
    NSLog(@"will show");
}

- (void)didShow:(NSNotification *)notification{
    NSLog(@"did show");
}

- (void)willHide:(NSNotification *)notification{
    NSLog(@"will hide");
}

- (void)didHide:(NSNotification *)notification{
    NSLog(@"did hide");
}

- (void)changeCloseButtonType:(id)sender{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://sibertama.com"]];
}



/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

@end
