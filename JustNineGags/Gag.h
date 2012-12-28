//
//  Gag.h
//  JustNineGags
//
//  Created by Giovanni Lodi on 12/28/12.
//  Copyright (c) 2012 mokagio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gag : NSObject

@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSURL *gagURL;

- (id)initWithDictionary:(NSDictionary *)dict;

@end
