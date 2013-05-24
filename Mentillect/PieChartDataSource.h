//
//  PieChartDataSource.h
//  Mentillect
//
//  Created by Nathan Spaun on 5/23/13.
//  Copyright (c) 2013 Instru.mental. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CorePlot-CocoaTouch.h>

@interface PieChartDataSource : NSObject <CPTPieChartDataSource>{
    int max;
    int current;
}

-(id)initWithCurrent:(int)c withMax:(int)m;

@end
