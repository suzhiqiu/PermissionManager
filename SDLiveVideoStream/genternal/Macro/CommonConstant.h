//
//  Macros.h
//  ShenHua
//
//  Created by suzhiqiu on 15/7/5.
//  Copyright (c) 2015年 suzhiqiu. All rights reserved.
//

#ifndef CommonConstant_h
#define CommonConstant_h


#define DEGREES_TO_RADIANS(d)   ((d) * M_PI / 180.0)
#define RADIANS_TO_DEGREES(r)   ((d) * 180.0 / M_PI)

#define SD_FF_OPTIONS           (SDWebImageRetryFailed|SDWebImageLowPriority)          //1.失败重试 2.滚动的时候也可以下载
#define customDefaultColor UIColorFromRGB(0xff3c4c)
/*iOS11*/
#define kiOS11                    @available(ios 11.0,*)



#endif
