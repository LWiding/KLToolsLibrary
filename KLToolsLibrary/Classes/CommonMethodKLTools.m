//
//  CommonMethodKLTools.m
//  GBCheckUpLibrary
//
//  Created by likuan on 2019/3/21.
//  Copyright © 2019 jinher. All rights reserved.
//

#import "CommonMethodKLTools.h"
//字母大小写加数字
#define ALLCHARACTERANDNUMBER @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
//屏幕宽高
#define KWidth [UIScreen mainScreen].bounds.size.width
#define KHight [UIScreen mainScreen].bounds.size.height

@implementation CommonMethodKLTools

//version
+ (NSString *)appVersionString{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    return version;
}
//build
+ (NSString *)appBuildString{
    NSString *build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    return build;
}

//version(build)
+ (NSString *)appVersionAndBuildString{
    return [NSString stringWithFormat:@"%@(%@)", [self appVersionString], [self appBuildString]];
}

//UUID,IDFV
+ (NSString*)getUUID{
    NSString *identifierForVendor = [[UIDevice currentDevice].identifierForVendor UUIDString];
    return identifierForVendor;
}

// platform 区分安卓 ios
+ (NSString *)getPlatform{
    return @"IOS";
    //    return [DeviceSystemHander getPhoneOS];
}

//// 设备当前网络状态
//+ (NSString *)getPhoneCurrentNetWorkType{
//    return [DeviceSystemHander getCurrentNetWorkType];
//}
//
//// 设备 和 系统版本号 iPhone 7 (10.1.1)
//+ (NSString *)getPhoneDeviceTypeAndSystemVersion{
//    return [DeviceSystemHander getPhoneTypeAndSystemVersion];
//}

#pragma mark -- end
//屏幕宽度
+ (CGFloat)getScreenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}
//屏幕高度
+ (CGFloat)getScreenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}

//验证手机号
+(BOOL)isPhoneNumber:(NSString *)strPhone
{
    //NSString *regex = @"^((13[0-9])|(17[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSString *regex = @"^(13|17|14|15|18)\\d{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isVail = [pred evaluateWithObject:strPhone];
    if (isVail == NO) {
//        [XHToast showBottomWithText:@"抱歉,手机号码输入有误,请输入11位数字的手机号"];
        return NO;
    }else{
        return YES;
    }
}

//检查密码是否有效
+ (BOOL)isValidPassword:(NSString*)password{
    //判断长度
    if (password.length < 6 || password.length >16) {
//        [XHToast showBottomWithText:@"抱歉,密码输入有误,密码应由6-16位字符组成"];
        return NO;
    }
    //判断是否包含空格
    NSRange whitespaceRange = [password rangeOfString:@" "];
    if (whitespaceRange.length) {
//        [XHToast showBottomWithText:@"抱歉,密码输入有误,密码应由6-16位字符组成"];
        return NO;
    }
    return YES;
}

//验证身份证号
+ (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789Xx"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}

#pragma mark -- 限制输入 在UITextFieldDelegate中使用
//验证输入字符串是否符合限制字符串
+ (BOOL)validateString:(NSString *)originalString limitString:(NSString *)limitString {
    NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:limitString] invertedSet];
    NSString *filtered = [[originalString componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
    return [originalString isEqualToString:filtered];
}

// 限制输入位数 maxLength最大长度
+ (BOOL)validateTextField:(UITextField *)textField
                    range:(NSRange)range
                   string:(NSString *)string
                maxLength:(NSInteger)maxLength{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    return newLength <= maxLength || returnKey;
}

// 验证textfield输入长度,只能输入数字
+ (BOOL)validateOnlyNumberTextField:(UITextField *)textField
                              range:(NSRange)range
                             string:(NSString *)string
                          maxLength:(NSInteger)maxLength{
    BOOL isMax = [self validateTextField:textField range:range string:string maxLength:maxLength];
    BOOL isValidateStr = [self validateString:string limitString:@"0123456789"];
    return isValidateStr && isMax;
}

/** 验证textfield输入长度,只能输入字母或数字 */
+ (BOOL)validateCharacterORNumberTextField:(UITextField *)textField
                                     range:(NSRange)range
                                    string:(NSString *)string
                                 maxLength:(NSInteger)maxLength{
    BOOL isMax = [self validateTextField:textField range:range string:string maxLength:maxLength];
    BOOL isValidateStr = [self validateString:string limitString:ALLCHARACTERANDNUMBER];
    return isValidateStr && isMax;
    
}

// 验证身份证，只能输入数字和Xx，并且长度小于18位。在UITextFieldDelegate中使用
+ (BOOL)validateIDNumberTextField:(UITextField *)textField range:(NSRange)range string:(NSString *)string{
    BOOL isMax = [self validateTextField:textField range:range string:string maxLength:18];
    BOOL isValidateStr = [self validateString:string limitString:@"0123456789xX"];
    return isValidateStr && isMax;
}


//判断设备在前台后台
+(BOOL) runningInBackground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateBackground);
    return result;
}

