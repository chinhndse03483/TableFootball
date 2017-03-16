//
//  TableTableViewCell.m
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import "TableTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation TableTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)displayCell:(TableObject *)tableObject;{
    NSNumber *pos = @([tableObject.position intValue]);
    _lblPos.text = [pos stringValue];
    
    
//    _imgAvatar.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:tableObject.crestURI]]];
    
//   
    [_imgAvatar sd_setImageWithURL:[NSURL URLWithString:tableObject.crestURI]
                 placeholderImage:[UIImage imageNamed:@"premier-league-logo"]];
//    
//    [_imgAvatar sd_setShowActivityIndicatorView:YES];
//    [_imgAvatar sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    _lblNameClub.text = tableObject.teamName;
    NSNumber *gamesPlay = @([tableObject.playedGames intValue]);
    _lblPLD.text = [gamesPlay stringValue];
    
    NSNumber *goalDifference = @([tableObject.goalDifference intValue]);
    _lblGD.text = [goalDifference stringValue];
    
    NSNumber *points = @([tableObject.points intValue]);
    _lblPTS.text = [points stringValue];
}
@end
