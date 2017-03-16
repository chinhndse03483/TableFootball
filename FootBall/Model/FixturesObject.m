//
//  FixturesObject.m
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import "FixturesObject.h"

@implementation FixturesObject
- (instancetype)initWithJson:(NSDictionary *)jsonDict;
{
    self = [super init];
    
    if (self) {
        _date = jsonDict[@"date"];
        _status = jsonDict[@"status"];
        _matchday = jsonDict[@"matchday"];
        _homeTeamName = jsonDict[@"homeTeamName"];
        _awayTeamName = jsonDict[@"awayTeamName"];
        _result = jsonDict[@"result"];
        _odds = jsonDict[@"odds"];

        
    }
    
    return self;
}
@end
