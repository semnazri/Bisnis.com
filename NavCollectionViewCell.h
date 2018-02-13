//
//  NavCollectionViewCell.h
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/9/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NavCollectionViewCell : UITableViewCell <UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *grid_front;

@end