//前台
+(BOOL) runningInForeground
{
    UIApplicationState state = [UIApplication sharedApplication].applicationState;
    BOOL result = (state == UIApplicationStateActive);
    return result;
}

//判断是否是数字
+ (BOOL)isNumber:(NSString *)str
{
    //NSString *regex = @"^((13[0-9])|(17[0-9])|(147)|(15[^4,\\D])|(18[0-9]))\\d{8}$";
    NSString *regex = @"[0-9]";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isVail = [pred evaluateWithObject:str];
    if (isVail == NO) {
        return NO;
    }else{
        return YES;
    }
}

//弹出UIAlertController
+ (void)alertController:(NSString *)title
                message:(NSString *)message
                     VC:(UIViewController *)VC
        eventOneHandler:(void (^)(UIAlertAction *msgString))eventOneHandler
        eventTwoHandler:(void (^)(UIAlertAction *msgString))eventTwoHandler
            alertOneStr:(NSString *)alertOneStr
            alertTwoStr:(NSString *)alertTwoStr
{
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:alertOneStr  style:UIAlertActionStyleCancel handler:eventOneHandler];
    if (eventTwoHandler) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:alertTwoStr style:UIAlertActionStyleDefault handler:eventTwoHandler];
        [alertC addAction:okAction];
    }
    
    [alertC addAction:cancelAction];
    [VC presentViewController:alertC animated:YES completion:nil];
}

//十六进制颜色值转换成 UIcolor
+ (UIColor *)getColor:(NSString *)hexColor {
    NSString *temp = [hexColor stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSArray * Array1 = [temp componentsSeparatedByString:@"#"];
    NSString *hexColorNew = Array1[1];//转换成不带#号的字符串
    NSLog(@"%@  %@",Array1,hexColorNew);
    unsigned int red,green,blue;
    NSRange range;
    range.length = 2;
    
    range.location = 0;
    [[NSScanner scannerWithString:[hexColorNew substringWithRange:range]] scanHexInt:&red];
    
    range.location = 2;
    [[NSScanner scannerWithString:[hexColorNew substringWithRange:range]] scanHexInt:&green];
    
    range.location = 4;
    [[NSScanner scannerWithString:[hexColorNew substringWithRange:range]] scanHexInt:&blue];
    
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green / 255.0f) blue:(float)(blue / 255.0f) alpha:1.0f];
}

//float类型数字转换成"万元" 更新价格
+ (NSString *)updatePrice:(float)floatNumber{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,###,###,##0.00"];
    if (floatNumber>=10000)
    {
        return [NSString stringWithFormat:@"%@万元",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:floatNumber/10000]]];
    }
    else
    {
        [numberFormatter setPositiveFormat:@"###,###,###,##0"];
        return [NSString stringWithFormat:@"%@元",[numberFormatter stringFromNumber:[NSNumber numberWithDouble:floatNumber]]];
    }
}


