//
//  Photo.m
//  Cats
//
//  Created by Jimmy Hoang on 2017-06-19.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
// https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg

#import "Photo.h"

@implementation Photo

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        _photoDescription = dictionary[@"title"];
        _photoURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@.jpg",dictionary[@"farm"],dictionary[@"server"],dictionary[@"id"],dictionary[@"secret"]]];
        [self getImage];
    }
    return self;
}

-(void)getImage {
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDownloadTask* downloadTask = [session downloadTaskWithURL:self.photoURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
            return;
        }
        
        NSData* data = [NSData dataWithContentsOfURL:location];
        UIImage* image = [UIImage imageWithData:data];
        _photo = image;
    }];
    
    [downloadTask resume];
}

@end
