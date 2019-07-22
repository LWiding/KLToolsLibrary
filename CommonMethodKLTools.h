//
//  CommonMethodKLTools.h
//  GBCheckUpLibrary
//
//  Created by likuan on 2019/3/21.
//  Copyright © 2019 jinher. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CommonMethodKLTools : NSObject

/** version */
+ (NSString *)appVersionString;

/** build */
+ (NSString *)appBuildString;

/** version(build) */
+ (NSString *)appVersionAndBuildString;

//UUID,IDFV,用于应用的开发商(Vendor)唯一标识一台设备的ID。根据包名的前两部分算出。同一台设备，如果有相同开发商多个app,号码一样。
+ (NSString*)getUUID;

//屏幕宽度
+ (CGFloat)getScreenWidth;

//屏幕高度
+ (CGFloat)getScreenHeight;

//验证身份证
+ (BOOL)validateNumber:(NSString*)number;

#pragma mark -- 限制输入 在UITextFieldDelegate中使用
/** 验证输入字符串是否符合限制字符串 */
+ (BOOL)validateString:(NSString *)originalString limitString:(NSString *)limitString;

/** 限制输入位数 maxLength最大长度。在UITextFieldDelegate中使用 */
+ (BOOL)validateTextField:(UITextField *)textField
                    range:(NSRange)range
                   string:(NSString *)string
                maxLength:(NSInteger)maxLength;

/** 验证textfield输入长度,只能输入数字 */
+ (BOOL)validateOnlyNumberTextField:(UITextField *)textField
                              range:(NSRange)range
                             string:(NSString *)string
                          maxLength:(NSInteger)maxLength;

/** 验证textfield输入长度,只能输入字母或数字 */
+ (BOOL)validateCharacterORNumberTextField:(UITextField *)textField
                                     range:(NSRange)range
                                    string:(NSString *)string
                                 maxLength:(NSInteger)maxLength;

/** 验证身份证，只能输入数字和Xx，并且长度小于18位。在UITextFieldDelegate中使用 */
+ (BOOL)validateIDNumberTextField:(UITextField *)textField
                            range:(NSRange)range
                           string:(NSString *)string;


//判断验证码是否为空
+ (BOOL)isCheckNumberKong:(NSString *)String;
//判断字符串是否为空
+ (BOOL)isCheckStringKong:(NSString *)String msg:(NSString *)msg;
//判断是否是数字
+ (BOOL)isNumber:(NSString *)str;
//判断应用在后台
+ (BOOL)runningInBackground;
//判断应用在前台
+ (BOOL)runningInForeground;

//弹出默认UIAlertController
+ (void)alertController:(NSString *)title
                message:(NSString *)message
                     VC:(UIViewController *)VC
        eventOneHandler:(void (^)(UIAlertAction *msgString))eventOneHandler
        eventTwoHandler:(void (^)(UIAlertAction *msgString))eventTwoHandler
            alertOneStr:(NSString *)alertOneStr
            alertTwoStr:(NSString *)alertTwoStr;

//十六进制颜色值转换成color
+ (UIColor *)getColor:(NSString *)hexColor;

/**
 *float类型数字转换成"万元"
 */
+ (NSString *)updatePrice:(float)floatNumber;

/**
 *将拍单状态转换为对应字符串
 */
+ (NSString *)changeStateToString:(NSInteger)state;

/**
 *毫秒转成"时:分:秒"
 */
+ (NSString *)changeTimeInterval:(long long)millisecond;

/**
 *毫秒转成"分:秒"
 */
+ (NSString *)changeTimeIntervalToMinSec:(long long)millisecond;

//cell上button找到cell
+ (id)findMyCell:(Class)cellClass button:(UIButton *)btn;

/** 获得dealerID字符串 */
+ (NSString *)dealerIDStr;

/** 判断服务器返回字段数值是否为null */

+ (BOOL)isNull:(id)obj isClass:(Class)isClass;

+ (BOOL)isNull:(NSDictionary *)dic key:(NSString *)key;

+ (BOOL)isNull:(NSDictionary *)dic key:(NSString *)key isClass:(Class)isClass;

/*
 * 返回当前值或者nil
 * NSNumber : 123 true false null
 * NSString : "123"
 * NSDictionary : {}
 * NSArray : []
 */
+ (id)checkNull:(id)obj;

+ (id)checkNull:(id)obj isClass:(Class)isClass;

+ (id)dictionary:(NSDictionary *)dictionary objectForKey:(NSString *)key;

/**
 * UIColor转为UIimage
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

//查询配置表(最外层字段)
+ (id)getConfigDataFromString:(NSString *)string;

//暂无数据
+ (void)NoDateWarnNoDataView:(UIView *)dataView addToSelfView:(UIView *)viewSelf ImgString:(NSString *)imgString titString:(NSString *)titString;

/**
 获得1像素高度
 @return 1像素高度
 */
+ (CGFloat)onePixel;

#pragma mark -- UITableViewCell
/**
 tableView注册nib 常见设置
 @param tableView tableView description
 @param nibStr nibStr description
 */
+ (void)tableView:(UITableView *)tableView registerNib:(NSString *)nibStr;


+ (void)tableViewSetting:(UITableView *)tableView registerNib:(NSString *)nibStr;

/**
 返回默认空UITableViewCell
 */
+ (UITableViewCell *)defaultTableViewCell:(UITableView *)tableView;