//毫秒转成"时:分:秒"
+ (NSString *)changeTimeInterval:(long long)millisecond{
    if (millisecond<0) {
        millisecond = 0;
    }
    long long remainSecond = millisecond/1000;
    long long hour = remainSecond/3600;
    long long minute = remainSecond%3600/60;
    long long second = remainSecond%60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%02lld:%02lld:%02lld",hour,minute,second];
    return timeStr;
}

//毫秒转成"分:秒"
+ (NSString *)changeTimeIntervalToMinSec:(long long)millisecond{
    if (millisecond<0) {
        millisecond = 0;
    }
    long long remainSecond = millisecond/1000;
    long long minute = remainSecond%3600/60;
    long long second = remainSecond%60;
    
    NSString *timeStr = [NSString stringWithFormat:@"%lld:%02lld", minute, second];
    return timeStr;
}

//cell上button找到cell
+ (id)findMyCell:(Class)cellClass button:(UIButton *)btn{
    UIResponder *responder = btn.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:cellClass]) {
            return responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}

+ (BOOL)isNull:(id)obj isClass:(Class)isClass{
    if ([self isNull:obj]) {
        if ([obj isKindOfClass:isClass]) {
            return YES;
        }
    }
    return NO;
}

+ (BOOL)isNull:(NSDictionary *)dic key:(NSString *)key{
    return [self isNull:[dic objectForKey:key]];
}

+ (BOOL)isNull:(NSDictionary *)dic key:(NSString *)key isClass:(Class)isClass{
    id obj = [dic objectForKey:key];
    //判断是否为空
    if ([self isNull:obj]) {
        //判断类型是否相同
        if ([obj isKindOfClass:isClass]) {
            //判断是否是字典，判断字典个数（额外的）
            //            if ([obj isKindOfClass:[NSArray class]]) {
            //                NSArray *array = (NSArray *)obj;
            //                if (array.count) {
            //                    return YES;
            //                }
            //            }
            
            return YES;
        }
    }
    return NO;
}

//返回当前值或者nil
+ (id)checkNull:(id)obj{
    if ([self isNull:obj]) {
        return obj;
    }
    return nil;
}

+ (id)checkNull:(id)obj isClass:(Class)isClass{
    if ([self isNull:obj] && [obj isKindOfClass:isClass]) {
        return obj;
    }
    return nil;
}

+ (id)dictionary:(NSDictionary *)dictionary objectForKey:(NSString *)key{
    return [self checkNull:[dictionary objectForKey:key]];
}

/* 判空格式化json数据
 * string, integer, null, true, false, array, dictionary To string
 */
+ (NSString *)stringFormat:(id)obj {
    if ([obj isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@", obj];
    }
    return nil;
}

//颜色转为UIimage
+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//查询配置表(最外层字段)
+ (id)getConfigDataFromString:(NSString *)string{
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSData *configData =  [userDef objectForKey:@"ConfigData"];
    NSMutableDictionary * configDic = [NSJSONSerialization JSONObjectWithData:configData options:1 error:nil];
    id seacherConfigStr = configDic[string];
    
    if (!seacherConfigStr || seacherConfigStr == [NSNull null]) {
        return  @"..";
    }else{
        return seacherConfigStr;
    }
}

//暂无数据
+ (void)NoDateWarnNoDataView:(UIView *)dataView addToSelfView:(UIView *)viewSelf ImgString:(NSString *)imgString titString:(NSString *)titString{
    //暂无数据downView
    dataView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KWidth, KHight-64)];
    dataView.backgroundColor = [UIColor whiteColor];
    [viewSelf addSubview:dataView];
    //图片
    CGFloat displayHeight = KHight-20-44-49;
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imgString]];
    bgImageView.frame = CGRectMake(0, displayHeight/2-50-155-8, 160, 155);
    bgImageView.center = CGPointMake(KWidth/2.0, bgImageView.center.y);
    [dataView addSubview:bgImageView];
    //文字lab
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.frame = CGRectMake(0, displayHeight/2-45, KWidth, 20);
    titleLabel.text = titString;
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [dataView addSubview:titleLabel];
    
}

