//
//  PNLineChart.h
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define chartMargin     10
#define xLabelMargin    15
#define yLabelMargin    15
#define yLabelHeight    11

@interface PNLineChart : UIView

/**
 * This method will call and troke the line in animation
 */

-(void)strokeChart;

@property (strong, nonatomic) NSArray * xLabels;

@property (strong, nonatomic) NSArray * yLabels;//范围在一亿以内

@property (strong, nonatomic) NSArray * yValues;

@property (nonatomic) CGFloat xLabelWidth;

@property (nonatomic) int yValueMax;

@property (nonatomic,strong) CAShapeLayer * chartLine;

@property (nonatomic, strong) UIColor * strokeColor;

@property (nonatomic, strong) NSMutableArray * pointBtnArray;//将每个节点装载

@property (nonatomic, strong) UILabel* maxValueLabel;//最大值

@end
