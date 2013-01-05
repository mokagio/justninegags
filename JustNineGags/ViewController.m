//
//  ViewController.m
//  JustNineGags
//
//  Created by Giovanni Lodi on 12/28/12.
//  Copyright (c) 2012 mokagio. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import <Reachability.h>
#import "Gag.h"

static NSString *const TIMESTAMP_FILE_NAME = @"timestamp.plist";

@interface ViewController ()

@property (nonatomic, strong) MBProgressHUD *downloadingHUD;
@property (nonatomic, assign) NSUInteger currentGagIndex;
@property (nonatomic, strong) NSArray *gags;

- (void)showDownloadingHUD;
- (void)hideDownliadingHUD;

- (void)downloadHotPage;
- (void)downloadComplete:(NSArray *)gags;

- (void)loadGagAtIndex:(NSUInteger)index;

- (void)showNoMoreCatsMessage;

- (BOOL)canGetNewGas;

- (BOOL)hasOneHourPassed;
- (void)updateTime;
- (NSString *)timestampFilePath;

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
    
    Reachability *reachable = [Reachability reachabilityForInternetConnection];
    
    if ([reachable isReachable]) {
        if ([self canGetNewGas]) {
            [self downloadHotPage];
            [self updateTime];
        } else {
            [self showNoMoreCatsMessage];
        }

    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NO CONNECTION"
                                                        message:@"There's not internet connection...\nHow am I supposed to get your gets without connection?!"
                                                       delegate:nil
                                              cancelButtonTitle:@"SORRY"
                                              otherButtonTitles:nil];
        [alert show];
    }
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

- (void)showNoMoreCatsMessage
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"NO MORE GAGS"
                                                    message:@"No more gags for you lazy procrastinator.\nCome back in a while"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)loadGagAtIndex:(NSUInteger)index
{
    Gag *gag = [[Gag alloc] initWithDictionary:[self.gags objectAtIndex:index]];
    
    [self.gagTitle setText:gag.title];
    [self.gagImageView setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:gag.imageURL]]];
}

- (BOOL)canGetNewGas
{
#ifdef DEVELOPMENT
    return true;
#endif
    return [self hasOneHourPassed];
}

#pragma mark - Data persistance

- (BOOL)hasOneHourPassed
{
    NSString *filePath = [self timestampFilePath];

    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        
        NSDictionary *timeDict = [NSDictionary dictionaryWithContentsOfFile:filePath];
        NSTimeInterval lastTimestamp = [[timeDict objectForKey:@"timestamp"] floatValue];
        
        if ([[NSDate date] timeIntervalSince1970] - lastTimestamp >= 3600) {
            return YES;
        } else {
            return NO;
        }
    } else {
        return YES;
    }
}

- (void)updateTime
{
    NSDictionary *timeDict = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:[[NSDate date] timeIntervalSince1970]] forKey:@"timestamp"];
    [timeDict writeToFile:[self timestampFilePath] atomically:YES];
}

- (NSString *)timestampFilePath
{
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) lastObject];
    NSString *filePath = [rootPath stringByAppendingPathComponent:TIMESTAMP_FILE_NAME];
    
    return filePath;
}

#pragma mark - UI handleres

- (IBAction)loadNewGag:(id)sender
{
    self.currentGagIndex++;
    
    if (self.currentGagIndex < [self.gags count] && self.currentGagIndex < 9) {
        [self loadGagAtIndex:self.currentGagIndex];
    } else {
        [self showNoMoreCatsMessage];
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
