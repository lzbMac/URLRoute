//
//  TTSURLRouteConfig.h
//  TTSURLRoute
//
//  Created by 李正兵 on 2017/3/29.
//  Copyright © 2017年 李正兵. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const kRouteConfigClass;      //page ClassName
extern NSString * const kRouteConfigBundle;     //nib BundleName
extern NSString * const kRouteConfigNib;        //page NibName

extern NSString * const kRouteConfigHold;       //拦截器集合
extern NSString * const kRouteConfigWantLogin;  //拦截判断是否已登录
extern NSString * const kRouteConfigCheckKeys;  //检查需要的属性是否存在
extern NSString * const kRouteConfigPassKeys;   //相同property值往下传

@protocol TTSURLRouteConfigDelegate;
@interface TTSURLRouteConfig : NSObject

/**
 添加URL规则，规则只能添加覆盖，谨慎移除

 @param routeDictionary 页面规则集合
 */
+ (void)addRouteDictionary:(NSDictionary *)routeDictionary;

/**
 根据Plist名称加载Route

 @param path plist的文件名称;paths 文件名称数组
 */
+ (void)addRouteWithPlistPath:(NSString *)path;
+ (void)addRouteWithPlistPaths:(NSArray *)paths;

/**
 现有的页面规则

 @return 对应字典
 */
+ (NSDictionary *)routeDictionary;

/**
 注册共用数据获取类

 @param configClass 注册类
 */
+ (void)registerURLRouteConfigClass:(Class<TTSURLRouteConfigDelegate>)configClass;
@end
