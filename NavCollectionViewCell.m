//
//  NavCollectionViewCell.m
//  Bisnis.com
//
//  Created by Bisnis Indonesia Sibertama on 3/9/15.
//  Copyright (c) 2015 Sibertama. All rights reserved.
//

#import "NavCollectionViewCell.h"

@implementation NavCollectionViewCell

@synthesize grid_front;


-(void)viewDidLoad{
    self.grid_front.delegate=(id)self;
    self.grid_front.dataSource=self;

    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;

}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"grind_front" forIndexPath:indexPath];

    
    return cell;
}

@end
