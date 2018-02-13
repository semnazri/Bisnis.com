//
//  PagerDataViewController.m
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/18/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "PagerDataViewController.h"
#import "Detail_Object.h"
#import "Frame_Berita.h"
#import <Social/Social.h>
#import "DbManager.h"
#import "KGModal.h"
#import "SearchTableViewCell.h"
#import "Terkait_Object.h"
#import "BisnisViewController.h"
#import "LiveViewController.h"
#import "LinkWebViewController.h"
#import "PagerRootViewControllerTerkait.h"


#import <GoogleOpenSource/GoogleOpenSource.h>
#import <GooglePlus/GooglePlus.h>
#import <QuartzCore/QuartzCore.h>
#import <MobileCoreServices/MobileCoreServices.h>

#define url_detail  @"http://services.bisnis.com/newjson/detailios/"
#define url_terkait  @"http://services.bisnis.com/newjson/detailterkaitios/"
#define url_contoh @"http://api.kivaws.org/v1/loans/newest.json"


@interface PagerDataViewController ()<GPPShareDelegate,GPPSignInDelegate>
{
    NSMutableArray *loans;
    NSString *url_berita;
    NSString *url_berita2;
    CGFloat originalFloatingViewY;
    CGFloat webViewHeight ;
    AAShareBubbles *shareBubbles;
    float radius;
    float bubbleRadius;
    NSString *HTML;
    NSString *data_terkai;
    NSString *data_list_terkait;
    NSString *berita_terkait;
    NSString *css_terkait;
    NSString *link_share;
    NSString *link_title;
    NSString *link_next;
    NSString *link_previous;
    NSString *tgl_series;
    NSString *page_series;
    BOOL is_series;
}
@property (nonatomic, strong) DbManager *dbManager;
@property (nonatomic, strong) NSMutableArray *array_terkait;
@property (nonatomic,strong)UIFont *font_size_judul;
@property (nonatomic,strong)UIFont *font_size_tgl;
@property (nonatomic,strong)UIFont*font_size_canal;
@property (nonatomic,strong)NSString *link_web_commnet;
@property(nonatomic,strong)  Frame_Berita *b1;
@property(nonatomic,strong) NSString *css;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewHeightConstraint;
@property CGFloat tinggi_judul;
@property CGFloat first_height;
@property CGFloat frame_live;
@property BOOL first_series;
@property(nonatomic,strong)    GPPSignInButton *cobe;

@property (retain) UIDocumentInteractionController * documentInteractionController;

@end

@implementation PagerDataViewController
@synthesize scroller=_scroller,menu_btn,label_author,label_editor,label_img_caption,label_img_sumber,label_judul_detail,label_tgl_detail,web_detail,tabel_terkait,label_terkait,b1,css,view_head,tinggi_judul,first_height,frame_live,activityIndicator,cobe;
- (void)gppInit {
    
    [GPPShare sharedInstance].delegate = self;
    
    GPPSignIn *signIn = [GPPSignIn sharedInstance];
    signIn.shouldFetchGooglePlusUser = YES;
    signIn.shouldFetchGoogleUserEmail = YES;
    
    signIn.delegate = self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    [self gppInit];
    [[GPPSignIn sharedInstance] trySilentAuthentication];
    page_series=@"";
    self.img_live.hidden=YES;
    CGRect frame_hiden;
    is_series=YES;
    frame_hiden.size.height=0;
    self.cell_series.frame=frame_hiden;
    self.label_judul_series.frame=frame_hiden;
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        //self.tabel_action.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bates_action.png"]];
    }
    self.frame_live=10;
    
    
    
    self.dbManager = [[DbManager alloc] initWithDatabaseFilename:@"bisnisios.sql"];
    self.tabel_terkait.delegate=(id)self;
    self.tabel_terkait.dataSource=self;
    [self load_db_option];
    
    // Do any additional setup after loading the view.
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    self.navigationItem.leftBarButtonItem = nil;
    self.web_detail.delegate=(id)self;
    self.scroller.delegate=(id)self;
    originalFloatingViewY = self.scroller.frame.origin.y;
    
    //   [ self.web_detail setDataDetectorTypes:UIDataDetectorTypeNone];
    //self.menu_btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // ///menu_btn.frame = CGRectMake(108, 20, 100, 100);
    // [menu_btn setBackgroundImage:[UIImage imageNamed:@"logo.png"] forState:UIControlStateNormal];
    //  [menu_btn addTarget:self action:@selector(revealMenu:) forControlEvents:UIControlEventTouchUpInside];
    
    // [self.view addSubview:self.menu_btn];
    
    self.label_judul_detail.text=@"";
    self.label_author.text=@"";
    self.label_tgl_detail.text=@"";
    
    
    radius = 120;
    bubbleRadius = 30;
    
    
    
    cobe = [[GPPSignInButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    cobe.backgroundColor=[UIColor blackColor];
    cobe.hidden=YES;
    
    // [cobe ]
    
    [self.view addSubview:cobe];
    
    [self.web_detail clearsContextBeforeDrawing];
    
 
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.array_terkait count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Frame_Berita *data = [self.array_terkait objectAtIndex:indexPath.row];
    cell.label_tgl.text = data.Tgl_Berita;
    //cell.label_judul.font=self.font_size_tgl;
    cell.label_judul.text = data.Judul_Berita;
    // [cell.label_judul ]
    // [cell.label_judul sizeToFit];
    // cell.label_judul.font=self.font_size_canal;
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 50;
    } else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return 75;
    }
    return 50;
}

