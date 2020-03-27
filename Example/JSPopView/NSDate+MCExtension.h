//
//  NSDate+MCExtension.h
//  MCFoundation
//
//  Created by illScholar on 2019/2/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (MCExtension)

#pragma mark - Comparison Day
/**
 是否为今天

 @return BOOL
 */
- (BOOL)mcIsToday;

/**
 是否为明天

 @return BOOL
 */
- (BOOL)mcIsTomorrow;

/**
 是否为昨天

 @return BOOL
 */
- (BOOL)mcIsYesterday;

/**
 是否与其他日期为同一天

 @param other 其他日期
 @return BOOL
 */
- (BOOL)mcIsSameDay:(NSDate *)other;

#pragma mark - Comparison Week
/**
 是否为本周

 @return BOOL
 */
- (BOOL)mcIsThisWeek;

/**
 是否为下周

 @return BOOL
 */
- (BOOL)mcIsNextWeek;

/**
 是否为上周

 @return BOOL
 */
- (BOOL)mcIsLastWeek;

/**
 是否与其他日期为同一周

 @param other 其他日期
 @return BOOL
 */
- (BOOL)mcIsSameWeekAsDate:(NSDate *)other;

#pragma mark - Comparison Month
/**
 是否为当月

 @return BOOL
 */
- (BOOL)mcIsThisMonth;

/**
 是否为下个月

 @return BOOL
 */
- (BOOL)mcIsNextMonth;

/**
 是否为上个月

 @return BOOL
 */
- (BOOL)mcIsLastMonth;

/**
 是否与其他日期同一个月

 @param other 其他日期
 @return BOOL
 */
- (BOOL)mcIsSameMonth:(NSDate *)other;

#pragma mark - Comparison Year
/**
 是否为今年

 @return BOOL
 */
- (BOOL)mcIsThisYear;

/**
 是否为下一年

 @return BOOL
 */
- (BOOL)mcIsNextYear;

/**
 是否为去年

 @return BOOL
 */
- (BOOL)mcIsLastYear;

/**
 是否与其他日期为同一年

 @param other 其他日期
 @return BOOL
 */
- (BOOL)mcIsSameYearAsDate:(NSDate *)other;

/**
 判断当前日期是否为闰年

 @return BOOL
 */
- (BOOL)mcIsLeapYear;

#pragma mark - Comparison Workday
/**
 判断当前日期是否为工作日

 @return BOOL
 */
- (BOOL)mcIsTypicallyWorkday;

#pragma mark - Comparison Workend
/**
 判断当前日期是否为周末

 @return BOOL
 */
- (BOOL)mcIsTypicallyWorkend;

#pragma mark - EarlierThan
/**
 是否比其他日期早

 @param other 其他日期
 @return BOOL
 */
- (BOOL)mcIsEarlierThanDate:(NSDate *)other;

/**
 判断日期是否在将来

 @return BOOL
 */
- (BOOL)mcIsInFuture;

#pragma mark - LaterThan
/**
 是否比其他日期晚

 @param other 其他日期
 @return BOOL
 */
- (BOOL)mcIsLaterThanDate:(NSDate *)other;

/**
 判断日期是否在过去

 @return BOOL
 */
- (BOOL)mcIsInPast;

/**
 忽略时间 与其他日期是否相同 只比较年月日

 @param other 其他日期
 @return BOOL
 */
- (BOOL)mcIsEqualToDateIgnoringTime:(NSDate *)other;

/**
 判断当前日期所在年份有多少天

 @return NSUInteger
 */
- (NSUInteger)mcDaysInYear;

/**
 判断当前日期在当前年份中的第几天

 @return NSUInteger
 */
- (NSUInteger)mcDayOfYear;

#pragma mark - Components
/**
 当前日期的年

 @return NSInteger
 */
- (NSInteger)mcYear;

/**
 当前日期的月

 @return NSInteger
 */
