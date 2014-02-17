//
//  SetPlayingCard.m
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "SetPlayingCard.h"

@implementation SetPlayingCard
@synthesize suit = _suit;
@synthesize matches = _matches;

+ (NSArray *) validSuits {
    return @[@"▲", @"●", @"◼︎"];
}

- (void) setSuit:(NSString *)suit {
    if ([[SetPlayingCard validSuits] containsObject:suit])
        _suit = suit;
}

- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (NSUInteger) matches {
    return _matches;
}

- (int) match:(NSArray *) chosenCards {
    int score = 0;
    //insert algorithm
    return score;
}

@end