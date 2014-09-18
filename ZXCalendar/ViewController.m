//
//  ViewController.m
//  ZXCalendar
//
//  Created by niko on 9/18/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "ZXCalendarView.h"
#import "NSDate+Calendar.h"

@interface ViewController ()<ZXCalendarViewDataSource, ZXCalendarViewDelegate>
@property (nonatomic, strong) ZXCalendarView *calendarView;
@property (nonatomic, weak) IBOutlet UISwipeGestureRecognizer *left;
@property (nonatomic, weak) IBOutlet UISwipeGestureRecognizer *right;
@end

@implementation ViewController

- (void)viewDidLoad
{
    ZXCalendarView *view = [ZXCalendarView calendarView];
    view.selectedDate = [NSDate date];
    view.dateSource = self;
    view.delegate = self;
    [self.view addSubview:view];
    self.calendarView = view;
    view.center = self.view.center;
    self.view.backgroundColor = [UIColor colorWithRed:0.361 green:0.537 blue:0.293 alpha:1.000];
    [view addGestureRecognizer:self.left];
    [view addGestureRecognizer:self.right];
}

- (ZXCalendarGridViewType)calendarView:(ZXCalendarView *)calendarView typeAtDate:(NSDate *)date {
    //TODO: 自己写逻辑
    return ZXCalendarGridViewTypeNone;
}

- (void)calendarView:(ZXCalendarView *)calendarView didSelectedAtDate:(NSDate *)date {
    calendarView.selectedDate = date;
}


//////////////////////////////////////////////////////////////////////////////////

- (IBAction)swipe:(id)sender {
    if (sender == self.right) {
        if (self.calendarView.type == ZXCalendarViewTypeMonth) {
            [self lastMonth:nil];
        }else {
            [self lastWeek:nil];
        }
    }else {
        if (self.calendarView.type == ZXCalendarViewTypeMonth) {
            [self nextMonth:nil];
        }else {
            [self nextWeek:nil];
        }
    }
}

- (IBAction)typeChange:(UISwitch *)sender {
    self.calendarView.type = !self.calendarView.type;
}


- (IBAction)nextMonth:(id)sender {
    [self.calendarView setSelectedDate:[self.calendarView.selectedDate associateDayOfTheFollowingMonth] animated:YES];
    
}
- (IBAction)lastMonth:(id)sender {
    [self.calendarView setSelectedDate:[self.calendarView.selectedDate associateDayOfThePreviousMonth] animated:YES];
    
}

- (IBAction)nextWeek:(id)sender {
    [self.calendarView setSelectedDate:[self.calendarView.selectedDate  dateWithDayInterval:7] animated:YES];
}

- (IBAction)lastWeek:(id)sender {
    [self.calendarView setSelectedDate:[self.calendarView.selectedDate  dateWithDayInterval:-7] animated:YES];
}

@end
