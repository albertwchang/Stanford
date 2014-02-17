//
//  PlayerCardGameViewController.m
//  Matchismo
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "PlayerCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayerCardGameViewController ()
@end

@implementation PlayerCardGameViewController

- (Deck *) createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void) updateUI {
    NSLog(@"-------------------");
    NSLog(@"Beginning UpdateUI");
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self imageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    
    self.gameModeButton.enabled = !self.game.gameStarted;
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    NSLog(@"Ending updateUI");
}

@end