- (NSInteger)mcMonth;

/**
 当前日期的当月的第几周

 @return NSInteger
 */
- (NSInteger)mcWeekOfMonth;

/**
 当前日期在当年的第几周

 @return NSInteger
 */
- (NSInteger)mcWeekOfYear;

/**
 当前日期在当年的所在周的第几天

 @return NSInteger
 */
- (NSInteger)mcWeekday;

/**
 表示当前日期WeekDay在下一个更大的日历单元中的位置。例如WeekDay=3，WeekDayOrdinal=2  就表示这个月的第2个周二。

 @return NSInteger
 */
- (NSInteger)mcNthWeekday;

/**
 当前日期的天

 @return NSInteger
 */
- (NSInteger)mcDay;

/**
 当前日期的小时

 @return NSInteger
 */
- (NSInteger)mcHour;

/**
 当前日期的分钟

 @return NSInteger
 */
- (NSInteger)mcMinutes;

/**
 当前日期的秒

 @return NSInteger
 */
- (NSInteger)mcSeconds;

/**
 当前日期的Era

 @return NSInteger
 */
- (NSInteger)mcEra;

/**
 日期组件

 @return NSDateComponents
 */
- (NSDateComponents *)mcComponents;

#pragma mark - Creation
/**
 以当前日期为基准加1天为明天的日期

 @return NSDate
 */
+ (NSDate *)mcDateTomorrow;

/**
 以当前日期为基准加1天为明天的日期

 @return NSDate
 */
+ (NSDate *)mcDateYesterday;

/**
 当前的日期 只包含天月年

 @return NSDate
 */
+ (NSDate *)mcDateWithoutTime;

/**
 从当前日期起后面指定天数的日期

 @param days 天数
 @return NSDate
 */
+ (NSDate *)mcDateWithDaysFromNow:(NSInteger)days;

/**
 把日期格式的字符串转为NSDate

 @param string 日期格式字符串
 @return NSDate
 */
+ (NSDate *)mcDateFromString:(NSString *)string;

/**
 把日期格式的字符串按照指定格式转为NSDate

 @param string 日期格式字符串
 @param format 指定格式
 @return NSDate
 */
+ (nullable NSDate *)mcDateFromString:(NSString *)string withFormat:(NSString *)format;

/**
 获取当前日期去除时间的日期

 @return NSDate
 */
- (NSDate *)mcDateWithoutTime;

#pragma mark - Formatting
/**
 eg：cccc, dd MMM yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatCCCCDDMMMYYYY;

/**
 eg：cccc, dd MMMM yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatCCCCDDMMMMYYYY;

/**
 eg：dd MMM yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatDDMMMYYYY;

/**
 eg：dd-MM-yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatDDMMYYYYDashed;

/**
 eg：dd/MM/yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatDDMMYYYYSlashed;

/**
 eg：dd/MMM/yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatDDMMMYYYYSlashed;

/**
 eg：MMM dd, yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatMMMDDYYYY;

/**
 eg：dd-MM-yyyy

 @return NSString
 */
+ (NSString *)mcDateFormatYYYYMMDDDashed;

/**
 返回当前日期 格式为'dd-MM-yyyy'的字符串

 @return NSString
 */
- (NSString *)mcFormattedString;

/**
 返回当前日期指定格式的字符串

 @param dateFormat 日期格式
 @return NSString
 */
- (NSString *)mcFormattedStringUsingFormat:(NSString *)dateFormat;

#pragma mark - Manipulation
/**
 指定日期后推几天得到的日期

 @param days 后推的天数
 @return NSDate
 */
- (NSDate *)mcDateByAddingDays:(NSInteger)days;

/**
 指定日期后推几周得到的日期

 @param weeks 后推的周数
 @return NSDate
 */
- (NSDate *)mcDateByAddingWeeks:(NSInteger)weeks;

