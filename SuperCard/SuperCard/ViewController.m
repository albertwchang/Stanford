//
//  ViewController.m
//  SuperCard
//
//  Created by Administrator on 2/13/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "ViewController.h"
#import "PlayingCardView.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;
@property (strong, nonatomic) Deck *deck;
@end

@implementation ViewController

-(Deck *) deck {
    if (!_deck)
        _deck = [[PlayingCardDeck alloc] init];
    
    return _deck;
}

- (void)drawRandomPlayingCard {
    Card *card = [self.deck drawRandomCard];
    
    if ([card isKindOfClass:[PlayingCard class]]) {
        PlayingCard *currentCard = (PlayingCard *)card;
        self.playingCardView.rank = currentCard.rank;
        self.playingCardView.suit = currentCard.suit;
    }
}

- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    if (!self.playingCardView.faceUp)
        [self drawRandomPlayingCard];
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"viewDidLoad starts");
    [self drawRandomPlayingCard];
    UIPinchGestureRecognizer *pinching = [[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:)];
    [self.playingCardView addGestureRecognizer:pinching];
}

@end
