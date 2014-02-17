//
//  PlayingCard.m
//  Matchismo
//
//  Created by Albert Chang on 1/22/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "PlayingCard.h"
@implementation PlayingCard

@synthesize suit = _suit; //has to be done when manually describing setter and getter
@synthesize matches = _matches;

+ (NSArray *) validSuits {
    return @[@"♣︎", @"♥︎", @"♦︎", @"♠︎"];
}

+ (NSArray *) validRanks {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [ [self validRanks] count] - 1;
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank])
        _rank = rank;
}

- (void) setSuit:(NSString *)suit{
    if([ [PlayingCard validSuits] containsObject:suit])
        _suit = suit; // the instance variable will be a nil pointer if no match
}

- (NSString *) suit{
    return _suit ? _suit : @"?";
}

- (NSUInteger) matches {
    return _matches;
}

- (NSString *) contents { //OVERRIDE PARENT METHOD
    NSArray *rankStrings = [PlayingCard validRanks];
    return [ rankStrings[self.rank] stringByAppendingString:self.suit ];
}

- (int)match:(NSMutableArray *)chosenCards { //...METHOD OVERRIDING
    
    int score = 0;
    self.matches = 0;
    
    for (int baseIndex = 0; baseIndex < chosenCards.count; baseIndex++) {
        PlayingCard *baseCard = [chosenCards objectAtIndex:baseIndex];

        for (int compareIndex = (baseIndex + 1); compareIndex < chosenCards.count; compareIndex++) {
            int roundScore = 0;
            PlayingCard *compareCard = [chosenCards objectAtIndex:compareIndex];

            if (baseCard.rank == compareCard.rank) {
                roundScore += 4;
            } else if ([baseCard.suit isEqualToString:compareCard.suit]) {
                roundScore += 1;
            }
            
            if (roundScore) {
                score += roundScore;
                self.matches++;
            }
        }
    }
    
    return score;
}

@end
