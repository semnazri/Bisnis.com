//
//  FavoriteViewController.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "FavoriteViewController.h"
#import "ECSlidingViewController.h"
#import "MenuTableViewController.h"
#import "Frame_Menu.h"
#import "FavoriteTableViewCell.h"
#import "DbManager.h"

@interface FavoriteViewController ()
@property(strong,nonatomic)NSArray *favorite_item;
@property (nonatomic, strong) DbManager *dbManager;
@property (nonatomic, strong) NSMutableArray *arr_nav_info;
@end

@implementation FavoriteViewController
@synthesize table_favorite=_table_favorite;

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
    // Do any additional setup after loading the view.
    self.dbManager = [[DbManager alloc] initWithDatabaseFilename:@"bisnisios.sql"];
    
  
    //Data Table
    self.table_favorite.delegate=(id)self;
    self.table_favorite.dataSource=self;
    //data-table
    self.cell_biru.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_biru.png"]];
    self.cell_kuning.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_kuning.png"]];
    
   
    
    Frame_Menu *c1= [[Frame_Menu alloc]initWithNavId:@"186" p_nav_name:@"Kabar24" p_nav_img:@"quick_news.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c2= [[Frame_Menu alloc]initWithNavId:@"194" p_nav_name:@"Market" p_nav_img:@"market.png" p_nav_position:2 p_nav_status:@"0"];
    Frame_Menu *c3= [[Frame_Menu alloc]initWithNavId:@"5" p_nav_name:@"Finansial" p_nav_img:@"finansial.png" p_nav_position:3 p_nav_status:@"0"];
    Frame_Menu *c4= [[Frame_Menu alloc]initWithNavId:@"43" p_nav_name:@"Industri" p_nav_img:@"industri.png" p_nav_position:4 p_nav_status:@"0"];
    Frame_Menu *c5= [[Frame_Menu alloc]initWithNavId:@"47" p_nav_name:@"Properti" p_nav_img:@"properti.png" p_nav_position:5 p_nav_status:@"0"];
    Frame_Menu *c19= [[Frame_Menu alloc]initWithNavId:@"382" p_nav_name:@"Jakarta" p_nav_img:@"jakarta_raya.png" p_nav_position:6 p_nav_status:@"0"];
    Frame_Menu *c8= [[Frame_Menu alloc]initWithNavId:@"57" p_nav_name:@"Sport" p_nav_img:@"sport.png" p_nav_position:7 p_nav_status:@"0"];
    Frame_Menu *c25= [[Frame_Menu alloc]initWithNavId:@"392" p_nav_name:@"Bola" p_nav_img:@"bola.png" p_nav_position:8 p_nav_status:@"0"];
    
    Frame_Menu *c14= [[Frame_Menu alloc]initWithNavId:@"197" p_nav_name:@"Life & Style" p_nav_img:@"lifestyle.png" p_nav_position:9 p_nav_status:@"0"];
    Frame_Menu *c13= [[Frame_Menu alloc]initWithNavId:@"222" p_nav_name:@"Traveling" p_nav_img:@"traveler.png" p_nav_position:10 p_nav_status:@"0"];
    Frame_Menu *c6= [[Frame_Menu alloc]initWithNavId:@"272" p_nav_name:@"Otomotif" p_nav_img:@"otomotif.png" p_nav_position:11 p_nav_status:@"0"];
    Frame_Menu *c7= [[Frame_Menu alloc]initWithNavId:@"277" p_nav_name:@"Gadget" p_nav_img:@"gadget.png" p_nav_position:12 p_nav_status:@"0"];
    
    
    // Frame_Menu *c9= [[Frame_Menu alloc]initWithNavId:@"227" p_nav_name:@"Showbiz" p_nav_img:@"showbiz.png" p_nav_position:1 p_nav_status:@"0"];
    Frame_Menu *c11= [[Frame_Menu alloc]initWithNavId:@"242" p_nav_name:@"Koran Bisnis" p_nav_img:@"bisnis_indonesia.png" p_nav_position:13 p_nav_status:@"0"];
    Frame_Menu *c10= [[Frame_Menu alloc]initWithNavId:@"231" p_nav_name:@"Bisnis Syariah" p_nav_img:@"bisnis_syariah.png" p_nav_position:14 p_nav_status:@"0"];
    Frame_Menu *c12= [[Frame_Menu alloc]initWithNavId:@"52" p_nav_name:@"Manajemen" p_nav_img:@"manajemen.png" p_nav_position:15 p_nav_status:@"0"];
    Frame_Menu *c17= [[Frame_Menu alloc]initWithNavId:@"258" p_nav_name:@"Entrepreneur" p_nav_img:@"inspirasi_bisnis.png" p_nav_position:16 p_nav_status:@"0"];
    
    
    //Frame_Menu *c15= [[Frame_Menu alloc]initWithNavId:@"212" p_nav_name:@"Pemilu" p_nav_img:@"pemilu.png" p_nav_position:16 p_nav_status:@"0"];
    Frame_Menu *c16= [[Frame_Menu alloc]initWithNavId:@"243" p_nav_name:@"Info" p_nav_img:@"indonesia_today.png" p_nav_position:17 p_nav_status:@"0"];
    Frame_Menu *c24= [[Frame_Menu alloc]initWithNavId:@"73" p_nav_name:@"Inforial" p_nav_img:@"inforial" p_nav_position:18 p_nav_status:@"0"];
    
    //Frame_Menu *c18= [[Frame_Menu alloc]initWithNavId:@"264" p_nav_name:@"Inspirasi Bisnis" p_nav_img:@"inspirasi_bisnis.png" p_nav_position:1 p_nav_status:@"0"];

    //Frame_Menu *c20= [[Frame_Menu alloc]initWithNavId:@"338" p_nav_name:@"Dari Redaksi" p_nav_img:@"dari_redaksi.png" p_nav_position:1 p_nav_status:@"0"];
    //Frame_Menu *c21= [[Frame_Menu alloc]initWithNavId:@"285" p_nav_name:@"Aspirasi Anda" p_nav_img:@"aspirasi_anda.png" p_nav_position:1 p_nav_status:@"0"];
    //Frame_Menu *c22= [[Frame_Menu alloc]initWithNavId:@"390" p_nav_name:@"Rhamadhan" p_nav_img:@"ramadan.png" p_nav_position:1 p_nav_status:@"0"];
    //Frame_Menu *c23= [[Frame_Menu alloc]initWithNavId:@"269" p_nav_name:@"Kolom" p_nav_img:@"kolom.png" p_nav_position:1 p_nav_status:@"0"];
    
    
    self.favorite_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c19,c8,c25,c14,c13,c6,c7,c11,c10,c12,c17,c16,c24, nil];

 //   self.favorite_item = [NSArray arrayWithObjects:c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,c17,c18,c19,c20,c21,c22,c23,c24, nil];
  //  self.arr_nav_info = [NSMutableArray arrayWithObjects:nil];
    [self load_db_nav];
    if([self.arr_nav_info count]!=[self.favorite_item count]){
        NSString *query2= [NSString stringWithFormat:@"delete from nav_info"];
        NSLog(@"Delete Info");
        // Pop the view controller.
        [self.dbManager executeQuery:query2];
         NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        for (int a=0; a<[self.favorite_item count]; a++) {
            Frame_Menu *q1 = [self.favorite_item objectAtIndex:a];
            NSString *query= [NSString stringWithFormat:@"insert into nav_info values(%@,'%@','%@',%i,'%@')",q1.nav_id,q1.nav_name,q1.nav_img,q1.nav_position,q1.nav_status];
            NSLog(@"nav %@",q1.nav_name);
            
            // Pop the view controller.
            [self.dbManager executeQuery:query];
        }
    [self load_db_nav];
    }


}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Frame_Menu *q1 = [self.favorite_item objectAtIndex:indexPath.row ];
    FavoriteTableViewCell *cell2 = (FavoriteTableViewCell *)[self.table_favorite cellForRowAtIndexPath:indexPath];
    NSString *query ;//
     //query= [NSString stringWithFormat:@"insert into nav_info values(%@,'%@','%@',%i,'%@')",q1.nav_id,q1.nav_name,q1.nav_img,q1.nav_position,q1.nav_status];
    if(cell2.favorite_status.on){
     query= [NSString stringWithFormat:@"update nav_info set nav_status=0 where nav_id=%@",q1.nav_id];
        [cell2.favorite_status setOn:NO];
    }else{
    query = [NSString stringWithFormat:@"update nav_info set nav_status=1 where nav_id=%@",q1.nav_id];
        [cell2.favorite_status setOn:YES];
    }

   // NSLog(@"%@",query);
    
   // NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(1, 'model', 'home', 'oke')"];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.

        
    [self.navigationController popViewControllerAnimated:YES];
  

    [self load_db_nav];
}
-(void)load_db_nav{
    NSString *query = @"select * from nav_info order by nav_position";
    
    // Get the results.
    if (self.arr_nav_info != nil) {
        self.arr_nav_info = nil;
    }
    self.arr_nav_info = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
  //  NSLog(@"woke %@",self.arr_nav_info);

}