- (void)updateFloatingViewFrame {
    CGPoint contentOffset =  self.scroller.contentOffset;
    
    // The floating view should be at its original position or at top of
    // the visible area, whichever is lower.
    CGFloat y = MAX(contentOffset.y, originalFloatingViewY);
    
    CGRect frame =  self.scroller.frame;
    if (y != frame.origin.y) {
        frame.origin.y = y;
        //self.scroller.frame = frame;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.activityIndicator  = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.activityIndicator.color=[UIColor brownColor];
    self.activityIndicator.transform = CGAffineTransformMakeScale(1.2, 1.2);
    
    // Set Center Position for ActivityIndicator
    
    self.activityIndicator.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    
    // Add ActivityIndicator to your view
    
    [self.view addSubview:self.activityIndicator ];
    
    [self.activityIndicator startAnimating];
    NSArray *data= [[Detail_Object sharedManager]someDetail];
    self.dataLabel.text =[NSString stringWithFormat:@"%i / %lu",self.pagenumber+1,(unsigned long)[data count]];
    NSMutableAttributedString *s =
    [[NSMutableAttributedString alloc] initWithString:[self.dataLabel text]];
    
    [s addAttribute:NSBackgroundColorAttributeName
              value:[UIColor colorWithRed:238.0f/225.0f green:191.0f/255.0f blue:42.0f/255.0f alpha:1.0f]
              range:NSMakeRange(0, s.length)];
    
    self.dataLabel.attributedText =s;
    [[Detail_Object sharedManager]setSomeProperty:[NSString stringWithFormat:@"%i",self.pagenumber]];
    b1 =[data objectAtIndex:self.pagenumber];
    self.array_terkait = [NSMutableArray arrayWithObjects:nil];
    //  http://services.bisnis.com/json/detailios/20140924/7/259774/
    NSArray *foo = [b1.Tgl_Berita componentsSeparatedByString:@" "];
    // NSLog(@"Detail tgl %@",[foo[0] stringByReplacingOccurrencesOfString:@"-" withString:@""] );
    // NSLog(@"Detail categori %@",b1.Catagory);
    // NSLog(@"Detail post_id %i",b1.Id_Berita);
    
    
    tgl_series=[NSString stringWithFormat:@"%@%@/%@",url_detail,[foo[0] stringByReplacingOccurrencesOfString:@"-" withString:@""],b1.Catagory];
    
    url_berita = [NSString stringWithFormat:@"%@%@/%@/%li",url_detail,[foo[0] stringByReplacingOccurrencesOfString:@"-" withString:@""],b1.Catagory,b1.Id_Berita];
    url_berita2 = [NSString stringWithFormat:@"%@%@/%@/%li",url_terkait,[foo[0] stringByReplacingOccurrencesOfString:@"-" withString:@""],b1.Catagory,b1.Id_Berita];
    
    //url_berita = [NSString stringWithFormat:@"%@20141224/104/385690",url_detail];
    
  
    
    // NSLog(@"Detail post_id %@",url_berita);
    [self loaddetailterkait:url_berita2];
    
    self.screenName = [NSString stringWithFormat:@"apps/read/%@/%@/%ld/%@",[foo[0] stringByReplacingOccurrencesOfString:@"-" withString:@""],b1.Catagory,b1.Id_Berita,b1.Pukul];
}
-(IBAction)Bak_to:(id)sender{
    NSArray *array = [self.navigationController viewControllers];
    
    [self.navigationController popToViewController:[array objectAtIndex:2] animated:YES];
    //NSLog(@"MODEL %i",[array count]);
    
    // NSLog(@"%@",self.navigationController.topViewController);
    
}
-(IBAction)cmd_last:(id)sender{
    NSLog(@"LAST LAST");
    [self.cmd_old setTitleColor:[UIColor grayColor]  forState:UIControlStateNormal];
    [self.cmd_last setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cmd_last.backgroundColor = [UIColor orangeColor];
    self.cmd_old.backgroundColor = [UIColor lightGrayColor];
    [[Detail_Object sharedManager]setUrl_web:[NSString stringWithFormat:@"%@",b1.Judul_Berita]];
    
    LiveViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewControllerLive"];
    [self presentViewController:monitorMenuViewController animated:UIModalTransitionStyleFlipHorizontal completion:nil];
    
    
    
    // [self.navigationController.storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewController2"];
    
    //[self open_link:[NSURL URLWithString:@"http://services.bisnis.com/json/live/262843/latest/"]];
    // [self.web_live loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://services.bisnis.com/json/live/262843/latest/"]]];
    
    
}
-(IBAction)cmd_old:(id)sender{
    NSLog(@"OLD OLD");
    [self.cmd_last setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.cmd_old setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.cmd_last.backgroundColor = [UIColor lightGrayColor];
    self.cmd_old.backgroundColor = [UIColor orangeColor];
    [[Detail_Object sharedManager]setUrl_web:[NSString stringWithFormat:@"http://services.bisnis.com/json/live/%li/oldnest",b1.Id_Berita]];
    LiveViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewControllerLive"];
    [self presentViewController:monitorMenuViewController animated:UIModalTransitionStyleFlipHorizontal completion:nil];
    
    // [self open_link:[NSURL URLWithString:@"http://services.bisnis.com/json/live/262843/oldnest/"]];
    // [self.web_live loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://services.bisnis.com/json/live/262843/oldnest/"]]];
    
}

#pragma mark AAShareBubbles

- (void)viewDidUnload {
    [super viewDidUnload];
}


//------------------------------------


-(void)aaShareBubbles:(AAShareBubbles *)shareBubbles tappedBubbleWithType:(AAShareBubbleType)bubbleType
{
    switch (bubbleType) {
        case AAShareBubbleTypeFacebook:
            //  NSLog(@"Facebook");
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [tweetSheet setInitialText:link_title];
                //                if (self.imageString)
                //                {
               // [tweetSheet addImage:self.img_detail.image];
                //                }
                //
                //                if (self.urlString)
                //                {
                [tweetSheet addURL:[NSURL URLWithString:link_share]];
                //                }
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"Sorry"
                                          message:@"You can't send a Shared right now, make sure your device has an internet connection and you have at least one Facebook account setup"
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
            break;
        case AAShareBubbleTypeTwitter:
            NSLog(@"Twitter");
            if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
            {
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:link_title];
                
                //                if (self.imageString)
                //                {
                [tweetSheet addImage:self.img_detail.image];
                //                }
                //
                //                if (self.urlString)
                //                {
                [tweetSheet addURL:[NSURL URLWithString:link_share]];
                //                }
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }
            else
            {
                UIAlertView *alertView = [[UIAlertView alloc]
                                          initWithTitle:@"Sorry"
                                          message:@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup"
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
                [alertView show];
            }
            
            break;
        case AAShareBubbleTypeGooglePlus:
        {
            
               NSLog(@" share gogoogle %@",link_title );
         
//            id<GPPShareBuilder> shareBuilder = [self shareBuilder];
//
//            [shareBuilder open];
            
            [cobe sendActionsForControlEvents:UIControlEventTouchUpInside];
            
            id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
            
            // This line will fill out the title, description, and thumbnail from
            // the URL that you are sharing and includes a link to that URL.
            [shareBuilder setURLToShare:[NSURL URLWithString:link_share]];
            
            [shareBuilder open];

            
            
            break;
            
        }
        
        case AAShareBubbleTypeWhatsapp:
        {
            NSString *msg = [NSString stringWithFormat:@"%@  |  %@",link_title,link_share];
            msg = [msg stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
            msg = [msg stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
            msg = [msg stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
            msg = [msg stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
            msg = [msg stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
            msg = [msg stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
            msg = [msg stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
            msg = [msg stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
            NSLog(@" share content %@",msg );
            
            /*
            if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"whatsapp://app"]]){
                
                UIImage     * iconImage = self.img_detail.image;
                NSString    * savePath  = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/whatsAppTmp.wai"];
                
                [UIImageJPEGRepresentation(iconImage, 1.0) writeToFile:savePath atomically:YES];
                
                _documentInteractionController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:savePath]];
                _documentInteractionController.UTI = @"net.whatsapp.image";
                _documentInteractionController.delegate = self;
                
                [_documentInteractionController presentOpenInMenuFromRect:CGRectMake(0, 0, 0, 0) inView:self.view animated: YES];
                
                
            } else {
                UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"WhatsApp not installed." message:@"Your device has no WhatsApp installed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
            
            */
            
            
            NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@",msg]];
            if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
                [[UIApplication sharedApplication] openURL: whatsappURL];
            }
//
            break;
        }
            

        default:
            break;
    }
    
    
    
    
}

-(void)aaShareBubblesDidHide {
    NSLog(@"All Bubbles hidden");
}


-(IBAction)cmd_share:(id)sender{
    //NSLog(@"shared ");
    if(shareBubbles) {
        shareBubbles = nil;
    }
    shareBubbles = [[AAShareBubbles alloc] initWithPoint:self.view.center radius:radius inView:self.view];
    shareBubbles.delegate = self;
    shareBubbles.bubbleRadius = bubbleRadius;
    shareBubbles.showFacebookBubble = YES;
    shareBubbles.showTwitterBubble = YES;
    shareBubbles.showGooglePlusBubble = NO;
    shareBubbles.showTumblrBubble = NO;
    shareBubbles.showVkBubble = NO;
    shareBubbles.showLinkedInBubble = NO;
    shareBubbles.showYoutubeBubble = NO;
    shareBubbles.showVimeoBubble = NO;
    shareBubbles.showRedditBubble = NO;
    shareBubbles.showPinterestBubble = NO;
    shareBubbles.showInstagramBubble = NO;
    shareBubbles.showWhatsappBubble = YES;
    [shareBubbles show];
    
}
-(IBAction)cmd_comment:(id)sender{
    NSLog(@"comment ");
}
-(IBAction)cmd_bookmark:(id)sender{
    NSLog(@"bookmark ");
      // [[GPPSignIn sharedInstance] signOut];
    Frame_Berita *b2 =[[[Detail_Object sharedManager]someDetail] objectAtIndex:self.pagenumber];
    
    //    Frame_Berita *b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"title"] p_tgl_berita:[loanDic objectForKey:@"post_date"] p_pukul:[NSString stringWithFormat:@"%@ %@ WIB" ,date,waktu] p_catagory:[loanDic objectForKey:@"category_id"]  p_datepost:[NSString stringWithFormat:@"%@ - %@",parent_category,sub_category] p_img_berita:[NSString stringWithFormat:@"%@?w=100",[loanDic objectForKey:@"image_uri"] ] p_image_content:[loanDic objectForKey:@"image_caption"]];
    //    [self.data_berita addObject:b2];
    
    //    post_id
    //    judul
    //    tgl_berita
    //    pukul
    //    category
    //    datepost
    //    img0berita
    //    imgc0ntent
    
    
    
    NSString *query= [NSString stringWithFormat:@"insert into bookmark values(%li,'%@','%@','%@','%@','%@','%@','%@')",b2.Id_Berita,b2.Judul_Berita,b2.Tgl_Berita,self.label_tgl_detail.text,b2.Catagory,b2.Datepost,b2.Img_Berita,b2.Img_Content];
    [self alert_save];
    //NSString *query = @"delete from bookmark";
    //  NSLog(@"%@",query);
    
    // NSString *query = [NSString stringWithFormat:@"insert into peopleInfo values(1, 'model', 'home', 'oke')"];
    
    // Execute the query.
    [self.dbManager executeQuery:query];
    
    // If the query was successfully executed then pop the view controller.
    if (self.dbManager.affectedRows != 0) {
        //NSLog(@"Query was executed successfully. Affected rows = %d", self.dbManager.affectedRows);
        
        // Pop the view controller.
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        NSLog(@"Could not execute the query.");
    }
    
    
}

-(void)loaddetailterkait:(NSString *)param{
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:param]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        if (!error) {
            NSArray *latestLoans = [self fetchDataterkait:data];
            
            
            if (latestLoans) {
                for (NSDictionary *loanDic in latestLoans) {
                    //  NSLog(@"%@",[loanDic objectForKey:@"post_title"]);
                    
                    Frame_Berita *b2 = [[Frame_Berita alloc] initWhitId_berita2:[[loanDic objectForKey:@"post_id"] integerValue]p_judul_berita:[loanDic objectForKey:@"post_title"] p_tgl_berita:[loanDic objectForKey:@"post_date"] p_pukul:[loanDic objectForKey:@"post_date"] p_catagory:[loanDic objectForKey:@"category_id"] p_datepost:[loanDic objectForKey:@"post_date"] p_img_berita:[NSString stringWithFormat:@"%@?w=150",[loanDic objectForKey:@"post_date"] ] p_image_content:[loanDic objectForKey:@"post_date"]];
                    //  Loan *loan = [[Loan alloc] init];
                    //loan.name = [loanDic objectForKey:@"name"];
                    //loan.amount = [loanDic objectForKey:@"loan_amount"];
                    //loan.use = [loanDic objectForKey:@"use"];
                    //loan.country = [[loanDic objectForKey:@"location"] objectForKey:@"country"];
                    //   NSLog(@"data judul %@",b2.Judul_Berita);
                    [self.array_terkait addObject:b2];
                }
            }
            [self.tabel_terkait reloadData];
            //    NSLog(@"data terkait %i",[self.array_terkait count]);
            [self loaddetail:url_berita];

        }
        
        
        // As this block of code is run in a background thread, we need to ensure the GUI
        // update is executed in the main thread
        //[self performSelectorOnMainThread:@selector(reloadDataterkait:) withObject:latestLoans waitUntilDone:NO];
        
    }
     
     ];
    
}

-(void)loaddetail:(NSString *)param{
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:param]] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        NSMutableDictionary *latestLoans;
        if (!error) {
            latestLoans = [self fetchData:data];
        }
        [self performSelectorOnMainThread:@selector(reloadData:) withObject:latestLoans waitUntilDone:NO];
        
    }
     
     ];
    
}
-(void)reloadData:(NSMutableDictionary *)data_detail
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        link_share=[NSString stringWithFormat:@"%@",[[data_detail objectForKey:@"category"] objectForKey:@"link"]];
        link_title=[NSString stringWithFormat:@"%@",[data_detail objectForKey:@"title"]];
    
        
        NSLog(@"%@",[[NSString stringWithFormat:@"%@",[[data_detail objectForKey:@"category"] objectForKey:@"link"]]substringFromIndex:7]);
        self.link_web_commnet=[[NSString stringWithFormat:@"%@",[[data_detail objectForKey:@"category"] objectForKey:@"link"]]substringFromIndex:7];
        
        
        if([[NSString stringWithFormat:@"%@",[data_detail objectForKey:@"is_live"]] integerValue]==0){
            self.img_live.hidden=YES;
            self.label_judul_detail.text=[NSString stringWithFormat:@"%@",[data_detail objectForKey:@"title"]];
            // [self.label_judul_detail sizeToFit];
            self.tabel_live.hidden=YES;
            self.frame_live=0;
        }else{
            //  cell.label_judul_berita.font=self.font_size_judul;
            self.img_live.hidden=NO;
            self.frame_live=20;
            
            
            //            self.img_live.layer.cornerRadius = 10;
            //            self.img_live .layer.shadowColor = [[UIColor blackColor] CGColor];
            //            self.img_live .layer.shadowOpacity = 1;
            //            self.img_live.layer.shadowRadius = 10;
            //            self.img_live.layer.shadowOffset = CGSizeMake(-2, 7);
            //            [self.img_live setBackgroundColor:[UIColor redColor]];
            
            
            //            self.tabel_live.layer.cornerRadius = 10;
            //            self.tabel_live .layer.shadowColor = [[UIColor blackColor] CGColor];
            //            self.tabel_live .layer.shadowOpacity = 1;
            //            self.tabel_live.layer.shadowRadius = 10;
            //            self.tabel_live.layer.shadowOffset = CGSizeMake(-2, 7);
            //            [self.tabel_live setBackgroundColor:[UIColor redColor]];
            
            [[Detail_Object sharedManager]setId_live:[data_detail objectForKey:@"post_id"]];
            self.label_judul_detail.text=[NSString stringWithFormat:@"         %@",[data_detail objectForKey:@"title"]];
        }
        
        if([[NSString stringWithFormat:@"%@",[data_detail objectForKey:@"is_series"]] integerValue]==1){
            is_series=YES;
        
            CGRect frame_hiden;
            frame_hiden.size.height=32;
            //frame_hiden.size.width=self.tabel_action.frame.size.width;
            //self.cell_series.frame=frame_hiden;
            self.cell_series.frame=CGRectMake(0, 1000, self.img_detail.frame.size.width,32);
            
            frame_hiden.origin.x=10;
          //  self.label_judul_series.frame=frame_hiden;
            self.label_judul_series.text=[NSString stringWithFormat:@"%@",[[data_detail objectForKey:@"series"] objectForKey:@"title"]];
           //  self.label_judul_series.text=@"HAHAHAH";
            self.label_judul_series.font=self.font_size_judul;
            self.label_series.text=[NSString stringWithFormat:@"%i dari %li",[[[data_detail objectForKey:@"series"] objectForKey:@"order"] integerValue]+1,(long)[[data_detail objectForKey:@"total_series"] integerValue]];
            [self.label_judul_series sizeToFit];
            self.img_detail.frame=CGRectMake(self.img_detail.frame.origin.x,32+self.tinggi_judul+self.label_judul_series.frame.size.height, self.img_detail.frame.size.width, self.img_detail.frame.size.height);
            
            if([[[data_detail objectForKey:@"series"]objectForKey:@"order"] integerValue] < [[data_detail objectForKey:@"total_series"] integerValue]-1)
            {
              link_next=[NSString stringWithFormat:@"%@",[[data_detail objectForKey:@"next_series"] objectForKey:@"post_id"]];
               
                self.img_next_series.hidden=NO;
              self.img_previous_series.hidden=NO;
                
            }else{
                self.img_next_series.hidden=YES;
                 self.img_previous_series.hidden=NO;
            }
            
            if([[[data_detail objectForKey:@"series"]objectForKey:@"order"] integerValue]==0)
            {
                self.img_previous_series.hidden=YES;
                _first_series=YES;
            }else{
              link_previous=[NSString stringWithFormat:@"%@",[[data_detail objectForKey:@"prev_series"] objectForKey:@"post_id"]];
                    _first_series=NO;
                frame_hiden.size.height+=20;
              //  self.label_judul_series.frame=frame_hiden;
            }
        
          
        }else{
                is_series=NO;
//            CGRect frame_hiden;
//            frame_hiden.size.height=0;
//            self.cell_series.frame=frame_hiden;
//            self.label_judul_series.frame=frame_hiden;
        }
        
        
        
        
        self.label_judul_detail.font = self.font_size_judul;
        
        
        self.label_author.text=[NSString stringWithFormat:@" %@",[data_detail objectForKey:@"author_name"]];
        //self.label_author.font=self.font_size_tgl;
        self.label_tgl_detail.text =[NSString stringWithFormat:@" %@",[data_detail objectForKey:@"new_date"]];
        // self.label_tgl_detail.font=self.font_size_tgl;
        NSString *img_sumber=@"";
        NSString *img_caption=@"";
        
        NSArray* foo = [[NSString stringWithFormat:@" %@",[data_detail objectForKey:@"image_caption"]] componentsSeparatedByString: @"/"];
        if([foo count]==2){
             self.label_img_sumber.text=foo[1];
            img_caption=[NSString stringWithFormat:@"<p style='font-size:7px;text-align:center;'> %@</p> ",foo[0]];
            img_sumber=[NSString stringWithFormat:@"<p style='font-size:7px;text-align:right; margin-right:10px;'> %@ </p>",foo[1]];
            self.label_img_caption.text=foo[0];
        }else{
            self.label_img_sumber.text=@"";
            self.label_img_caption.text=foo[0];
            self.label_img_caption.text=[data_detail objectForKey:@"image_caption"];
            img_caption=[NSString stringWithFormat:@"<p style='font-size:7px;text-align:center;'> %@</p> ",foo[0]];
        }
  
        NSLog(@"img caption %@",[data_detail objectForKey:@"image_caption"]);
        //[NSString stringWithFormat:@" %@",[data_detail objectForKey:@"content"]] ;//foo[0];
        
      //  self.label_img_caption.numberOfLines = 0;
        //  self.label_img_caption.font=self.font_size_tgl;
       
          //self.label_img_sumber.font=self.font_size_tgl;
        // RTLabel *label = [[RTLabel alloc] initWithFrame:CGRectMake(10,280,300,100)];
        // [label setText:[NSString stringWithFormat:@" %@",[data_detail objectForKey:@"content"]]];
        //[label setParagraphReplacement:@""];
        
        //label.lineSpacing = 5.0;
        
        //CGSize optimumSize = [label optimumSize];
        //CGRect frame = [label frame];
        //frame.size.height = (int)optimumSize.height; // +5 to fix height issue, this should be automatically fixed in iOS5
        
        [self.web_detail setFrame:CGRectMake(0,1000, 320, 150+webViewHeight)];
        self.web_detail.scrollView.scrollEnabled=NO;
        self.web_detail.scrollView.bounces = NO;
        
   
        
        //  [self.scroller addSubview:label]
        
        NSLog(@"css %@",css);
        /*
         NSString *skript_iklan = @"<script type='text/javascript'><!--//<![CDATA[var m3_u = (location.protocol=='https:'?'https://ads.bisnis.com/www/delivery/ajs.php':'http://ads.bisnis.com/www/delivery/ajs.php');var m3_r = Math.floor(Math.random()*99999999999);if (!document.MAX_used) document.MAX_used = ',';document.write ('<scr'+'ipt type='text/javascript' src=''+m3_u);document.write ('?zoneid=157');document.write ('&amp;cb=' + m3_r);if (document.MAX_used != ',') document.write ('&amp;exclude=' + document.MAX_used);document.write (document.charset ? '&amp;charset='+document.charset : (document.characterSet ? '&amp;charset='+document.characterSet : ''));document.write ('&amp;loc=' + escape(window.location));if (document.referrer) document.write ('&amp;referer=' + escape(document.referrer));if (document.context) document.write ('&context=' + escape(document.context));if (document.mmm_fo) document.write ('&amp;mmm_fo=1');document.write (''><scr'+'ipt>');//]]>--></script><noscript><a href='http://ads.bisnis.com/www/delivery/ck.php?n=a38cf17d&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://ads.bisnis.com/www/delivery/avw.php?zoneid=157&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a38cf17d' border='0' alt='' /></a></noscript>";
         
         
         NSString *sc = @'<script type='text/javascript'><!--//<![CDATA[ var m3_u = (location.protocol=='https:'?'https://ads.bisnis.com/www/delivery/ajs.php':'http://ads.bisnis.com/www/delivery/ajs.php'); var m3_r = Math.floor(Math.random()*99999999999); if (!document.MAX_used) document.MAX_used = ','; document.write (\'<scr \"+ \"ipt type='text/javascript' src='\"+m3_u); document.write (\"?zoneid=157\"); document.write ('&amp;cb=' + m3_r); if (document.MAX_used != ',') document.write (\"&amp;exclude=\" + document.MAX_used); document.write (document.charset ? '&amp;charset='+document.charset : (document.characterSet ? '&amp;charset='+document.characterSet : '')); document.write (\"&amp;loc=\" + escape(window.location)); if (document.referrer) document.write (\"&amp;referer=\" + escape(document.referrer)); if (document.context) document.write (\"&context=\" + escape(document.context)); if (document.mmm_fo) document.write (\"&amp;mmm_fo=1\"); document.write (\"'><\/scr\"+\"ipt>\"); //]]>--></script><noscript><a href='http://ads.bisnis.com/www/delivery/ck.php?n=a38cf17d&amp;cb=INSERT_RANDOM_NUMBER_HERE' target='_blank'><img src='http://ads.bisnis.com/www/delivery/avw.php?zoneid=157&amp;cb=INSERT_RANDOM_NUMBER_HERE&amp;n=a38cf17d' border='0' alt='' /></a></noscript>";
         */
        NSString *a_live=@"";
        if([[NSString stringWithFormat:@"%@",[data_detail objectForKey:@"is_live"]] integerValue]==1){
            self.tabel_live.hidden=YES;
            a_live=@"<div class=\"button-live\"><p ><a href=\"inapp://capture\" style=\"text-decoration: none;color: #fff; \">Live Report Klik di Sini</a></p></div> <style>.button-live{ width:100%; height:24px; background-color:#ff0303; text-align:center; -moz-box-shadow: 0 5px 9px 1px rgba(0,0,0,0.2); -o-box-shadow: 0 5px 9px 1px rgba(0,0,0,0.2); -webkit-box-shadow: 0 5px 9px 1px rgba(0,0,0,0.2); box-shadow: 0 5px 9px 1px rgba(0,0,0,0.2);} .button-live p{font-family:Arial, Helvetica, sans-serif; color:#fff;}</style>";
        }
        
        
        
        
        data_list_terkait=@"";
        
        for (int a=0; a<[self.array_terkait count]; a++) {
            Frame_Berita *data = [self.array_terkait objectAtIndex:a];
            
            data_terkai=[ NSString stringWithFormat:@"<li><a href=\"terkait://%i\"><p>%@</p><p>%@</p></a></li>",a,data.Tgl_Berita,data.Judul_Berita];
            
            data_list_terkait = [data_list_terkait stringByAppendingString:data_terkai];
            NSLog(@"DATA TER %i",[self.array_terkait count]);
        }
        
        
        
        dispatch_queue_t queue = dispatch_queue_create("Sibertama.Bisniscom", NULL);
        dispatch_async(queue, ^{
            //code to be executed in the background
            NSString *img_url =[NSString stringWithFormat:@"%@", [data_detail objectForKey:@"image_uri"]];
            // NSLog(@"wkwkwkwk %@",img_url);
            
            NSURL   *url  = [NSURL URLWithString:img_url];//[[self.json_berita objectAtIndex:indexPath.row] objectForKey:@"title"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //code to be executed on the main thread when background task is finished
                if(image==nil){
                    self.img_detail.image = [UIImage imageNamed:@"img_logo.png"];
                    self.img_detail.frame=CGRectMake(self.img_detail.frame.origin.x, 0, self.img_detail.frame.size.width,180);
                    self.first_height=180;
                }else{
                    self.img_detail.image=image;
                    NSLog(@"VIEW IMAGE %f",image.size.height);
                    if(image.size.width/image.size.height >1){
                         NSLog(@"Landscape %f",image.size.height);
                            self.first_height=240;
                    }else{
                     NSLog(@"Potraid %f",image.size.height);
                        self.first_height=(self.view.frame.size.width/image.size.width*image.size.height);
                    }
                    
                    if(image.size.height<=318){
                       // self.first_height=318;
                    }else{
                        
                    }

                    
                    
                }
                if([[data_detail objectForKey:@"is_series"] integerValue]==1){
                    
                    
                    if([[[data_detail objectForKey:@"series"]objectForKey:@"order"] integerValue] < [[data_detail objectForKey:@"total_series"] integerValue]-1)
                    {
                    
                        page_series=[NSString stringWithFormat:@"<div class=\"page\"style=\"background-color:#333333; height:32px;\"><p><a href=\"prevseries://\"> <img src=\"http://services.bisnis.com/assets/images/arrow2.png\" > </a> </p><p> %@ </p><p><a href=\"nextseries://\"> <img src=\"http://services.bisnis.com/assets/images/arrow.png\" style=\"float: left;\"> </a> </p></div>",self.label_series.text];
                        
                        
                    }else{
                        page_series=[NSString stringWithFormat:@"<div class=\"page\"style=\"background-color:#333333; height:32px;\"><p><a href=\"prevseries://\"> <img src=\"http://services.bisnis.com/assets/images/arrow2.png\" > </a> </p><p> %@ </p><p><a href=\"nextseries://\"> <img src=\"http://services.bisnis.com/assets/images/list.png\" style=\"float: left;\"> </a> </p></div>",self.label_series.text];
                        
                    }
                    
                    if([[[data_detail objectForKey:@"series"]objectForKey:@"order"] integerValue]==0)
                    {
                        page_series=[NSString stringWithFormat:@"<div class=\"page\"style=\"background-color:#333333; height:32px;\"><p><a href=\"prevseries://\"> <img src=\"http://services.bisnis.com/assets/images/list.png\" > </a> </p><p> %@ </p><p><a href=\"nextseries://\"> <img src=\"http://services.bisnis.com/assets/images/arrow.png\" style=\"float: left;\"> </a> </p></div>",self.label_series.text];
                        
                    }
                }
                
               // NSString *share = @"<div class='shared' style='margin-bottom:10px;'><h3>Share : </h3><a href=\"inapp://facebook\"><img src='http://services.bisnis.com/assets/images/facebook.png' width='32px'></a><a href=\"inapp://twitter\"> <img src='http://services.bisnis.com/assets/images/twiiter.png' width='32px'></a><a href=\"inapp://gplus\"> <img src='http://services.bisnis.com/assets/images/gplus.png' width='32px'></a><a href=\"inapp://whatsapp\"> <img src='http://services.bisnis.com/assets/images/whatsapp.png' width='32px'></a></div>";
                 NSString *share = @"<div class='shared' style='margin-bottom:10px;'><h3>Share : </h3><a href=\"inapp://facebook\"><img src='http://services.bisnis.com/assets/images/facebook.png' width='32px'></a><a href=\"inapp://twitter\"> <img src='http://services.bisnis.com/assets/images/twiiter.png' width='32px'></a><a href=\"inapp://whatsapp\"> <img src='http://services.bisnis.com/assets/images/whatsapp.png' width='32px'></a></div>";
                
                //self.img_detail.frame = CGRectMake(self.img_detail.frame.origin.x, self.img_detail.frame.origin.y,self.img_detail.frame .size.width, self.first_height);
               // self.img_detail.contentMode=UIViewContentModeScaleAspectFit;
                self.img_detail.frame=CGRectMake(self.img_detail.frame.origin.x, 0, self.img_detail.frame.size.width, self.first_height);
               
//                for (NSString* family in [UIFont familyNames])
//                {
//                    NSLog(@"%@", family);
//                    
//                    for (NSString* name in [UIFont fontNamesForFamilyName: family])
//                    {
//                        NSLog(@"  %@", name);
//                    }
//                }

                
                
                
                berita_terkait=[NSString stringWithFormat:@"<div class='main-title'><div class=\"bates1\"></div><div class=\"bates\"></div><h3> BERITA TERKAIT </h3><div class=\"bates\"></div><ul>%@</ul></div>",data_list_terkait];
                css_terkait =@"<style>.detail img {width:100%;} table {twidth: 100%; text-align: center;margin-bottom: 20px; !important} table tr th td {border: 1px solid #ddd; border-collapse: collapse; !important} .page p:nth-child(2){color:#FFF;width:80%;text-align:center;float:left; height:40px;line-height:30px; font-size:18px;font-family:Arial, Helvetica, sans-serif;}.page p:first-child{width:10%;float:left;}.page p:first-child a{float:right;color:#FF0;font-weight:bold;text-decoration:none;}.page p:last-child{width:10%;float:right;}.page p:last-child a{float:left;color:#FF0;font-weight:bold;text-decoration:none;}*{padding:0;margin:0;}.detail{height:auto;padding:0px 0;}.shared h3{margin-left:10px; font-family:Arial, Helvetica, sans-serif;font-size:13px; float: left;margin-top: 10px;}.shared a{margin-left:10px;text-decoration:none;}.bates{width:100%; height: 1px;background-color:#333;margin-top:0px;}.bates1{width:100%; height: 3px;background-color:#333;margin-top:0px;margin-bottom:4px;}.main-title ul{margin-left:10px;}.main-title ul li a{text-decoration: none;}.main-title{width:106%;height:30px;background-color:#FFFFFF;margin-left:0px;}.main-title h3,.main-title ul li{font-family:OpenSans;font-weight:normal;}.main-title h3{font-size:21px;color:#000000 ;padding:3px; text-align: center;}.main-title ul li{width:100%;list-style:none;height:auto;}.main-title ul li p:first-child{color:#555555;font-size:8px;margin-top:10px;}.main-title ul li p:last-child a{color:#083e75;font-size:18px;margin-top: 10px;}.main-title ul li p:last-child{width:90%;border-bottom: 1px dashed #ccc; margin-top: 5px;font-size:18px; color:#083e75; margin-bottom:15px;padding-bottom:2px;font-family:Bodoni 72;}</style>";
                
                //<a href=\"inapp://capture\"><input type=\"button\" onClick=\"submitButton('My Test Parameter')\" value=\"submit\"></a>";
                self.label_editor.text= @"";//[NSString stringWithFormat:@"Editor : %@", [data_detail objectForKey:@"editor_name"]];
                // [self.web_detail loadHTMLString:[NSString stringWithFormat:@"%@ %@ %@  <div class='detail'> %@  </br> </div><div class='editor' style='font-size:10 !important; '>Editor : %@ </div> %@ </br> %@ %@",img_sumber,img_caption,css,[data_detail objectForKey:@"content"],[data_detail objectForKey:@"editor_name"],a_live,css_terkait,berita_terkait] baseURL:nil];
                //[self.web_live loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://services.bisnis.com/json/live/262843/latest/"]]];
                HTML=[NSString stringWithFormat:@"%@  <div class='detail'> %@  </div> %@</br> <div class='editor' style='font-size:13px; margin-left:10px; !important; '>Editor : %@ </div> %@ </br> %@ ",css,[data_detail objectForKey:@"content"],page_series,[data_detail objectForKey:@"editor_name"],a_live,share];
                [self.web_detail loadHTMLString:[NSString stringWithFormat:@"<meta name=\"viewport\" content=\"width=320\"/>  %@ %@ %@",HTML,css_terkait,berita_terkait] baseURL:nil];
                
                [self.label_img_sumber setFrame:CGRectMake(10,self.img_detail.frame.size.height,self.label_img_sumber.frame.size.width,self.label_img_sumber.frame.size.height)];
                [self.label_img_caption setFrame:CGRectMake(6,self.label_img_sumber.frame.origin.y+self.label_img_sumber.frame.size.height,self.label_img_caption.frame.size.width,self.label_img_sumber.frame.size.height)];
              
                
                [self.label_img_caption setNumberOfLines:0];
                [self.label_img_caption sizeToFit];
                
                //[self.label_img_caption sizeToFit];
                
                //                [ self.img_detail.layer setBorderWidth:2.0f];
                //                [ self.img_detail.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
                //
                //                self.img_detail.layer.cornerRadius = 10;
                //                self.img_detail .layer.shadowColor = [[UIColor blackColor] CGColor];
                //                self.img_detail .layer.shadowOpacity = 1;
                //                self.img_detail.layer.shadowRadius = 10;
                //                self.img_detail.layer.shadowOffset = CGSizeMake(-2, 7);
                //                [self.img_detail setBackgroundColor:[UIColor redColor]];
                
                
                
            });
        });
        
        
    }
}
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // NSLog(@"adasdasdsd");
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        NSURL *url = [request URL];
        if ([request.URL.scheme isEqualToString:@"nextseries"]) {
            [self next_series];
            return NO;
        }
        if ([request.URL.scheme isEqualToString:@"prevseries"]) {
            [self prev_series];
            return NO;
        }
        if ([request.URL.scheme isEqualToString:@"terkait"]) {
            [[Terkait_Object sharedManager]setPage_terkait:[NSString stringWithFormat:@"%i",[request.URL.host integerValue]]];
            [[Terkait_Object sharedManager]setArray_terkait:self.array_terkait];
            PagerRootViewControllerTerkait *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"terkait_test"];
            [self presentViewController:monitorMenuViewController animated:UIModalTransitionStyleFlipHorizontal completion:nil];
            return NO;
        }
        else if ([request.URL.scheme isEqualToString:@"inapp"]) {
            if ([request.URL.host isEqualToString:@"gplus"]) {
                
             
                NSLog(@" share gogoogle %@",link_title );
                
                //            id<GPPShareBuilder> shareBuilder = [self shareBuilder];
                //
                //            [shareBuilder open];
                
                [cobe sendActionsForControlEvents:UIControlEventTouchUpInside];
                
                id<GPPNativeShareBuilder> shareBuilder = [[GPPShare sharedInstance] nativeShareDialog];
                
                // This line will fill out the title, description, and thumbnail from
                // the URL that you are sharing and includes a link to that URL.
                [shareBuilder setURLToShare:[NSURL URLWithString:link_share]];
                
                [shareBuilder open];
                


           
            }else if ([request.URL.host isEqualToString:@"whatsapp"]) {
                  
                NSString *msg = [NSString stringWithFormat:@"%@ | %@",link_title,link_share];
                msg = [msg stringByReplacingOccurrencesOfString:@"|" withString:@"%7C"];
                msg = [msg stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
                msg = [msg stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
                msg = [msg stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
                msg = [msg stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
                msg = [msg stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
                msg = [msg stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
                msg = [msg stringByReplacingOccurrencesOfString:@"&" withString:@"%26"];
                NSLog(@" share content %@",msg );
                
                
                NSURL *whatsappURL = [NSURL URLWithString:[NSString stringWithFormat:@"whatsapp://send?text=%@",msg]];
                if ([[UIApplication sharedApplication] canOpenURL: whatsappURL]) {
                    [[UIApplication sharedApplication] openURL: whatsappURL];
                }

                    
                    
            } else if ([request.URL.host isEqualToString:@"facebook"]) {
                // do capture action
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
                [tweetSheet setInitialText:link_title];
                //                if (self.imageString)
                //                {
               // [tweetSheet addImage:self.img_detail.image];
                //                }
                //
                //                if (self.urlString)
                //                {
                [tweetSheet addURL:[NSURL URLWithString:link_share]];
                //                }
                [self presentViewController:tweetSheet animated:YES completion:nil];
            }else if ([request.URL.host isEqualToString:@"twitter"]) {
                
                SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
                [tweetSheet setInitialText:link_title];
                
                //                if (self.imageString)
                //                {
                [tweetSheet addImage:self.img_detail.image];
                //                }
                //
                //                if (self.urlString)
                //                {
                [tweetSheet addURL:[NSURL URLWithString:link_share]];
                //                }
                [self presentViewController:tweetSheet animated:YES completion:nil];            }else
            if ([request.URL.host isEqualToString:@"capture"]) {
                // do capture action
                NSLog(@" OKOKOKOKKKO ");
                [[Detail_Object sharedManager]setUrl_web:[NSString stringWithFormat:@"%@",b1.Judul_Berita]];
                
                LiveViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewControllerLive"];
                [self presentViewController:monitorMenuViewController animated:UIModalTransitionStyleFlipHorizontal completion:nil];
                
                
            }
            return NO;
        }else
            if ([[url absoluteString] rangeOfString:@"gmail"].location == NSNotFound) {
                NSLog(@"%@",url);
                [[Detail_Object sharedManager]setUrl_web:[NSString stringWithFormat:@"%@",url]];
                LinkWebViewController *monitorMenuViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PagerDataViewControllerLink"];
                [self presentViewController:monitorMenuViewController animated:UIModalTransitionStyleFlipHorizontal completion:nil];
                
                // [self open_link:url];
                //  [[UIApplication sharedApplication] openURL:[request URL]];
                return NO;
            }
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if(web_detail==self.web_detail){
        
        //  self.webViewHeightConstraint.constant = webView.frame.size.height;
        
        
        //
        //    NSLog(@"WEB %@",webView.description.self);
        
        // webView.frame = frame;
        //      // Disable user selection
        //    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
        //    // Disable callout
        //    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
        //
        
        NSLog(@"Tinggi bro %lu",(unsigned long)[self.array_terkait count]);
        
        
        //[self.label_editor setFrame:CGRectMake(10,webViewHeight+265,320,25)];
        //[self.tabel_live setFrame:CGRectMake(0,webViewHeight+230,320,25)];
        CGSize size = [webView sizeThatFits:CGSizeMake(1.0f, 1.0f)]; // Pass about any size
        CGRect frame = webView.frame;
        frame.size.height = size.height;
        //    NSUInteger contentHeight = [[webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.body.scrollHeight;"]] intValue];
        
        webViewHeight=size.height;
        //webView.scalesPageToFit = YES;
        //[webView sizeToFit];
        
        // Round button corners
        //        CALayer *btnLayer = [self.img_shared  layer];
        //        [btnLayer setMasksToBounds:YES];
        //        [btnLayer  setCornerRadius:3.0f];
        //        [btnLayer setBorderWidth:1.0f];
        //        [btnLayer setBorderColor:[[UIColor blackColor] CGColor]];
        
        // [self.img_comment setFrame:CGRectMake(138,webViewHeight+350,48,48)];
        
        //        CALayer *btnLayer2 = [self.img_comment  layer];
        //        [btnLayer2 setMasksToBounds:YES];
        //        [btnLayer2  setCornerRadius:3.0f];
        //        [btnLayer2 setBorderWidth:1.0f];
        //        [btnLayer2 setBorderColor:[[UIColor blackColor] CGColor]];
        
        // [self.img_bookmark setFrame:CGRectMake(240,webViewHeight+350,48,48)];
        //
        //        CALayer *btnLayer3 = [self.img_bookmark  layer];
        //        [btnLayer3 setMasksToBounds:YES];
        //        [btnLayer3  setCornerRadius:3.0f];
        //        [btnLayer3 setBorderWidth:1.0f];
        //        [btnLayer3 setBorderColor:[[UIColor blackColor] CGColor]];
        //        //CGFloat scrollViewHeight = 0.0f;
        //for (UIView* view in self.scroller.subviews)
        //{
        //  scrollViewHeight += view.frame.size.height;
        //}
        //CGFloat tableHeightCalculated =([self.array_terkait count]+1)*50;
        if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        {
            
            
            CGSize result = [[UIScreen mainScreen] bounds].size;
            if(result.height == 480)
            {
                //Load 3.5 inch xib
                
                //                [self.label_terkait setFrame:CGRectMake(0,75+webViewHeight+self.tabel_terkait.frame.origin.y,self.label_terkait.frame.size.width,25)];
                //                self.tabel_terkait.frame = CGRectMake(self.tabel_terkait.frame.origin.x, 105+webViewHeight+self.tabel_terkait.frame.origin.y,self.tabel_terkait.frame.size.width,tableHeightCalculated);
                self.tabel_action.frame = CGRectMake(0, 440, 320, 44);
                [self.scroller setContentSize:(CGSizeMake(320, webViewHeight+self.img_detail.frame.size.height+self.view_head.frame.size.height+200))];
            }
            else if(result.height == 568)
            {
                //Load 4 inch xib
                NSLog(@" laayr 4");
                //                [self.label_terkait setFrame:CGRectMake(0,-100+webViewHeight+self.tabel_terkait.frame.origin.y,self.label_terkait.frame.size.width,25)];
                //                //    self.label_terkait.frame =CGRectMake(self.label_terkait.frame.origin.x, 150+webViewHeight+self.label_terkait.frame.origin.y,self.label_terkait.frame.size.width,50);
                //                self.tabel_terkait.frame = CGRectMake(self.tabel_terkait.frame.origin.x, -75+webViewHeight+self.tabel_terkait.frame.origin.y,self.tabel_terkait.frame.size.width,tableHeightCalculated);
                [self.scroller setContentSize:(CGSizeMake(320, webViewHeight+self.img_detail.frame.size.height+self.view_head.frame.size.height+200))];
            }
            
            // Tell the label to use an unlimited number of lines
            [self.label_judul_detail setNumberOfLines:0];
            [self.label_judul_detail sizeToFit];
            
            self.label_author.frame = CGRectMake(self.label_author.frame.origin.x, 10+self.label_judul_detail.frame.size.height, self.label_author.frame.size.width,self.label_author.frame.size.height);
            self.label_tgl_detail.frame = CGRectMake(self.label_tgl_detail.frame.origin.x, 20+self.label_author.frame.origin.y, self.label_tgl_detail.frame.size.width,self.label_tgl_detail.frame.size.height);
            
            self.bates_atas1.frame = CGRectMake(self.bates_atas1.frame.origin.x, 25+self.label_tgl_detail.frame.origin.y, self.bates_atas1.frame.size.width,2);
            self.bates_atas2.frame = CGRectMake(self.bates_atas1.frame.origin.x, 5+self.bates_atas1.frame.origin.y, self.bates_atas2.frame.size.width,1);
            
            self.tinggi_judul=self.label_judul_detail.frame.size.height+90;
            
 
            
            self.view_head.frame = CGRectMake(self.view_head.frame.origin.x,self.label_img_caption.frame.origin.y+self.label_img_caption.frame.size.height, self.view_head.frame.size.width,self.label_judul_detail.frame.size.height+65);
           
            
           // self.img_detail.frame=CGRectMake(self.img_detail.frame.origin.x,frame.origin.y+self.label_judul_series.frame.size.height, self.web_detail.frame.size.width, self.img_detail.frame.size.height);
            self.img_detail.contentMode=UIViewContentModeScaleToFill;
            [self.label_judul_detail sizeToFit];
            //[self.view_head sizeToFit];
            
            if(_first_series){
                self.label_judul_series.frame=CGRectMake(0,self.view_head.frame.origin.y+self.view_head.frame.size.height, self.img_detail.frame.size.width, 0);
                
            }else{
                self.label_judul_series.frame=CGRectMake(0,self.view_head.frame.origin.y+self.view_head.frame.size.height, self.img_detail.frame.size.width, 32);
                
            }
            
            
            if(is_series){
                self.cell_series.frame=CGRectMake(0, self.label_judul_series.frame.origin.y+self.label_judul_series.frame.size.height, self.img_detail.frame.size.width,32);
                if(self.first_height==0){
                    webView.frame = CGRectMake(0,self.cell_series.frame.origin.y+self.cell_series.frame.size.height, 320, 150+webViewHeight);
                }else{
                    webView.frame = CGRectMake(0,self.cell_series.frame.origin.y+self.cell_series.frame.size.height, 320, 150+webViewHeight);
                }
            
            }else{
                self.cell_series.frame=CGRectMake(0, self.tinggi_judul, self.label_judul_series.frame.size.width,0);
                
                if(self.first_height==0){
                    webView.frame = CGRectMake(0,self.view_head.frame.origin.y+self.view_head.frame.size.height, 320, 150+webViewHeight);
                }else{
                    webView.frame = CGRectMake(0,self.view_head.frame.origin.y+self.view_head.frame.size.height, 320, 150+webViewHeight);
                }
            }
            
          
            
            
           
            NSLog(@" Tinggi judul : %f ",self.first_height);
        
            
            
            
            
        
            

        }else{
//            //Load 3.5 inch xib
//            //Load 4 inch xib
//            CGFloat tableHeightCalculated =([self.array_terkait count]+1)*150;
//            [self.label_judul_detail sizeToFit];
//            NSLog(@" laayr 4");
//            self.tabel_action.frame = CGRectMake(0, 960, 768, 64);
//            [self.tabel_live setFrame:CGRectMake(0,webViewHeight+700,1333,43)];
//            [self.label_editor setFrame:CGRectMake(10,webViewHeight+575,658,25)];
//            webView.frame = CGRectMake(0, self.view_head.frame.size.height+first_height, 768, webViewHeight);
//            [self.label_terkait setFrame:CGRectMake(0,+webViewHeight+self.tabel_terkait.frame.origin.y,self.label_terkait.frame.size.width,25)];
//            //    self.label_terkait.frame =CGRectMake(self.label_terkait.frame.origin.x, 150+webViewHeight+self.label_terkait.frame.origin.y,self.label_terkait.frame.size.width,50);
//            self.tabel_terkait.frame = CGRectMake(self.tabel_terkait.frame.origin.x, 30+webViewHeight+self.tabel_terkait.frame.origin.y,self.tabel_terkait.frame.size.width,tableHeightCalculated);
//            [self.scroller setContentSize:(CGSizeMake(300, webViewHeight+tableHeightCalculated+self.img_detail.frame.size.height))];
//            
        }
        
        
        //  [self.web_live setFrame:CGRectMake(10,webViewHeight+270,320,25)];
        
    }else{
        
        
        
    }
    
    [self.web_detail scalesPageToFit];
    [self.activityIndicator stopAnimating];
}

- (NSArray *)fetchDataterkait:(NSData *)response
{
    NSError *error = nil;
    NSArray *JSON = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
    
    
    //NSLog(@"data terkait : %@",JSON);
    
    return JSON;
}

- (NSMutableDictionary *)fetchData:(NSData *)response
{
    NSError *error = nil;
    NSMutableDictionary *JSON = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingAllowFragments error:&error];
    
    
    // NSLog(@"data terkait : %@",parsedData);
    
    return JSON;
}
-(void)rtLabel:(id)rtLabel didSelectLinkWithURL:(NSURL *)url{
    
    
    
}

-(void)open_link:(NSURL *)url{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width-10, self.view.frame.size.height)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 0;
    welcomeLabelRect.size.height = 0;
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 0, 0);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect);
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:infoLabelRect];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    [contentView addSubview:webView];
    
    //    [[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
    
}
-(void)alert_save{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 25 ,15);
    infoLabelRect.origin.y = 10;
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    UIImageView *img_logo = [[UIImageView alloc] initWithFrame:infoLabelRect];
    img_logo.image = [UIImage imageNamed:@"bookmark2"];
    
    [contentView addSubview:img_logo];
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = CGRectGetMaxY(infoLabelRect);
    welcomeLabelRect.size.height = 30;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:12];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Berita Sudah Di Bookmark";
    welcomeLabel.numberOfLines = 0;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    welcomeLabel.font = welcomeLabelFont;
    [contentView addSubview:welcomeLabel];
    
    [[KGModal sharedInstance] showWithContentView:contentView andAnimated:YES];
}

