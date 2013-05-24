//
//  LineChartDatasource.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/23/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CorePlot-CocoaTouch.h>

@interface LineChartDatasource : NSObject <CPTPlotDataSource,CPTPlotDelegate> {
    NSArray* _ratings;
}

-(id)initWithRatings:(NSArray*)ratings;

@end
