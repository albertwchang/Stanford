//
//  SetGameViewController.h
//  SetGame
//
//  Created by Administrator on 2/6/14.
//  Copyright (c) 2014 Administrator. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetGameViewController : UIViewController
@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@end
