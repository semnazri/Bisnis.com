//
//  Frame_Berita.m
//  Bisniscom
//
//  Created by Bisnis Indonesia Sibertama on 9/11/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import "Frame_Berita.h"

@implementation Frame_Berita

@synthesize Id_Berita,Judul_Berita,Tgl_Berita,Pukul,Catagory,Img_Berita,Img_Content;

-(id)initWhitId_berita:(long)v_id_berita p_judul_berita:(NSString *)v_judul_berita p_tgl_berita:(NSString *)v_tgl_berita{
    
    self = [super init];

    if(self){
        self.Id_Berita=v_id_berita;
        self.Judul_Berita=v_judul_berita;
        self.Tgl_Berita=v_tgl_berita;
    }
    
    return self;
}

-(id)initWhitId_berita2:(long)v_id_berita p_judul_berita:(NSString *)v_judul_berita p_tgl_berita:(NSString *)v_tgl_berita p_pukul:(NSString *)v_pukul p_catagory:(NSString *)v_catagory p_datepost:(NSString *)v_datepost p_img_berita:(NSString *)v_img_berita p_image_content:(NSString *)v_img_content{
    
    self = [super init];
    if(self){
        self.Id_Berita=v_id_berita;
        self.Judul_Berita=v_judul_berita;
        self.Tgl_Berita=v_tgl_berita;
        self.Pukul=v_pukul;
        self.Catagory=v_catagory;
        self.Datepost=v_datepost;
        self.Img_Berita=v_img_berita;
        self.Img_Content=v_img_content;
    }
    
    return self;
}



@end
