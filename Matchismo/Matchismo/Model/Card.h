//
//  Card.h
//  Matchismo
//
//  Created by Albert Chang on 1/22/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) bool matched;
@property (nonatomic) NSUInteger matches;

@property (strong, nonatomic) NSString *contents;

-(int)match:(NSMutableArray *)otherCards;
@end
