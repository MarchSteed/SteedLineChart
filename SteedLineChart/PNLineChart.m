//
//  PNLineChart.m
//  PNChartDemo
//
//  Created by kevin on 11/7/13.
//  Copyright (c) 2013年 kevinzhow. All rights reserved.
//

#import "PNLineChart.h"
#import "PNColor.h"
#import "PNChartLabel.h"

@implementation PNLineChart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
		_chartLine = [CAShapeLayer layer];
		_chartLine.lineCap = kCALineCapRound;
		_chartLine.lineJoin = kCALineJoinRound;
		_chartLine.fillColor   = [[UIColor whiteColor] CGColor];
		_chartLine.lineWidth   = 3.0;
		_chartLine.strokeEnd   = 0.0;
		[self.layer addSublayer:_chartLine];
    }
    
    return self;
}

-(void)setYValues:(NSArray *)yValues
{
    _yValues = yValues;
    [self setYLabels:yValues];
}

-(void)setYLabels:(NSArray *)yLabels
{
    NSInteger max = 0;
    for (NSString * valueString in yLabels) {
        NSInteger value = [valueString integerValue];
        if (value > max) {
            max = value;
        }
        
    }
    
    //Min value for Y label
    if (max < 5) {
        max = 5;
    }
    
    _yValueMax = (int)max;
    
    float level = max /5.0;
	
    NSInteger index = 0;
	NSInteger num = [yLabels count] + 1;
	while (num > 0) {
		CGFloat chartCavanHeight = self.frame.size.height - chartMargin * 2 - 40.0 ;
		CGFloat levelHeight = (chartCavanHeight - 20.0) /5.0;
        
//                     point = CGPointMake(index * xPosition  + 30.0 + _xLabelWidth /2.0, chartCavanHeight - grade * (chartCavanHeight - 20) + 20.0);
        
		PNChartLabel * label = [[PNChartLabel alloc] init];
        
        label.frame = CGRectMake(0.0,self.frame.size.height - 10 - 20 - index * levelHeight -yLabelHeight - 4 , 46.0, yLabelHeight);
        
		[label setTextAlignment:NSTextAlignmentCenter];
//        label.backgroundColor = [UIColor redColor];
		label.text = [NSString stringWithFormat:@"%1.f",level * index];
		[self addSubview:label];
        index +=1 ;
		num -= 1;
	}
    
//    self.backgroundColor = [UIColor blueColor];

}

-(void)setXLabels:(NSArray *)xLabels
{
    _xLabels = xLabels;
    _xLabelWidth = (self.frame.size.width - chartMargin - 30.0 - ([xLabels count] -1) * xLabelMargin)/5.0;
    
    for (NSString * labelText in xLabels) {
        NSInteger index = [xLabels indexOfObject:labelText];
        PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(index * (xLabelMargin + _xLabelWidth) + 30.0, self.frame.size.height - 30.0, _xLabelWidth, 20.0)];
        [label setTextAlignment:NSTextAlignmentCenter];
        label.text = labelText;
        [self addSubview:label];
//        label.backgroundColor = [UIColor greenColor];
    }
    
}

-(void)setStrokeColor:(UIColor *)strokeColor
{
	_strokeColor = strokeColor;
	_chartLine.strokeColor = [strokeColor CGColor];
}

-(void)strokeChart
{
    
//    self.backgroundColor = [UIColor redColor];
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    
    CGFloat xPosition = (xLabelMargin + _xLabelWidth);
    
    CGFloat chartCavanHeight = self.frame.size.height - chartMargin * 2 - 40.0;
    
    NSInteger index = 0;
    for (NSString * valueString in _yValues) {
        NSInteger value = [valueString integerValue];
        
        float grade = (float)value / (float)_yValueMax;
        
        CGPoint point;
        
        
        //添加按钮
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 4.5;
        btn.backgroundColor = PNGreen;
        [self addSubview:btn];
        
        point = CGPointMake(index * xPosition  + 30.0 + _xLabelWidth /2.0, chartCavanHeight - grade * (chartCavanHeight - 20) + 20.0);
        
        if (!self.pointBtnArray) {
            self.pointBtnArray = [NSMutableArray array];
        }else{
            [self.pointBtnArray removeAllObjects];
        }
        
        [self.pointBtnArray addObject:btn];
        
        if (index != 0) {
            
            //PNChartLabel * label = [[PNChartLabel alloc] initWithFrame:CGRectMake(index * (xLabelMargin + _xLabelWidth) + 30.0, self.frame.size.height - 30.0, _xLabelWidth, 20.0)];
            
            [progressline addLineToPoint:point];
            
//            [progressline moveToPoint:CGPointMake(index * xPosition + 30.0 + _xLabelWidth /2.0, chartCavanHeight - grade * chartCavanHeight + 20.0 )];
            
//            [progressline stroke];
        } else {
            
            [progressline moveToPoint:point];
            
        }
        
        btn.frame = CGRectMake(point.x - 4.5, point.y - 4.5, 9, 9);
        
        //添加高光点按钮
        UIButton *highBtn;
        if (grade == 1) {
            
            highBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            highBtn.frame = CGRectMake(point.x - 10, point.y - 10, 20, 20);
            highBtn.alpha = 0.5;
            highBtn.backgroundColor = [UIColor redColor];
            highBtn.layer.cornerRadius = 10.0;
            [self addSubview:highBtn];
            
            if (!self.maxValueLabel) {
                
//                self.backgroundColor = [UIColor blueColor];
                
                self.maxValueLabel = [[UILabel alloc]initWithFrame:CGRectMake(point.x - 30, point.y - 40, 60, 30)];
//                self.maxValueLabel.backgroundColor = [UIColor yellowColor];
                self.maxValueLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
                [self.maxValueLabel setTextAlignment:NSTextAlignmentCenter];
                //                    self.maxValueLabel.backgroundColor = [UIColor greenColor];
                self.maxValueLabel.textColor = [UIColor redColor];
                self.maxValueLabel.text = [NSString stringWithFormat:@"2014-12-22\n%d元",_yValueMax];
                self.maxValueLabel.numberOfLines = 2;
                [self addSubview:self.maxValueLabel];
            } else {
                self.maxValueLabel.frame = CGRectMake(point.x - 40, point.y - 50, 60, 40);
            }
            
        }
        
        
        index += 1;
    }
    
    _chartLine.path = progressline.CGPath;
	if (_strokeColor) {
		_chartLine.strokeColor = [_strokeColor CGColor];
	}else{
		_chartLine.strokeColor = [PNGreen CGColor];
	}
    
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.0;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [_chartLine addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
    _chartLine.strokeEnd = 1.0;
    
    
}



@end
