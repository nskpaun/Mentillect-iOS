//
//  PieChartDataSource.m
//  Mentillect
//
//  Created by Nathan Spaun on 5/23/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import "PieChartDataSource.h"

@implementation PieChartDataSource

-(id)initWithCurrent:(int)c withMax:(int)m
{
self = [super init];
    if (self) {
        max = m;
        current = c;
    }
    return self;

}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
    return 2;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
    if (CPTPieChartFieldSliceWidth == fieldEnum)
    {
      
    if (index ==0) {
        return [NSNumber numberWithInt:current];
    } else {
        return [NSNumber numberWithInt:(max-current)];
    }
    }
    return [NSDecimalNumber zero];
}


-(NSString *)legendTitleForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index {
    return @"";
}

@end