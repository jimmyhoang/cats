//
//  ViewController.m
//  Cats
//
//  Created by Jimmy Hoang on 2017-06-19.
//  Copyright © 2017 Jimmy Hoang. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray* photosArray;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photosArray = [NSMutableArray array];
    [self fetchFromAPI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helpers
-(void)fetchFromAPI {
    NSURL* url = [NSURL URLWithString:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&format=json&nojsoncallback=1&api_key=27bfb2c750d8d85682e0b6580398c7ab&tags=cat"];
    NSURLRequest* urlRequest = [[NSURLRequest alloc] initWithURL:url];
    
    NSURLSessionConfiguration* configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession* session = [NSURLSession sessionWithConfiguration:configuration];
    
    NSURLSessionDataTask* dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"error: %@",error.localizedDescription);
            return;
        }
        
        NSError* jsonError;
        NSDictionary* photos = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"json error: %@",jsonError.localizedDescription);
            return;
        }
        
        NSDictionary* photos2 = [photos objectForKey:@"photos"];
        NSArray* photoArray = [photos2 objectForKey:@"photo"];
        
        for (NSDictionary* dictionary in photoArray) {
            [self.photosArray addObject:[[Photo alloc] initWithDictionary:dictionary]];
        }
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^ {
            [self.collectionView reloadData];
        }];
        
    }];    
    [dataTask resume];
}

#pragma mark - Collection View

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PhotoCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    Photo* photo = self.photosArray[indexPath.row];
    cell.photoImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    cell.photoDescription.text = photo.photoDescription;
    cell.photoImageView.image = photo.photo;

    return cell;
}




@end