-(IBAction)select_db:(id)sender{
    NSString *query = @"select * from nav_info order by nav_position";
  //  NSString *query = @"delete from nav_info";
    
    // Get the results.
    if (self.arr_nav_info != nil) {
        self.arr_nav_info = nil;
    }
    self.arr_nav_info = [[NSMutableArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    
    NSLog(@"woke %@",self.arr_nav_info);

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)revealMenu:(id)sender{
    [self.slidingViewController anchorTopViewTo:ECRight];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    if([self.arr_nav_info count]==0){
      
        //self.arr_nav_info = [NSMutableArray arrayWithArray:self.arr_nav_info];
    }
    return [self.favorite_item count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    FavoriteTableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"menu_favorite" forIndexPath:indexPath];
  //  Frame_Menu *menu_data = [self.favorite_item objectAtIndex:indexPath.row ];
      // cell2.favorite_name.text = menu_data.nav_name;
    

    
   cell2.favorite_name.text = [[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_name"]];
//    
//   // NSLog(@"%i",[self.arr_nav_info count]);
// //   NSLog(@"%@",[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_id"]]);
    cell2.favorite_img.image = [UIImage imageNamed:[[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_img"]]];
    NSString *status = [[self.arr_nav_info objectAtIndex:indexPath.row]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"nav_status"]];
    NSLog(@"Status %@",status);
    if([status isEqualToString:@"0"])
    {
          [cell2.favorite_status setOn:NO];
 
    }else{
          [cell2.favorite_status setOn:YES];
    }
    
  
    return cell2;
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