/**
 获得1像素高度
 @return 1像素高度
 */
+ (CGFloat)onePixel {
    return 1.0/[UIScreen mainScreen].scale;
}

#pragma mark -- UITableViewCell
//tableview注册cell 多余cell不显示
+ (void)tableView:(UITableView *)tableView registerNib:(NSString *)nibStr {
    [tableView registerNib:[UINib nibWithNibName:nibStr bundle:nil] forCellReuseIdentifier:nibStr];
}

//tableview设置
+ (void)tableViewSetting:(UITableView *)tableView registerNib:(NSString *)nibStr{
    [self tableView:tableView registerNib:nibStr];
    tableView.tableFooterView = [[UIView alloc] init];//多余cell不显示
    //    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //    tableView.separatorColor = [UIColor separator];
    
}

//默认空cell
+ (UITableViewCell *)defaultTableViewCell:(UITableView *)tableView{
    static NSString *identifier = @"defaultIdentifier";
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return tableViewCell;
}


#pragma mark -- custom constraint
/**
 在baseView与subView之间增加上下左右四个0的约束
 @param baseView 其实可以互换
 @param subView 应该是可以互换
 */
+ (void)constraintBaseView:(UIView *)baseView subView:(UIView *)subView {
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    NSLayoutConstraint * l = [NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:baseView
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1.0
                                                           constant:0];
    NSLayoutConstraint * r = [NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:baseView
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1.0
                                                           constant:0];
    NSLayoutConstraint * t = [NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:baseView
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                           constant:0];
    NSLayoutConstraint * b = [NSLayoutConstraint constraintWithItem:subView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:baseView
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1.0
                                                           constant:0];
    //不执行添加代码会crash
    [baseView addSubview:subView];
    [NSLayoutConstraint activateConstraints:@[l, r, t, b]];
}

#pragma mark -- formatNSString
+ (NSString *)formatStr:(NSString *)str {
    return [NSString stringWithFormat:@"%@", str];
}

//去掉头尾回车符
+ (NSString *)getPublicKeyCertString:(NSString *)certDataString
{
    //    NSString *base64String = [[NSString alloc] initWithData:certData encoding:NSUTF8StringEncoding] ;
    NSString *repleas = [certDataString stringByReplacingOccurrencesOfString:@"-----BEGIN CERTIFICATE-----" withString:@""];
    NSString *replea = [repleas stringByReplacingOccurrencesOfString:@"-----END CERTIFICATE-----" withString:@""];
    NSString *reple = [replea stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    NSString *repl = [reple stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    return repl;
}

//lab宽高
+ (CGFloat)labHight:(UIFont* )aFont width:(float )aWidth text:(NSString* )aStr{
    CGSize size = CGSizeMake(aWidth,CGFLOAT_MAX);
    NSDictionary *attribute = @{NSFontAttributeName:aFont};
    CGSize labelsize = [aStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return labelsize.height;
}

+ (CGFloat)labWidth:(UIFont* )aFont hight:(float )aHeight text:(NSString* )aStr{
    CGSize size = CGSizeMake(CGFLOAT_MAX,aHeight);
    NSDictionary *attribute = @{NSFontAttributeName:aFont};
    NSString *a = [NSString stringWithFormat:@"%@",aStr];
    CGSize labelsize = [a boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return labelsize.width;
}

//获取图片文件名
+(NSString *)gettimeFileName{
    NSDate *currentDate = [NSDate date];
    NSString *timeChuo = [NSString stringWithFormat:@"%lld",(long long)[currentDate timeIntervalSince1970]];
    NSString *uuid = [self getUUID];
    NSString *last8 = [uuid substringFromIndex:uuid.length- 4 ];//uuid后4位
    NSString *fileName = [NSString stringWithFormat:@"%@%u-%@.png",timeChuo,(arc4random() % 900 +100),last8];
    return fileName;
}

//获取当前时间
+(NSString *)getMonth{
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYYMM"];
    NSString *DateTime = [formatter stringFromDate:date];
    return DateTime;
}

//转换成json字符串
+ (NSString *)getJsonStringData:(id)data{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

//Json字符串转化成id类型数据
+ (id)getDataFromJsonStr:(NSString *)jsonString{
    if (nil == jsonString) {
        return nil;
    }
    id alldata = [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments | NSJSONReadingMutableLeaves | NSJSONReadingMutableContainers error:nil];
    return alldata;
}

#pragma mark -- json
//json返回类型转换
+ (BOOL)toBOOL:(NSObject *)obj
{
    if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)obj;
        return [number boolValue];
    }else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        if ([str isEqualToString:@"yes"]) {
            return YES;
        }
    }
    return NO;
}

+ (NSInteger)toInteger:(NSObject *)obj {
    if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)obj;
        return [number integerValue];
    }else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        return [str integerValue];
    }else {//array, object, null, nil
        return 0;
    }
}

