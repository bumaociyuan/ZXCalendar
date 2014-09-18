//
//  ZXCalendarGridView.m
//  ZXCalendar
//
//  Created by niko on 9/18/14.
//  Copyright (c) 2014 niko. All rights reserved.
//

#import "ZXCalendarGridView.h"
#import "ZXCalendarView.h"
#import "LunarCalendar.h"
#import "NSDate+Calendar.h"

@interface ZXCalendarGridView ()

@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *lunarLabel;

@end

@implementation ZXCalendarGridView

+ (instancetype)gridView {
    ZXCalendarGridView *result = [[self alloc]init];
    return result;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - property
- (void)setDate:(NSDate *)date {
    if (![date isEqual:_date]) {
        _date = date;
        if (self.dateLabel) {
            self.dateLabel.text = [NSString stringWithFormat:@"%i", _date.day];
        }
        
        if (self.lunarLabel) {
            LunarCalendar *lunarCalendar = [_date chineseCalendarDate];
            if (lunarCalendar.SolarTermTitle.length <= 0) {
                self.lunarLabel.text = [NSString stringWithFormat:@"%@", lunarCalendar.DayLunar];
            } else {
                self.lunarLabel.text = [NSString stringWithFormat:@"%@", lunarCalendar.SolarTermTitle];
            }
        }
    }
}

- (void)setType:(ZXCalendarGridViewType)type {
    _type = type;
    [self updateUI];
}

#pragma mark - helper
- (void)setup {
    self.frame = CGRectMake(0, 0, GRID_WIDTH, GRID_HEIGHT);
    self.backgroundColor = [UIColor whiteColor];
    [self setupLabels];
    [self updateUI];
}

- (void)setupLabels {
    UILabel *dateLabel = [UILabel new];
    dateLabel.frame = CGRectMake(0, 5, GRID_WIDTH, 20);
    dateLabel.font = [UIFont boldSystemFontOfSize:15.0f];
    dateLabel.textAlignment = NSTextAlignmentCenter;
    dateLabel.text = @"12";
    [self addSubview:dateLabel];
    self.dateLabel = dateLabel;
    
    UILabel *lunarLabel = [UILabel new];
    lunarLabel.font = [UIFont systemFontOfSize:9];
    lunarLabel.textAlignment = NSTextAlignmentCenter;
    lunarLabel.frame = CGRectMake(0, GRID_HEIGHT - 20, GRID_WIDTH, 15);
    lunarLabel.text = @"大寒";
    [self addSubview:lunarLabel];
    self.lunarLabel = lunarLabel;
}

- (void)updateUI {
    
    switch (self.type) {

        case ZXCalendarGridViewTypeSelected:
        {
            self.dateLabel.textColor = [UIColor redColor];
            self.lunarLabel.textColor = [UIColor redColor];
        }
            break;
            
        case ZXCalendarGridViewTypeToday:
        {
            self.dateLabel.textColor = [UIColor blueColor];
            self.lunarLabel.textColor = [UIColor blueColor];
        }
            break;
            
        case ZXCalendarGridViewTypeOther:
        {
            self.dateLabel.textColor = [UIColor grayColor];
            self.lunarLabel.textColor = [UIColor grayColor];
        }
            break;
            
        case ZXCalendarGridViewTypeNone:
        default:
        {
            self.dateLabel.textColor = [UIColor blackColor];
            self.lunarLabel.textColor = [UIColor blackColor];
        }
            break;
    }
}

@end
