//
//  PlayingCard.h
//  Matchismo
//
//  Created by Albert Chang on 1/22/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *) validSuits;
+(NSArray *) validRanks;
+(NSUInteger) maxRank;

@end