+ (NSString *)toString:(NSObject *)obj {
    if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber *number = (NSNumber *)obj;
        return [NSString stringWithFormat:@"%@", number];
    }else if ([obj isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)obj;
        return str;
    }else {//array, object, null, nil
        return nil;
    }
}

+ (NSArray *)toArray:(NSObject *)obj {
    if ([obj isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)obj;
        return array;
    }else {
        return nil;
    }
}

+ (NSDictionary *)toDictionary:(NSObject *)obj {
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)obj;
        return dic;
    }else {
        return nil;
    }
}

#pragma mark -- UILabel
/**
 get max height from label array
 
 @return max height
 */
+ (CGFloat)maxLabelHeight:(NSArray<UILabel *> *)array
{
    CGFloat maxHeight = 0;
    for (UILabel *label in array) {
        CGSize labelSize = [label sizeThatFits:CGSizeMake(label.bounds.size.width, CGFLOAT_MAX)];
        if (labelSize.height > maxHeight) {
            maxHeight = labelSize.height;
        }
    }
    return maxHeight;
}

//控件添加下划线
+ (NSMutableAttributedString *)underlineStyleSingleWithString:(NSString *)string lineColor:(UIColor *)lineColor strColor:(UIColor *)strColor
{
    if (string.length) {
        NSMutableAttributedString* tncString = [[NSMutableAttributedString alloc] initWithString:string];
        [tncString addAttribute:NSUnderlineStyleAttributeName
                          value:@(NSUnderlineStyleSingle)
                          range:(NSRange){0,[tncString length]}];
        //设置下划线颜色
        [tncString addAttribute:NSUnderlineColorAttributeName value:lineColor range:(NSRange){0,[tncString length]}];
        //此时如果设置字体颜色要这样
        [tncString addAttribute:NSForegroundColorAttributeName value:strColor range:NSMakeRange(0,[tncString length])];
        return tncString;
    }
    return [@"" mutableCopy];
}

////展示隐藏圈圈
//+ (void)showHud:(UIView *)view title:(NSString *)title
//{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
//    // Change the background view style and color.
//    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
//    hud.bezelView.color = [UIColor colorWithWhite:0.f alpha:0.98f];
//    hud.contentColor = [UIColor whiteColor];
//    hud.label.text = title;
//    hud.label.font = [UIFont italicSystemFontOfSize:15.f];
//    //    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
//}
//
//+ (void)hiddenHud:(UIView *)view{
//    [MBProgressHUD hideHUDForView:view animated:YES];
//}

/**
 *  计算文字尺寸
 *  @param text    需要计算尺寸的文字
 *  @param font    文字的字体
 *  @param maxSize 文字的最大尺寸 CGSizeMake(MAXFLOAT, MAXFLOAT)
 */
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}

//添加阴影
+ (void)addShadowLineView:(UIView *)view shadowColor:(UIColor *)color shadowOffset:(CGSize)shadowOffset{
    view.layer.shadowOffset = shadowOffset;
    view.layer.shadowColor = color.CGColor;//shadowColor阴影颜色
    view.layer.shadowOpacity = 0.5;//阴影透明度，默认0
    view.layer.shadowRadius = 5;//阴影半径，默认3
}

