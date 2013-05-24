//
//  LineChartDatasource.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/23/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "LineChartDatasource.h"
#import "Rating.h"


@implementation LineChartDatasource

-(id)initWithRatings:(NSArray *)ratings
{
    self = [super init];
    if (self) {
        _ratings = ratings;
    }
    return self;
    
}

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    return _ratings.count;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)idx
{
    Rating *rating = [_ratings objectAtIndex:idx];
    if ( fieldEnum == CPTScatterPlotFieldX ) {
        return [NSNumber numberWithInt:idx];
    } else {
        return rating.number;
    }
}

@end
