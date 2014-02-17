//
//  SetViewController.m
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "SetViewController.h"
#import "SetPlayingCardDeck.h"
#import "Card.h"
#import "CardMatchingGame.h"

@interface SetViewController ()
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;

@end

@implementation SetViewController

- (CardMatchingGame *)game { //...GETTER FOR GAME
    if (!_game) {
        _game = [ [CardMatchingGame alloc] initWithCardCount:0
                                                   usingDeck:[self createDeck]
                                       setRequiredMatchCount:4
                                                setGameCount:3 ];
        return (_game);
    }
}


- (Deck *)createDeck {
    return [[SetPlayingCardDeck alloc] init];
}
@end