//获取一个随机整数，范围在[from,to]，包括from，包括to
+ (int)getRandomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

//返回改变frame后的UIImage
+ (UIImage*)scaleToSize:(CGSize)size img:(UIImage *)img
{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

//------20190325---------

//时间戳转换为时间 //   @"/Date(1553132137409+0800)/"
+ (NSString *)getTimeWithChangeStr:(NSString *)dateStr
{
    if (dateStr) {
        NSString *headStr = [dateStr substringFromIndex:6];
        NSString *timeChuoStr = [headStr substringToIndex:10];
        NSDate *timeNew = [NSDate dateWithTimeIntervalSince1970:[timeChuoStr doubleValue]];
        NSDateFormatter *farmatter = [[NSDateFormatter alloc] init];
        [farmatter setDateFormat:@"YYYY.MM.dd"];
        NSString *newTime = [farmatter stringFromDate:timeNew];
        return newTime;
    }
    return @"";
}

//字符串 非空判断
+ (BOOL)isNull:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}

//非空判断
+ (BOOL)isNullOrNil:(id)object
{
    if (object == nil || [object isEqual:[NSNull null]]) {
        return YES;
    }
    return NO;
}


/**
  判断数组为空
  @param arr 数组
  @return YES 空 NO
  */

+ (BOOL)isBlankArr:(NSArray *)arr {
    if (!arr) {
        return YES;
        }
    if ([arr isKindOfClass:[NSNull class]]) {
        return YES;
        }
    
    if (![arr isKindOfClass:[NSArray class]]) {
        return YES;
        }
    if (!arr.count) {
        return YES;
        }
    if (arr == nil) {
        return YES;
        }
    if (arr == NULL) {
        return YES;
        }
    return NO;
}

/**
  判断字典为空
  @paramdic 数组
  @return YES 空 NO
  */
+ (BOOL)isBlankDictionary:(NSDictionary *)dic {
    if (!dic) {
        return YES;
        }
    if ([dic isKindOfClass:[NSNull class]]) {
        return YES;
        }
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return YES;
        }
    if (!dic.count) {
        return YES;
        }
    if (dic == nil) {
        return YES;
        }
    if (dic == NULL) {
        return YES;
        }
    return NO;
}

#pragma mark ===================得到当前时间=============

//当前时间 str类型
+ (NSString *)getCurrentTimeString{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    return dateTime;
}

//当前时间 date类型
+ (NSDate *)getCurrentTime{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    NSDate *date = [formatter dateFromString:dateTime];
    return date;
}

//时间转时间戳
+(NSString *)dateConversionTimeStamp:(NSDate *)date
{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]*1000];
    return timeSp;
}

//时间戳转字符串
+(NSString *)timeStampConversionNSString:(NSString *)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[timeStamp longLongValue]/1000];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *dateStr = [formatter stringFromDate:date];
    return dateStr;
}

//字符串转时间
+(NSDate *)nsstringConversionNSDate:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *datestr = [dateFormatter dateFromString:dateStr];
    return datestr;
}

//日期对比
+ (int)compareOneDay:(NSDate *)currentDay withAnotherDay:(NSDate *)BaseDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSString *currentDayStr = [dateFormatter stringFromDate:currentDay];
    NSString *BaseDayStr = [dateFormatter stringFromDate:BaseDay];
    NSDate *dateA = [dateFormatter dateFromString:currentDayStr];
    NSDate *dateB = [dateFormatter dateFromString:BaseDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", currentDay, BaseDay);
    if (result == NSOrderedDescending)
    {
        //  NSLog(@"Date1  is in the future");
        //  NSLog(@"说明当前时间大于指定时间");
        return 1;
    }else if (result == NSOrderedAscending){
        // NSLog(@"Date1 is in the past");
       //  NSLog(@"说明当前时间小于指定时间");
        return -1;
    }else{
        // NSLog(@"Both dates are the same");
        // NSLog(@"说明当前时间与指定时间相同");
        return 0;
    }
}