#pragma mark -- custom constraint
/**
 在baseView与subView之间增加上下左右四个0的约束,方法必须在addSubview之后
 @param baseView 基础view
 */
+ (void)constraintBaseView:(UIView *)baseView subView:(UIView *)subView;

#pragma mark -- formatNSString
+ (NSString *)formatStr:(NSString *)str;

//保存登录成功存状态
+ (void)saveLoginStatus;
//删除登录状态
+ (void)deleteLoginStatus;

//是否登录
+ (BOOL)isLogin;

//去掉头尾回车符
+ (NSString *)getPublicKeyCertString:(NSString *)certDataString;

//计算lab宽高
+ (CGFloat)labHight:(UIFont* )aFont width:(float )aWidth text:(NSString* )aStr;

+ (CGFloat)labWidth:(UIFont* )aFont hight:(float )aHeight text:(NSString* )aStr;

//获取图片文件名
+(NSString *)gettimeFileName;

//获取当前时间
+(NSString *)getMonth;

//转换成json字符串
+ (NSString *)getJsonStringData:(id)data;

//Json字符串转化成id类型数据
+ (id)getDataFromJsonStr:(NSString *)jsonString;

#pragma mark -- json
/**
 json to BOOL, 其他返回NO
 
 @return BOOL
 */
+ (BOOL)toBOOL:(NSObject *)obj;

/**
 json to NSInteger, string转为integer, 其他返回0
 
 @return NSInteger
 */
+ (NSInteger)toInteger:(NSObject *)obj;

/**
 json to NSString, integer转为string, 其他返回nil
 */
+ (NSString *)toString:(NSObject *)obj;

//return NSArray
+(NSArray *)toArray:(NSObject *)obj;

/**
 json to NSDictionary
 
 @return NSDictionary
 */
+ (NSDictionary *)toDictionary:(NSObject *)obj;

#pragma mark -- UILabel
/**
 get max height from label array
 @return max height
 */
+ (CGFloat)maxLabelHeight:(NSArray<UILabel *> *)array;

//控件添加下划线
+ (NSMutableAttributedString *)underlineStyleSingleWithString:(NSString *)string lineColor:(UIColor *)lineColor strColor:(UIColor *)strColor;

/**
 *  计算文字尺寸
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸 CGSizeMake(MAXFLOAT, MAXFLOAT)
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

//展示隐藏圈圈
+ (void)showHud:(UIView *)view title:(NSString *)title;
+ (void)hiddenHud:(UIView *)view;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;

//获取View所在控制器
+ (UIViewController *)ViewController:(id)Self;

//添加阴影
+ (void)addShadowLineView:(UIView *)view shadowColor:(UIColor *)color shadowOffset:(CGSize)shadowOffset;

//获取一个随机整数，范围在[from,to]，包括from，包括to
+ (int)getRandomNumber:(int)from to:(int)to;

//返回改变frame后的UIImage
+ (UIImage*)scaleToSize:(CGSize)size img:(UIImage *)img;





//------20190325---------

//时间戳转换为时间 //   @"/Date(1553132137409+0800)/"
+ (NSString *)getTimeWithChangeStr:(NSString *)dateStr;

//对象是否为空
+ (BOOL)isNullOrNil:(id)object;

//字符串是否为空
+ (BOOL)isNull:(NSString *)string;

/**
  判断数组为空
  @param arr 数组
  @return YES 空 NO
  */

+ (BOOL)isBlankArr:(NSArray *)arr;

/**
  判断字典为空
  @paramdic 数组
  @return YES 空 NO
  */
+ (BOOL)isBlankDictionary:(NSDictionary *)dic;

//======得到当前时间========

//当前时间 str类型
+ (NSString *)getCurrentTimeString;

//当前时间 date类型
+ (NSDate *)getCurrentTime;

//时间转时间戳
+(NSString *)dateConversionTimeStamp:(NSDate *)date;

//时间戳转字符串
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp;

//字符串转时间
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr;

//日期对比
+ (int)compareOneDay:(NSDate *)currentDay withAnotherDay:(NSDate *)BaseDay;

//是否过期
+ (BOOL)isCanToDoWithModel:(NSString *)FinalDayStr;

//富文本
+ (NSMutableAttributedString *)activityLabdataString:(NSString *)string range:(NSRange)rangeMake allTextColor:(UIColor *)allTextColor partTextColor:(UIColor *)partTextColor allFont:(NSInteger)allFont partFont:(NSInteger)partFont;

//两个富文本显示
+ (NSMutableAttributedString *)attributedTwoString:(NSString *)string allTextColor:(UIColor *)allTextColor allFont:(NSInteger)allFont range:(NSRange)rangeMake partTextColor:(UIColor *)partTextColor partFont:(NSInteger)partFont range2:(NSRange)rangeMake2 partTextColor2:(UIColor *)partTextColor2 partFont2:(NSInteger)partFont2;

//三个富文本显示
+ (NSMutableAttributedString *)attributedComString:(NSString *)string allTextColor:(UIColor *)allTextColor allFont:(NSInteger)allFont range:(NSRange)rangeMake partTextColor:(UIColor *)partTextColor partFont:(NSInteger)partFont range2:(NSRange)rangeMake2 partTextColor2:(UIColor *)partTextColor2 partFont2:(NSInteger)partFont2 range3:(NSRange)rangeMake3 partTextColor3:(UIColor *)partTextColor3 partFont3:(NSInteger)partFont3;

@end

NS_ASSUME_NONNULL_END
