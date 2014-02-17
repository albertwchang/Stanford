//
//  SetPlayingCard.h
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "Card.h"

@interface SetPlayingCard : Card
@property (nonatomic, strong) NSString *suit;
@property (nonatomic) NSUInteger matches;

+ (NSArray *) validSuits;
- (void) setSuit:(NSString *)suit;
- (NSString *) suit;
- (NSUInteger) matches;
- (int) match: (NSArray *) chosenCards;

@end
