

#import <UIKit/UIKit.h>

@interface LRDayNightView : UIView
// 红色备选数组
@property (nonatomic, strong) NSMutableArray *colors;
// 海洋颜色数组
@property (nonatomic, strong) NSMutableArray *colorb;
// 月亮备选数组
@property (nonatomic, strong) NSMutableArray *colorm;
// 太阳实际显示数组
@property (nonatomic, strong) NSMutableArray *colorsun;
// 太阳圆心X坐标
@property (nonatomic, assign) CGFloat rx;
// 背景的alph值
@property (nonatomic, assign) CGFloat ba;
@end
