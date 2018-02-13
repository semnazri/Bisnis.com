//
//  BeritaTableViewCell.h
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/15/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BeritaTableViewCell : UITableViewCell

@property(nonatomic,weak)IBOutlet UIImageView *img_berita;
@property(nonatomic,weak)IBOutlet UILabel     *label_judul_berita;
@property(nonatomic,weak)IBOutlet UILabel     *label_tgl_berita;
@property(nonatomic,weak)IBOutlet UILabel     *label_canal_berita;
@property(nonatomic,weak)IBOutlet UIImageView *img_live;
@property(nonatomic,weak)IBOutlet UIView      *view_judul_berita;
@property(nonatomic,weak)IBOutlet UITableViewCell      *view_head;

@property (strong, nonatomic) IBOutlet UIView *view_latest;

@end
