//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Albert Chang on 1/21/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//  THIS CLASS IS ABSTRACT SUPER CLASS

#import "CardGameViewController.h"
#import "Card.h"
#import "StatsViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) Deck *deck;
@property (nonatomic) NSUInteger gameCount;
@property (nonatomic) NSUInteger matchCount;
@property (strong, nonatomic) NSMutableArray *chosenCards;
@end

//static const int DEFAULT_MATCH_COUNT = 2;
static const int DEFAULT_GAME_COUNT = 3;
static const int DEFAULT_MATCH_COUNT = 1;

@implementation CardGameViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Show Game Stats"]) {
        if([segue.destinationViewController isKindOfClass:[StatsViewController class]]) {
            StatsViewController *svc = (StatsViewController *)segue.destinationViewController;
            svc.gameStats = [self.game gameStats];
        }
    }
}

- (CardMatchingGame *)game {
    if (!_game) {
        if (!self.gameCount) {
            self.gameCount = DEFAULT_GAME_COUNT;
            self.matchCount = DEFAULT_MATCH_COUNT;
        }

        _game = [ [CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                   usingDeck:self.createDeck
                                       setRequiredMatchCount:DEFAULT_MATCH_COUNT
                                                setGameCount:self.gameCount];
    }
    
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int buttonIndex = [self.cardButtons indexOfObject:sender];
    
    [self.game chooseCardAtIndex:buttonIndex];
    [self updateUI]; //KEEP MODEL SYNCED UP WITH CHANGES TO MODEL
}

- (void)updateGameStats:(Card *)currentCard{
    
}

- (void)updateUI { //SET THE STATE OF EACH CARD
//
}

- (NSString *)titleForCard:(Card *)selectedCard {
    return selectedCard.isChosen ? selectedCard.contents : @"";
}

- (IBAction)switchMatchMode:(UISegmentedControl *)sender { //LOCK SWITCH WHEN A MATCH HAS OCCURRED
    
    NSUInteger selectedSegmentIndex = sender.selectedSegmentIndex;
    
    if (selectedSegmentIndex == 0) {
        self.game.gameCount = 2;
        self.gameCount = 2;
    }
    
    else if (selectedSegmentIndex == 1) {
        self.game.gameCount = 3;
        self.gameCount = 3;
    }
}

- (UIImage *)imageForCard:(Card *)selectedCard {
    return [UIImage imageNamed:selectedCard.isChosen ? @"cardfront" : @"cardback"];
}

- (IBAction)resetGame:(UIButton *)sender {
    self.game = nil;
    [self updateUI];
}

- (Deck *) createDeck {
    return nil;
}
            
@end
