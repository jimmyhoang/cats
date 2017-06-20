//
//  Photo.h
//  Cats
//
//  Created by Jimmy Hoang on 2017-06-19.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property (nonatomic, strong) NSString* photoDescription;
@property (nonatomic, strong) NSURL* photoURL;
@property (nonatomic, strong) UIImage* photo;

- (instancetype)initWithDictionary:(NSDictionary*)dictionary;
-(void)getImage;

@end
