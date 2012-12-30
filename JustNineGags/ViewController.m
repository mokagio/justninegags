//
//  ViewController.m
//  JustNineGags
//
//  Created by Giovanni Lodi on 12/28/12.
//  Copyright (c) 2012 mokagio. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import "Gag.h"

@interface ViewController ()

@property (nonatomic, strong) MBProgressHUD *downloadingHUD;
@property (nonatomic, assign) NSUInteger currentGagIndex;
@property (nonatomic, strong) NSArray *gags;

- (void)showDownloadingHUD;
- (void)hideDownliadingHUD;

- (void)downloadHotPage;
- (void)downloadComplete:(NSArray *)gags;

- (void)loadGagAtIndex:(NSUInteger)index;

- (BOOL)canGetNewGas;

@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.downloadingHUD = nil;
        self.currentGagIndex = 0;
        self.gags = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self downloadHotPage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadHotPage
{
    [self showDownloadingHUD];
    
    NSURL *url = [NSURL URLWithString:@"http://infinigag.appspot.com/?section=hot"];
    SMWebRequest *request = [SMWebRequest requestWithURL:url delegate:self context:nil];
    [request addTarget:self action:@selector(downloadComplete:) forRequestEvents:SMWebRequestEventComplete];
    [request start];
}

- (void)downloadComplete:(NSArray *)gags
{
    NSLog(@"found %d gags", [gags count]);
    
    // TODO check for 9 gags!
    self.gags = gags;
    
    [self loadGagAtIndex:self.currentGagIndex];
    
    [self hideDownliadingHUD];
}

- (void)showDownloadingHUD
{
    self.downloadingHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.downloadingHUD.mode = MBProgressHUDModeIndeterminate;
    self.downloadingHUD.labelText = @"Downloading...";
}

- (void)hideDownliadingHUD
{
    [self.downloadingHUD hide:YES];
}

- (void)loadGagAtIndex:(NSUInteger)index
{
    Gag *gag = [[Gag alloc] initWithDictionary:[self.gags objectAtIndex:index]];
    
    [self.gagTitle setText:gag.title];
    [self.gagImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:gag.imageURL]]];
}

- (BOOL)canGetNewGas
{
    // DUMMY
    return YES;
}

#pragma mark - UI handleres

- (IBAction)loadNewGag:(id)sender
{
    if (self.currentGagIndex < 9) {
        self.currentGagIndex++;
        [self loadGagAtIndex:self.currentGagIndex];
    } else {
        NSLog(@"will show no more gag for you lazy procrastinator message");
    }
}

#pragma mark - SMWebRequestDelegate

- (id)webRequest:(SMWebRequest *)webRequest resultObjectForData:(NSData *)data context:(id)context
{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSLog(@"%@", dict);
    
    NSArray *gags = [dict objectForKey:@"images"];
    
    return gags;
}

@end
