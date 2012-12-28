//
//  Gag.m
//  JustNineGags
//
//  Created by Giovanni Lodi on 12/28/12.
//  Copyright (c) 2012 mokagio. All rights reserved.
//

#import "Gag.h"

@implementation Gag

- (id)init
{
    self = [super init];
    if (self) {
        self.gagURL = nil;
        self.imageURL = nil;
        self.title = nil;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [self init];
    if (self) {
        self.gagURL = [NSURL URLWithString:[dict objectForKey:@"url"]];
        self.imageURL = [NSURL URLWithString:[[dict objectForKey:@"image"] objectForKey:@"big"]];
        self.title = [dict objectForKey:@"title"];
    }
    return self;
}

@end