//是否过期
+ (BOOL)isCanToDoWithModel:(NSString *)FinalDayStr
{
    NSDate *currentDay = [CommonMethodKLTools getCurrentTime];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    NSDate *FinalDay = [dateFormatter dateFromString:FinalDayStr];
    int isOn = [CommonMethodKLTools compareOneDay:currentDay withAnotherDay:FinalDay];
    if (isOn == -1){
        //NSLog(@"Date1  is in the future");
        NSLog(@"说明当前时间大于指定时间");//
        return NO;
    }
    if (isOn == 1) {
        //NSLog(@"Date1 is in the past");//
        NSLog(@"说明当前时间小于指定时间");
        return YES;
    }
    if (isOn == 0) {
        //NSLog(@"Both dates are the same");//
        NSLog(@"说明当前时间与指定时间相同");
        return YES;
    }
    return NO;
}


//获取View所在控制器
+ (UIViewController *)ViewController:(id)Self{
    UIResponder *next = [Self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}

//字符串中是否含有中文
+ (BOOL)checkIsChinese:(NSString *)string
{
    for (int i=0; i<string.length; i++)
    {
         unichar ch = [string characterAtIndex:i];
         if (0x4E00 <= ch  && ch <= 0x9FA5)
         {
             return YES;
         }
    }
        return NO;
}

//富文本
+ (NSMutableAttributedString *)activityLabdataString:(NSString *)string range:(NSRange)rangeMake allTextColor:(UIColor *)allTextColor partTextColor:(UIColor *)partTextColor allFont:(NSInteger)allFont partFont:(NSInteger)partFont{
    //富文本
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (string.length) {
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:allFont] range:NSMakeRange(0, string.length)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:allTextColor  range:NSMakeRange(0, string.length)];
        
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:partFont] range:rangeMake];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:partTextColor  range:rangeMake];
    }
    return  AttributedStr;
}

//两个富文本显示
+ (NSMutableAttributedString *)attributedTwoString:(NSString *)string allTextColor:(UIColor *)allTextColor allFont:(NSInteger)allFont range:(NSRange)rangeMake partTextColor:(UIColor *)partTextColor partFont:(NSInteger)partFont range2:(NSRange)rangeMake2 partTextColor2:(UIColor *)partTextColor2 partFont2:(NSInteger)partFont2
{
    //富文本
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (string.length)
    {
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:allFont] range:NSMakeRange(0, string.length)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:allTextColor  range:NSMakeRange(0, string.length)];
        
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:partFont] range:rangeMake];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:partTextColor  range:rangeMake];
        
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:partFont2] range:rangeMake2];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:partTextColor2  range:rangeMake2];
    }
    return  AttributedStr;
}

//三个富文本显示
+ (NSMutableAttributedString *)attributedComString:(NSString *)string allTextColor:(UIColor *)allTextColor allFont:(NSInteger)allFont range:(NSRange)rangeMake partTextColor:(UIColor *)partTextColor partFont:(NSInteger)partFont range2:(NSRange)rangeMake2 partTextColor2:(UIColor *)partTextColor2 partFont2:(NSInteger)partFont2 range3:(NSRange)rangeMake3 partTextColor3:(UIColor *)partTextColor3 partFont3:(NSInteger)partFont3
{
    //富文本
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:string];
    if (string.length)
    {
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:allFont] range:NSMakeRange(0, string.length)];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:allTextColor  range:NSMakeRange(0, string.length)];
        
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:partFont] range:rangeMake];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:partTextColor  range:rangeMake];
        
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:partFont2] range:rangeMake2];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:partTextColor2  range:rangeMake2];
        
        [AttributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:partFont3] range:rangeMake3];
        [AttributedStr addAttribute:NSForegroundColorAttributeName value:partTextColor3  range:rangeMake3];
    }
    return  AttributedStr;
}

@end
