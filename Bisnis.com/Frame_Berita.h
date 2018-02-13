//
//  Frame_Berita.h
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/11/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Frame_Berita : NSObject

@property long Id_Berita;
@property(strong)NSString *Judul_Berita;
@property(strong)NSString *Tgl_Berita;
@property(strong)NSString *Pukul;
@property(strong)NSString *Catagory;
@property(strong)NSString *Datepost;
@property(strong)NSString *Img_Berita;
@property(strong)NSString *Img_Content;



-(id)initWhitId_berita:(long) v_id_berita p_judul_berita:(NSString *)v_judul_berita p_tgl_berita:(NSString *)v_tgl_berita;
-(id)initWhitId_berita2:(long)v_id_berita p_judul_berita:(NSString *)v_judul_berita p_tgl_berita:(NSString *)v_tgl_berita p_pukul:(NSString *)v_pukul p_catagory:(NSString *)v_catagory p_datepost:(NSString *)v_datepost p_img_berita:(NSString *)v_img_berita p_image_content:(NSString *)v_img_content;

@end
