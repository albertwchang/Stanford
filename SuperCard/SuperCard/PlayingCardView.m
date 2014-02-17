//
//  PlayingCardView.m
//  SuperCard
//
//  Created by Administrator on 2/13/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import "PlayingCardView.h"
@interface PlayingCardView()
@property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView
#pragma mark - CONSTANTS
#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90
#define CORNER_FONT_STANDARD_HEIGHT 180.0
#define CORNER_RADIUS 12.0

#pragma mark - PROPERTIES
@synthesize faceCardScaleFactor = _faceCardScaleFactor; // ALWAYS SYNTHESIZE WHEN THE GETTER AND SETTER IS SET MANUALLY

- (CGFloat)faceCardScaleFactor
{
    if (!_faceCardScaleFactor)
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    
    return _faceCardScaleFactor;
}

- (void)setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor
{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

- (void)setSuit:(NSString *)suit
{
    _suit = suit;
    [self setNeedsDisplay];
}

- (void)setRank:(NSUInteger)rank
{
    _rank = rank;
    [self setNeedsDisplay];
}

- (void)setFaceUp:(BOOL)faceUp
{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

#pragma mark - METHODS
- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) || (gesture.state == UIGestureRecognizerStateEnded)) {
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
}

- (CGFloat)cornerScaleFactor { return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT; }
- (CGFloat)cornerRadius { return CORNER_RADIUS * [self cornerScaleFactor]; }
- (CGFloat)cornerOffset { return [self cornerRadius] / 3.0; }
// - (CGFloat)cornerOffset { return 5; }

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@"PlayingCardView drawRect starts");
    //...DRAWING CODE
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    [roundedRect fill];
    //UIRectFill(self.bounds);
    
    [[UIColor redColor] setStroke];
    [roundedRect stroke];
    
    //...SET THE CARD CONTENTS
    if (self.faceUp) {
        UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", self.rankAsString, self.suit]];
        
        if (faceImage) {
            CGRect imageRect = CGRectInset (self.bounds,
                                            self.bounds.size.width * (1.0 - self.faceCardScaleFactor),
                                            self.bounds.size.height * (1.0 - self.faceCardScaleFactor));
                                            //...1 = NOTHING, 0 = FULL
            [faceImage drawInRect:imageRect];
        }
        
        else
            [self drawPips];
        
        [self drawCorners];
    }
    
    else {
        [[UIImage imageNamed:@"cardback"] drawInRect:self.bounds];
    }
}

- (void)drawPips
{
    
}

- (NSString *) rankAsString
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"][self.rank];
}

- (void)drawCorners
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    //[cornerFont fontWithSize:cornerFont.pointSize*[self cornerScaleFactor]];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize*[self cornerScaleFactor]];
    
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], self.suit] attributes:@{NSFontAttributeName : cornerFont, NSParagraphStyleAttributeName : paragraphStyle }];
    
    CGRect textBounds = CGRectMake(self.cornerOffset, self.cornerOffset, cornerText.size.width, cornerText.size.height);
    /*
    CGRect textBounds;
    textBounds.origin = CGPointMake(self.cornerOffset, self.cornerOffset);
    textBounds.size = cornerText.size;
     */
    [cornerText drawInRect:textBounds];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
    [cornerText drawInRect:textBounds];
}

#pragma mark - INITIALIZATION
- (void)setup
{
    self.backgroundColor = nil;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    NSLog(@"PlayingCardView Setup starts");
}

- (void) awakeFromNib
{
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

@end
