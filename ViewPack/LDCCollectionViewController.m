//
//  LDCCollectionViewController.m
//  ViewPack
//
//  Created by 大畅 on 13-8-15.
//  Copyright (c) 2013年 大畅. All rights reserved.
//

#import "LDCCollectionViewController.h"
#import "FlickrPhoto.h"
#import "LDCCollectionViewCell.h"
#import "MBProgressHUD.h"

@interface LDCCollectionViewController ()

@property (nonatomic, strong) NSMutableDictionary *searchResults;
@property (nonatomic, strong) NSMutableArray *searches;
@property (nonatomic, strong) Flickr *flickr;

@end

@implementation LDCCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customInit];
    [self customUIInit];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)customInit
{
    self.searches = [@[] mutableCopy];
    self.searchResults = [@{} mutableCopy];
    self.flickr = [[Flickr alloc] init];
    self.flickr.delegate = self;
    
    self.textField.delegate = self;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"LDCColllectionViewCell" bundle:[NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"FlickrCell"];
    
}

- (void)customUIInit
{
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_cork.png"]];
    
    UIImage *navBarImage = [[UIImage imageNamed:@"navbar.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(27, 27, 27, 27)];
    [self.toolbar setBackgroundImage:navBarImage forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIImage *sharedButtonImage = [[UIImage imageNamed:@"collectionButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    [self.shareButton setBackButtonBackgroundImage:sharedButtonImage forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *textFieldImage = [[UIImage imageNamed:@"search_field.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [self.textField setBackground:textFieldImage];
}


#pragma mark - action

- (IBAction)shareButtonPressed:(id)sender
{
    //add
}

#pragma mark - UITextField delegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
    // 1
    [self.flickr searchFlickrForTerm:textField.text completionBlock:^(NSString *searchTerm, NSArray *results, NSError *error) {
        if(results && ([results count] > 0)) {
            // 2
            if(![self.searches containsObject:searchTerm]) {
                NSLog(@"Found %d photos matching %@", [results count],searchTerm);
                [self.searches insertObject:searchTerm atIndex:0];
                self.searchResults[searchTerm] = results; }
            // 3
            dispatch_async(dispatch_get_main_queue(), ^{
                [_progressHUD hide:YES];
                [self.collectionView reloadData];
            });
        } else { // 1
            NSLog(@"Error searching Flickr: %@", error.localizedDescription);
        } }];
    [textField resignFirstResponder];
    return YES; 
}

#pragma mark - UICollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSString *searchTerm = self.searches[section];
    return [self.searchResults[searchTerm] count];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [self.searches count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //There is no default UICollectionViewCell , must customize it.
    LDCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FlickrCell" forIndexPath:indexPath];
    NSString *searchTerm = self.searches[indexPath.section];
    cell.photo = self.searchResults[searchTerm][indexPath.row];
    return cell;
}

#pragma mark - UICollectionViewFlowLayoutDelegate

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *searchItem = self.searches[indexPath.section];
    FlickrPhoto *photo = self.searchResults[searchItem][indexPath.row];
    
    CGSize retval = photo.thumbnail.size.width > 0 ? photo.thumbnail.size: CGSizeMake(100, 100);
    retval.height += 35;
    retval.width += 35;
    return retval;
}
//border
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(50, 20, 50, 20);
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //add
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //add
}

#pragma mark - flickr delegate

- (void)showHUD
{
    NSLog(@"HUD");
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.collectionView animated:YES];
    _progressHUD.mode = MBProgressHUDModeCustomView;
    _progressHUD.labelText = @"Loading";
}

@end
