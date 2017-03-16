//
//  FixturesTableViewCell.m
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import "FixturesTableViewCell.h"

@implementation FixturesTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)displayCell:(FixturesObject *)fixturesObject {
    NSString *date = fixturesObject.date;
    NSRange range = [date rangeOfString:@"T"];
    date = [date substringToIndex:range.location];
    NSArray *dateNew = [date componentsSeparatedByString:@"-"];
    NSString *year=[dateNew objectAtIndex:0];
    NSString *month=[dateNew objectAtIndex:1];
    NSString *day=[dateNew objectAtIndex:2];
    _lblDate.text = [NSString stringWithFormat:@"%@-%@-%@",day,month,year];
    _lblNameHomeTeam.text = fixturesObject.homeTeamName;
    _lblNameAwayTeam.text = fixturesObject.awayTeamName;
}
@end
