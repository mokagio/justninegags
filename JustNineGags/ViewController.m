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

- (void)showDownloadingHUD;
- (void)hideDownliadingHUD;

- (void)downloadHotPage;
- (void)downloadComplete:(NSArray *)gags;

@end

@implementation ViewController

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
    
    Gag *gag = [[Gag alloc] initWithDictionary:[gags objectAtIndex:0]];
    
    [self.gagTitle setText:gag.title];
    [self.gagImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:gag.imageURL]]];
    
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

#pragma mark - UI handleres

- (IBAction)loadNewGag:(id)sender
{
    NSLog(@"will load new gag");
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
