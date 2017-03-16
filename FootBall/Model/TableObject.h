//
//  TableObject.h
//  FootBall
//
//  Created by Chính Nguyen on 3/16/17.
//  Copyright © 2017 Thehegeo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableObject : NSObject
@property (nonatomic, strong) NSString *position;
@property (nonatomic, strong) NSString *teamName;
@property (nonatomic, strong) NSString *crestURI;
@property (nonatomic, strong) NSString *playedGames;
@property (nonatomic, strong) NSString *points;
@property (nonatomic, strong) NSString *goals;
@property (nonatomic, strong) NSString *goalsAgainst;
@property (nonatomic, strong) NSString *goalDifference;
@property (nonatomic, strong) NSString *wins;
@property (nonatomic, strong) NSString *draws;
@property (nonatomic, strong) NSString *losses;
- (instancetype)initWithJson:(NSDictionary *)jsonDict;
@end