-(IBAction)cmd_open_link:(id)sender{
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
    
    CGRect welcomeLabelRect = contentView.bounds;
    welcomeLabelRect.origin.y = 0;
    welcomeLabelRect.size.height = 0;
    UIFont *welcomeLabelFont = [UIFont boldSystemFontOfSize:17];
    UILabel *welcomeLabel = [[UILabel alloc] initWithFrame:welcomeLabelRect];
    welcomeLabel.text = @"Welcome to KGModal!";
    welcomeLabel.font = welcomeLabelFont;
    welcomeLabel.textColor = [UIColor whiteColor];
    welcomeLabel.textAlignment = NSTextAlignmentCenter;
    welcomeLabel.backgroundColor = [UIColor clearColor];
    welcomeLabel.shadowColor = [UIColor blackColor];
    welcomeLabel.shadowOffset = CGSizeMake(0, 1);
    //[contentView addSubview:welcomeLabel];
    
    CGRect infoLabelRect = CGRectInset(contentView.bounds, 0, 0);
    infoLabelRect.origin.y = CGRectGetMaxY(welcomeLabelRect);
    infoLabelRect.size.height -= CGRectGetMinY(infoLabelRect);
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:infoLabelRect];
    infoLabel.text = @"KGModal is an easy drop in control that allows you to display any view "
    "in a modal popup. The modal will automatically scale to fit the content view "
    "and center it on screen with nice animations!";
    infoLabel.numberOfLines = 6;
    infoLabel.textColor = [UIColor whiteColor];
    infoLabel.textAlignment = NSTextAlignmentCenter;
    infoLabel.backgroundColor = [UIColor clearColor];
    infoLabel.shadowColor = [UIColor blackColor];
    infoLabel.shadowOffset = CGSizeMake(0, 1);
    
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:infoLabelRect];  //Change self.view.bounds to a smaller CGRect if you don't want it to take up the whole screen
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://m.bisnis.com"]]];
    [contentView addSubview:webView];
    
    CGFloat btnY = CGRectGetMaxY(infoLabelRect)+5;
    CGFloat btnH = CGRectGetMaxY(contentView.frame)-5 - btnY;
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(infoLabelRect.origin.x, btnY, infoLabelRect.size.width, btnH);
    [btn setTitle:@"Close Button Right" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(changeCloseButtonType:) forControlEvents:UIControlEventTouchUpInside];
    //   [contentView addSubview:btn];
    
    //    [[KGModal sharedInstance] setCloseButtonLocation:KGModalCloseButtonLocationRight];
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
    UIButton *button = (UIButton *)sender;
    KGModal *modal = [KGModal sharedInstance];
    KGModalCloseButtonType type = modal.closeButtonType;
    
    if(type == KGModalCloseButtonTypeLeft){
        modal.closeButtonType = KGModalCloseButtonTypeRight;
        [button setTitle:@"Close Button Right" forState:UIControlStateNormal];
    }else if(type == KGModalCloseButtonTypeRight){
        modal.closeButtonType = KGModalCloseButtonTypeNone;
        [button setTitle:@"Close Button None" forState:UIControlStateNormal];
    }else{
        modal.closeButtonType = KGModalCloseButtonTypeLeft;
        [button setTitle:@"Close Button Left" forState:UIControlStateNormal];
    }
}

- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
    // Set the title of navigation bar by using the menu items
    NSIndexPath *indexPath = [self.tabel_terkait indexPathForSelectedRow];
    // UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
    // destViewController.title = [[_menuItems objectAtIndex:indexPath.row] capitalizedString];
    
    // Set the photo if it navigates to the PhotoView
    if ([segue.identifier isEqualToString:@"segue_terkait"]) {
        [[Terkait_Object sharedManager]setPage_terkait:[NSString stringWithFormat:@"%li",(long)indexPath.row]];
        [[Terkait_Object sharedManager]setArray_terkait:self.array_terkait];
    }else if([segue.identifier isEqual:@"segue_comment"]){
        
        BisnisViewController *destViewController = segue.destinationViewController;
        destViewController.link_comment = self.link_web_commnet;
        NSLog(@"WKKWKWKWKWKWKWKWKKWKWKWKWKWKWKW %@",self.link_web_commnet);
        
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
-(void)load_db_option{
    NSString *query = @"select * from ios_option";
    
    NSArray *arr_nav_info = [[NSArray alloc] initWithArray:[self.dbManager loadDataFromDB:query]];
    NSLog(@"data %@",arr_nav_info);
    NSLog(@"font option -> %@",[[arr_nav_info objectAtIndex:0]objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]]);
    
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        switch ([[[arr_nav_info objectAtIndex:0] objectAtIndex:[self.dbManager.arrColumnNames indexOfObject:@"option_font"]] intValue]) {
            case 0:
                //NSLog(@"3");
                self.font_size_judul= [UIFont boldSystemFontOfSize:18];
                self.font_size_tgl= [UIFont boldSystemFontOfSize:1];
                self.font_size_canal= [UIFont boldSystemFontOfSize:1];
                css =@"<style> .detail p{font-size:16px;margin:20px 10px;line-height:22px;width:95%;}</style>";
                break;
            case 1:
                //NSLog(@"3");
                self.font_size_judul= [UIFont boldSystemFontOfSize:21];
                self.font_size_tgl= [UIFont boldSystemFontOfSize:1];
                self.font_size_canal= [UIFont boldSystemFontOfSize:1];
                css =@"<style> .detail p{font-size:18px;margin:20px 10px;line-height:22px;width:95%;}</style>";
                break;
            case 2:
                // NSLog(@"3");
                self.font_size_judul= [UIFont boldSystemFontOfSize:23];
                self.font_size_tgl= [UIFont boldSystemFontOfSize:1];
                self.font_size_canal= [UIFont boldSystemFontOfSize:1];
                css =@"<style> .detail p{font-size:20px;margin:20px 10px;line-height:22px;width:95%;}</style>";
                break;
            case 3:
                // NSLog(@"3");
                self.font_size_judul= [UIFont boldSystemFontOfSize:25];
                self.font_size_tgl= [UIFont boldSystemFontOfSize:1];
                self.font_size_canal= [UIFont boldSystemFontOfSize:1];
                css =@"<style> .detail p{font-size:21px;margin:20px 10px;line-height:22px;width:95%;}</style>";
                break;
                
            default:
                break;
        }
    }
    NSLog(@"%@",self.font_size_judul);
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{ [self updateFloatingViewFrame];
    NSLog(@"...");
    [UIView transitionWithView: self.tabel_action
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:NULL
                    completion:NULL];
    
    self.tabel_action.hidden = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"2222");
    
    self.tabel_action.hidden = NO;
}

