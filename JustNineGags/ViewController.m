//
//  ViewController.m
//  JustNineGags
//
//  Created by Giovanni Lodi on 12/28/12.
//  Copyright (c) 2012 mokagio. All rights reserved.
//

#import "ViewController.h"
#import <MBProgressHUD.h>
#import "SMWebRequest.h"

@interface ViewController ()
- (void)downloadHotPage;
- (void)downloadComplete:(NSData *)data;
- (void)parseInfinigagData:(NSData *)data;
- (void)parseInfinigagDataCompleted:(NSArray *)gags;
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
    NSURL *url = [NSURL URLWithString:@"http://infinigag.appspot.com/?section=hot"];
    SMWebRequest *request = [SMWebRequest requestWithURL:url];
    [request addTarget:self action:@selector(downloadComplete:) forRequestEvents:SMWebRequestEventComplete];
    [request start];
}

- (void)downloadComplete:(NSData *)data
{
    // use a background thread ;)
    [self performSelectorInBackground:@selector(parseInfinigagData:) withObject:data];
}

- (void)parseInfinigagData:(NSData *)data
{
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    NSLog(@"%@", dict);
    
    NSArray *gags = [dict objectForKey:@"images"];
    
    // parsing finished we can work on the main thread again
    [self performSelector:@selector(parseInfinigagDataCompleted:) withObject:gags];
}

- (void)parseInfinigagDataCompleted:(NSArray *)gags
{
    NSLog(@"found %d gags", [gags count]);
}

#pragma mark - UI handleres

- (IBAction)loadNewGag:(id)sender
{
    NSLog(@"will load new gag");
}

@end
