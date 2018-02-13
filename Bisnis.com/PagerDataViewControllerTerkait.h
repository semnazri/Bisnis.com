//
//  PagerDataViewController.h
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/18/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AAShareBubbles.h"
#import "GAITrackedViewController.h"

@interface PagerDataViewControllerTerkait : GAITrackedViewController<UIWebViewDelegate,UIScrollViewAccessibilityDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,AAShareBubblesDelegate>
@property(strong,nonatomic) IBOutlet UILabel *dataLabel;
@property (strong,nonatomic) id dataObject;
@property int pagenumber;
@property(nonatomic) NSInteger myValue;
@property(weak)IBOutlet UIScrollView *scroller;
-(IBAction)Bak_to:(id)sender;
-(IBAction)cmd_share:(id)sender;
-(IBAction)cmd_comment:(id)sender;
-(IBAction)cmd_bookmark:(id)sender;
-(IBAction)cmd_open_link:(id)sender;
@property(strong,nonatomic)UIButton *menu_btn;

//interface detail

@property (strong, nonatomic) IBOutlet UIWebView *web_detail;
@property (strong, nonatomic) IBOutlet UIWebView *web_live;
@property(strong,nonatomic)IBOutlet UILabel *label_judul_detail;
@property(strong,nonatomic)IBOutlet UILabel *label_author;
@property(strong,nonatomic)IBOutlet UILabel *label_tgl_detail;
@property(strong,nonatomic)IBOutlet UILabel *label_img_caption;
@property(strong,nonatomic)IBOutlet UILabel *label_img_sumber;
@property(strong,nonatomic)IBOutlet UILabel *label_editor;
@property(strong,nonatomic)IBOutlet UILabel *label_terkait;
@property(strong,nonatomic)IBOutlet UIImageView *img_detail;
@property(strong,nonatomic)IBOutlet UIImageView *img_live;
@property(strong,nonatomic)IBOutlet UIButton *img_shared;
@property(strong,nonatomic)IBOutlet UIButton *img_comment;
@property(strong,nonatomic)IBOutlet UIButton *img_bookmark;
@property(strong,nonatomic)IBOutlet UIButton *cmd_last;
@property(strong,nonatomic)IBOutlet UIButton *cmd_old;
@property(strong,nonatomic)IBOutlet UITableView *tabel_terkait;
@property(strong,nonatomic)IBOutlet UITableViewCell *tabel_live;
@property(strong,nonatomic)IBOutlet UITableViewCell *tabel_action;


@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_biru2;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_kuning;

@property(strong,nonatomic)IBOutlet UITableViewCell *view_head;
@property (nonatomic, retain) UIActivityIndicatorView *activityIndicator;


@property(strong,nonatomic)IBOutlet UIButton *img_next_series;
@property(strong,nonatomic)IBOutlet UIButton *img_previous_series;
@property(strong,nonatomic)IBOutlet UITableViewCell *cell_series;
@property(strong,nonatomic)IBOutlet UILabel *label_series;
@property(strong,nonatomic)IBOutlet UILabel *label_judul_series;

@property (strong, nonatomic) IBOutlet UILabel *bates_atas1;
@property (strong, nonatomic) IBOutlet UILabel *bates_atas2;

@end
