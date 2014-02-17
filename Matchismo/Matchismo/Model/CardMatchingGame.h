//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Albert Chang on 1/23/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

//Designated initializer
-(instancetype) initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
            setRequiredMatchCount:(NSUInteger)minMatchCount
                     setGameCount:(NSUInteger)gameCount;

-(void)chooseCardAtIndex:(NSInteger)index; //USER CHOOSES CARD
-(Card *)cardAtIndex:(NSUInteger)index; //GAME RETURNS THE CHOSEN CARD
-(NSUInteger)chosenCardCount;

@property (nonatomic) NSUInteger gameCount;
@property (nonatomic, strong) NSMutableArray *gameStats;
@property (nonatomic) BOOL gameStarted;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSMutableArray *chosenCards;
@end
