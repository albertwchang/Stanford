//
//  GameView.m
//  Matchismo
//
//  Created by albertwchang on 2/17/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "GameView.h"
#import "Grid.h"

@interface GameView()
@property (strong, nonatomic) NSMutableArray *cardViews;
@property (strong, nonatomic) Grid *gridInfo;
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation GameView
#pragma mark - CONSTANTS
#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

#pragma mark - PROPERTIES
@synthesize faceCardScaleFactor = _faceCardScaleFactor;

#pragma mark - SETTERS
- (void) setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor {
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

#pragma mark - GETTERS
- (CGFloat) faceCardScaleFactor {
    if (!_faceCardScaleFactor)
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    
    return _faceCardScaleFactor;
}

- (NSMutableArray *)cards {
    if (!_cards)
        _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}

- (NSMutableArray *)cardViews {
    if (!_cardViews)
        _cardViews = [[NSMutableArray alloc] init];
    
    return _cardViews;
}

- (Grid *)gridInfo {
    if (!_gridInfo)
        _gridInfo = [[Grid alloc] init];
    
    return _gridInfo;
}

#pragma mark - METHODS

 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
 // Drawing code
     UIBezierPath *canvas = [UIBezierPath bezierPathWithRect:self.bounds];
    
    [[UIColor greenColor] setFill];
    [canvas fill];
    
    [[UIColor blackColor] setStroke];
    [canvas stroke];
}

- (void)addCardsToCanvas {
    for (id obj in self.cards) {
        if ([obj isKindOfClass:[Card class]]) {
            Card *currentCard = (Card *)obj;
            UIView *cardView = [self buildCardView:currentCard];
            [self.cardViews addObject:cardView];
        }
    }
}

- (UIView *)buildCardView:(Card *)currentCard {
    //superclass method
    return nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void) awakeFromNib {
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

@end
