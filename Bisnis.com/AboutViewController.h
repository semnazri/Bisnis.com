//
//  AboutViewController.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 9/25/14.
//  Copyright (c) 2014 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GPPSignInButton;


@interface AboutViewController : UIViewController


@property (retain, nonatomic) IBOutlet GPPSignInButton *signInButton;


-(IBAction)LOgout:(id)sender;


@end
