//
//  PhotoCollectionViewCell.h
//  Cats
//
//  Created by Jimmy Hoang on 2017-06-19.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *photoDescription;

@end
