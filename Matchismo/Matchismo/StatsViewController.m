//
//  StatsViewController.m
//  Matchismo
//
//  Created by Administrator on 2/9/14.
//  Copyright (c) 2014 Towsnap. All rights reserved.
//

#import "StatsViewController.h"
#import "Card.h"

@interface StatsViewController ()
@property (weak, nonatomic) IBOutlet UITextView *gameStatsLabel;
//@property (weak, nonatomic) IBOutlet UILabel *gameStatsLabel;
@end

@implementation StatsViewController

- (void)setGameStats:(NSArray *)gameStats {
    _gameStats = gameStats;
    
    if (self.view.window)
       [self updateUI];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateUI];
}

- (void) updateUI {
    NSMutableString *content = [NSMutableString stringWithFormat:@"Set Card Stats\n"];
    NSMutableAttributedString *attributedContent = [[NSMutableAttributedString alloc] initWithString:content];
    [attributedContent setAttributes:@{NSStrokeWidthAttributeName : @0,
                                       NSBackgroundColorAttributeName : [UIColor orangeColor],
                                       NSForegroundColorAttributeName : [UIColor whiteColor],
                                       NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]
                                    }
                               range:NSMakeRange(0, content.length)
     ];
    
    [attributedContent appendAttributedString:[[NSAttributedString alloc ] initWithString:self.gameStatsInformation ]];
    
    self.gameStatsLabel.attributedText = attributedContent;
}

- (IBAction)scroll:(UISlider *)sender {
}

- (NSString *) gameStatsInformation {
    NSMutableString *stats = [[NSMutableString alloc] init];
    NSArray *roundParameters = @[@"", @"Status", @"Points"];
    int i = 1;
    
    for (NSArray *round in self.gameStats) {
        [stats appendString:[NSString stringWithFormat:@"Round %d: ", i]];
        int element = 1;
        
        for (id roundElement in round) {
            if ([roundElement isKindOfClass:[NSArray class]]) {
                NSArray *cards = (NSArray *)roundElement;
                
                //...CURRENTLY DOESN'T WORK FOR SET GAME YET
                for (Card *card in cards) {
                    [stats appendString:[NSString stringWithFormat:@"%@, ", card.contents]];
                }
            }
            
            else if ([roundElement isKindOfClass:[NSNumber class]]) {
                NSNumber *otherGameParameter = (NSNumber*)roundElement;
                [stats appendString:[NSString stringWithFormat:@"%@: %@, ", roundParameters[element], otherGameParameter]];
                element++;
            }
        }
        
        [stats appendString:@"\n"];
        i++;
    }

    return stats;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