- (void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    NSLog(@"touches ended BS");
}


//series
-(IBAction)cmd_next_series:(id)sender{
    //url_berita = [NSString stringWithFormat:@"%@/%@/104/%@",url_detail,tgl_series,link_next];
    
    [self.activityIndicator startAnimating];
    url_berita = [NSString stringWithFormat:@"%@/%@",tgl_series,link_next];
    
    [self loaddetail:url_berita];
     [self.scroller setContentOffset:CGPointZero animated:true];
}
-(IBAction)cms_previous_series:(id)sender{
    
    [self.activityIndicator startAnimating];
    url_berita = [NSString stringWithFormat:@"%@/%@",tgl_series,link_previous];
    [self loaddetail:url_berita];
     [self.scroller setContentOffset:CGPointZero animated:true];
}

-(void)next_series{
    // url_berita = [NSString stringWithFormat:@"%@/%@/104/%@",url_detail,tgl_series,link_next];
    url_berita = [NSString stringWithFormat:@"%@/%@",tgl_series,link_next];
    
    [self.activityIndicator startAnimating];
    [self loaddetail:url_berita];
    [self.scroller setContentOffset:CGPointZero animated:true];

}

-(void)prev_series{
    
    [self.activityIndicator startAnimating];
    url_berita = [NSString stringWithFormat:@"%@/%@",tgl_series,link_previous];
    [self loaddetail:url_berita];
    [self.scroller setContentOffset:CGPointZero animated:true];
}