/**
 指定日期后推几个月得到的日期

 @param months 后推的月数
 @return NSDate
 */
- (NSDate *)mcDateByAddingMonths:(NSInteger)months;

/**
 指定日期后推几年得到的日期

 @param years 后推的年数
 @return NSDate
 */
- (NSDate *)mcDateByAddingYears:(NSInteger)years;

/**
 指定日期后推几小时得到的日期

 @param hours 后推的几个小时
 @return NSDate
 */
- (NSDate *)mcDateByAddingHours:(NSInteger)hours;

/**
 指定日期后推几分钟得到的日期

 @param minutes 后推的分钟数
 @return NSDate
 */
- (NSDate *)mcDateByAddingMinutes:(NSInteger)minutes;

/**
 指定日期后推几秒钟得到的日期

 @param seconds 后推的秒钟数
 @return NSDate
 */
- (NSDate *)mcDateByAddingSeconds:(NSInteger)seconds;

/**
 指定日期前推几天的到的日期

 @param days 前推的天数
 @return NSDate
 */
- (NSDate *)mcDateBySubtractingDays:(NSInteger)days;

/**
 指定日期前推几周的得到的日期

 @param weeks 前推的周数
 @return NSDate
 */
- (NSDate *)mcDateBySubtractingWeeks:(NSInteger)weeks;

/**
 指定日期前推几个月得到的日期

 @param months 前推的月数
 @return NSDate
 */
- (NSDate *)mcDateBySubtractingMonths:(NSInteger)months;

/**
 指定日期前推几年得到的日期

 @param years 前推的年数
 @return NSDate
 */
- (NSDate *)mcDateBySubtractingYears:(NSInteger)years;

/**
 指定日期前推几小时得到的日期

 @param hours 前推的小时数
 @return NSDate
 */
- (NSDate *)mcDateBySubtractingHours:(NSInteger)hours;

/**
 指定日期前推几分钟得到的日期

 @param minutes 前推的分钟数
 @return NSDate
 */
- (NSDate *)mcDateBySubtractingMinutes:(NSInteger)minutes;

/**
 指定日期前推几秒钟得到的日期

 @param seconds 前推的秒钟数
 @return NSDate
 */
- (NSDate *)mcDateBySubtractingSeconds:(NSInteger)seconds;

/**
 当前的日期和指定的日期之间相差的天数

 @param toDate 指定的日期
 @return NSInteger
 */
- (NSInteger)mcDifferenceInDaysToDate:(NSDate *)toDate;

/**
 当前的日期和指定的日期之间相差的月数

 @param toDate 指定的日期
 @return NSInteger
 */
- (NSInteger)mcDifferenceInMonthsToDate:(NSDate *)toDate;

/**
 当前的日期和指定的日期之间相差的年数

 @param toDate 指定的日期
 @return NSInteger
 */
- (NSInteger)mcDifferenceInYearsToDate:(NSDate *)toDate;

/**
 当前的日期和指定的日期之间相差的小时数

 @param toDate 指定的日期
 @return NSInteger
 */
- (NSInteger)mcDifferenceInHoursToDate:(NSDate *)toDate;

/**
 当前的日期和指定的日期之间相差的分钟数

 @param toDate 指定的日期
 @return NSInteger
 */
- (NSInteger)mcDifferenceInMinutesToDate:(NSDate *)toDate;

/**
 当前的日期和指定的日期之间相差的秒种数

 @param toDate 指定的日期
 @return NSInteger
 */
- (NSInteger)mcDifferenceInSecondsToDate:(NSDate *)toDate;

#pragma mark - TimeStamp
/**
 当前日期的时间戳

 @return double
 */
+ (double)mcCurrentDateTimeStamp;

/**
 当前日期的毫秒级时间戳

 @return UInt64
 */
+ (UInt64)mcCurrentDateMillisecondTimeStamp;

@end

NS_ASSUME_NONNULL_END
