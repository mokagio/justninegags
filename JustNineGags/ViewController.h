//
//  ViewController.h
//  JustNineGags
//
//  Created by Giovanni Lodi on 12/28/12.
//  Copyright (c) 2012 mokagio. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SMWebRequest.h>

@interface ViewController : UIViewController <SMWebRequestDelegate>

@property (nonatomic, strong) IBOutlet UILabel *gagTitle;
@property (nonatomic, strong) IBOutlet UIImageView *gagImageView;
@property (nonatomic, strong) IBOutlet UIButton *loadNewGagButton;

- (IBAction)loadNewGag:(id)sender;

@end