//end series



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)finishedSharingWithError:(NSError *)error {
    if (!error) {
        NSLog(@"Shared succesfully");
    } else if(error.code == kGPPErrorShareboxCanceled) {
        NSLog(@"User cancelled share");
    } else {
        NSLog(@"Unknown share error: %@", [error localizedDescription]);
    }
}


- (void)finishedWithAuth:(GTMOAuth2Authentication *)auth
                   error:(NSError *)error {
    if (error) {
        NSLog(@"errors finishedWithAuth");
        return;
    }
   [self reportAuthStatus];
//    [self updateButtons];
}
- (void)reportAuthStatus {
    if ([GPPSignIn sharedInstance].authentication) {
        NSLog( @"Status: Authenticated");
    } else {
        // To authenticate, use Google+ sign-in button.
       NSLog( @"Status: Not authenticated");
    }
     NSLog(@" status %@",[GPPSignIn sharedInstance].userEmail);
}


- (void)didDisconnectWithError:(NSError *)error {
//    if (error) {
//        _signInAuthStatus.text =
//        [NSString stringWithFormat:@"Status: Failed to disconnect: %@", error];
//    } else {
//        _signInAuthStatus.text =
//        [NSString stringWithFormat:@"Status: Disconnected"];
//    }
//    [self refreshUserInfo];
//    [self updateButtons];
}

- (void)presentSignInViewController:(UIViewController *)viewController {
    [[self navigationController] pushViewController:viewController animated:YES];
}




@end
