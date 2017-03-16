//
//  TableObject.m
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import "TableObject.h"

@implementation TableObject
- (instancetype)initWithJson:(NSDictionary *)jsonDict;
{
    self = [super init];
    
    if (self) {
        _position = jsonDict[@"position"];
        _teamName = jsonDict[@"teamName"];
        _crestURI = jsonDict[@"crestURI"];
        _playedGames = jsonDict[@"playedGames"];
        _points = jsonDict[@"points"];
        _goals = jsonDict[@"goals"];
        _goalsAgainst = jsonDict[@"goalsAgainst"];
        _goalDifference = jsonDict[@"goalDifference"];
        _wins = jsonDict[@"wins"];
        _draws = jsonDict[@"draws"];
        _losses = jsonDict[@"losses"];

    }
    
    return self;
}
@end
