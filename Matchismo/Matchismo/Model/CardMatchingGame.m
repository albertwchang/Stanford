//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Albert Chang on 1/23/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score; //NECESSARY WHEN THE PUBLIC API IS 'READONLY'. READWRITE IS PRIVATE
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic) NSUInteger minMatchCount;
@end

@implementation CardMatchingGame

-(NSMutableArray *)cards { //LAZY INSTATIATION
    if (!_cards) {
        _cards = [ [ NSMutableArray alloc] init];
    }
    return _cards;
}

-(instancetype) init {
    return nil;
}

//BUILD ARRAY OF CARDS WHEN INITIALIZING INSTANCE
-(instancetype) initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
            setRequiredMatchCount:(NSUInteger)matchCount
                     setGameCount:(NSUInteger)gameCount {
    self = [super init];
    
    if(self) {
        self.minMatchCount = matchCount;
        self.gameCount = gameCount;
        for(int i = 0; i < count; i++) {
            Card *card = [ deck drawRandomCard ];
            
            if(card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
        self.gameStats = [[NSMutableArray alloc] init];
        self.chosenCards = [[NSMutableArray alloc] init];
    }
    
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHANGE = 1;

//...FETCH CARD FROM CREATED ARRAY OF CARDS
-(void)chooseCardAtIndex:(int)index {
    Card *currentCard = [self cardAtIndex:index];
    self.gameStarted = YES;
    
    //...FLIP BACK A FLIPPED CARD
    if (!currentCard.isMatched) {
        if (currentCard.isChosen) {
            currentCard.chosen = NO;
            [self.chosenCards removeLastObject];
        }
        
        else {
            [self.chosenCards addObject:currentCard];
            
            if ( self.chosenCardCount == self.gameCount) {
                BOOL sufficientMatches = NO;
                int matchScore = [ currentCard match:self.chosenCards ];
                
                //...SUFFICIENT MATCHES
                if (currentCard.matches >= self.minMatchCount) {
                    
                    matchScore = matchScore * MATCH_BONUS;
                    currentCard.matched = YES;
                    sufficientMatches = YES;

                    //SET APPROPRIATE CARDS OF THE GAME WITH ISMATCHED = YES
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen)
                            otherCard.matched = YES;
                    }
                }
                
                //...INSUFFICIENT MATCHES
                else {
                    matchScore = (0 - MISMATCH_PENALTY);
                    
                    for (Card *otherCard in self.cards) {
                        if (otherCard.isChosen && !otherCard.isMatched)
                            otherCard.chosen = NO;
                    }
                    
                }
                
                self.score += matchScore;
                NSNumber *scoreToAdd = [NSNumber numberWithInt:matchScore];
                
                [self createMatchRound:[self.chosenCards copy]
                           matchStatus:([NSNumber numberWithBool:sufficientMatches])
                          pointsEarned:(NSNumber *)scoreToAdd];
                
                [self.chosenCards removeAllObjects];
                
                if (!sufficientMatches)
                    [self.chosenCards addObject:currentCard];

            } //...END IF
            
            else //...HAVE NOT MET MATCH CARD COUNT
                self.score -= COST_TO_CHANGE;
            
            currentCard.chosen = YES; // DON'T SET CHOSEN VARIABLE IN ARRAY
        }
    }
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(NSUInteger)chosenCardCount {
    return self.chosenCards.count;
}

-(void)createMatchRound:(NSArray *)chosenCards
            matchStatus:(NSNumber *)status
           pointsEarned:(NSNumber *)points {
    
    //add NSMutableArray to History array
    NSMutableArray *round = [[NSMutableArray alloc] init];
    [round addObject:chosenCards];
    [round addObject:status];
    [round addObject:points];
    [self.gameStats addObject:round];
}

@end