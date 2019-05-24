//
//  GKHomeNetManager.m
//  GKiOSApp
//
//  Created by wangws1990 on 2019/5/13.
//  Copyright © 2019 wangws1990. All rights reserved.
//

#import "GKHomeNetManager.h"

@implementation GKHomeNetManager
+ (NSURLSessionDataTask *)homeHot:(NSDictionary *)params
                          success:(void(^)(id object))success
                          failure:(void(^)(NSString *error))failure{
    //宝贝
    return [GKHomeNetManager method:HttpMethodPost urlString:kUrlWall(@"/corp/bizhiClient/getGroupInfo.php?isAttion=1") params:params success:success failure:failure];
    //壁纸
//    return [GKHomeNetManager method:HttpMethodPost urlString:URL_Kyon params:params success:success failure:failure];
//    return [GKHomeNetManager method:HttpMethodGet urlString:kUrlService(@"/v2/homepage") params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)homeCategory:(NSDictionary *)params
                               success:(void(^)(id object))success
                               failure:(void(^)(NSString *error))failure{
     return [GKHomeNetManager method:HttpMethodPost urlString:kUrlWall(@"/corp/bizhiClient/getCateInfo.php") params:params success:success failure:failure];
//    return [GKHomeNetManager method:HttpMethodGet urlString:kUrlService(@"/v1/wallpaper/category") params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)homeCategory:(NSString *)categoryId
                                params:(NSDictionary *)params
                               success:(void(^)(id object))success
                               failure:(void(^)(NSString *error))failure{
     return [GKHomeNetManager method:HttpMethodPost urlString:kUrlWall(@"/corp/bizhiClient/getGroupInfo.php") params:params success:success failure:failure];
//    NSString *urlString = [NSString stringWithFormat:@"/v1/wallpaper/category/%@/wallpaper",categoryId?:@""];
//    return [GKHomeNetManager method:HttpMethodGet urlString:kUrlService(urlString) params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)homeNews:(NSDictionary *)params
                           success:(void(^)(id object))success
                           failure:(void(^)(NSString *error))failure{
     return [GKHomeNetManager method:HttpMethodGet urlString:kUrlWall(@"") params:params success:success failure:failure];
//    return [GKHomeNetManager method:HttpMethodGet urlString:kUrlService(@"/v1/wallpaper/wallpaper") params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)homeSearch:(NSString *)searchText
                              params:(NSDictionary *)params
                             success:(void(^)(id object))success
                             failure:(void(^)(NSString *error))failure{
    
    return [GKHomeNetManager method:HttpMethodPost urlString:kUrlWall(@"/corp/bizhiClient/getSearchInfo.php") params:params success:success failure:failure];
//    NSString *urlString = [NSString stringWithFormat:@"/v1/search/all/resource/%@?",searchText?:@""];
//    return [GKHomeNetManager method:HttpMethodGet urlString:kUrlSo(urlString) params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)detail:(NSString *)gId
                         success:(void(^)(id object))success
                         failure:(void(^)(NSString *error))failure{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"gId"]= gId ?:@"";
    CGRect rect = [UIScreen mainScreen].bounds;
    NSInteger width = (int) (rect.size.width * 2);
    NSInteger height = (int) (rect.size.height * 2);
    width = height < 961 ? 320 : 480;
    height = height < 961 ? 480 : 854;
    params[@"picSize"] = [NSString stringWithFormat:@"%lix%li",(long)width,(long)height];
     return [GKHomeNetManager method:HttpMethodPost urlString:kUrlWall(@"/corp/bizhiClient/getGroupPic.php") params:params success:success failure:failure];
}
+ (NSURLSessionDataTask *)newHot:(NSString *)categoryId
                            page:(NSInteger)page
                         success:(void(^)(id object))success
                         failure:(void(^)(NSString *error))failure{
    NSString *url = [NSString stringWithFormat:@"nc/article/headline/%@/%@-20.html",categoryId,@((page - 1)*20)];
//    NSString *urlStr = [NSString stringWithFormat:@"%@category_ids=%@&max_id=0&count=%@", URL_News, categoryId?:@"",@(20)];
    return [GKHomeNetManager method:HttpMethodGet urlString:kUrl163New(url) params:nil success:success failure:failure];
}
+ (NSURLSessionDataTask *)apiPhotoSet:(NSString *)photoSetId
                              success:(void(^)(id object))success
                              failure:(void(^)(NSString *error))failure{
    NSArray *list = nil;
    if (photoSetId.length > 4) {
        list = [[photoSetId substringFromIndex:4] componentsSeparatedByString:@"|"];
    }
   NSString *url = [NSString stringWithFormat:@"photo/api/set/%@/%@.json",list.firstObject,list.lastObject];
    return [GKHomeNetManager method:HttpMethodGet urlString:kUrl163New(url) params:nil success:success failure:failure];
}
+ (NSURLSessionDataTask *)app_login:(NSString *)account
                           password:(NSString *)password
                            success:(void(^)(id object))success
                            failure:(void(^)(NSString *error))failure
{
    NSMutableDictionary * params = [@{} mutableCopy];
    params[@"db"] = App_DB;
    params[@"function"] = @"app_login";
    params[@"login_name"] = account?:@"";
    params[@"pwd"] = password ?: @"";
    return [GKHomeNetManager method:HttpMethodPost serializer:HttpSerializeJSON urlString:App_LoginURL params:params success:^(id object) {
        [GKHomeNetManager loginSuccessSaveData:object];
        !success ?: success(object);
    } failure:failure];
}
+ (void)loginSuccessSaveData:(id)resultset
{
    if ([resultset isKindOfClass:[NSDictionary class]]) {
        NSArray * array = resultset[@"resultset"];
        NSDictionary * dic = [array firstObject];
        GKUserModel * model = [GKUserModel modelWithDictionary:dic];
        if ([model.login_state isEqualToString:@"0"]) {
            BOOL res = [GKUserManager saveUserModel:model];
            if (res) {
                NSLog(@"写入成功");
            }
        }
    }
}
+ (NSURLSessionDataTask *)appLaunch:(NSTimeInterval )timeStamp
                            success:(void(^)(id object))success
                            failure:(void(^)(NSString *error))failure{
    NSString *path = [NSString stringWithFormat:@"http://g1.163.com/madr"];
    NSMutableDictionary * params = [@{} mutableCopy];
    params[@"app"] = @"7A16FBB6";
    params[@"platform"] = @"ios";
    params[@"category"] = @"startup";
    params[@"location"] =  @"1";
    params[@"timestamp"] =  [NSString stringWithFormat:@"%ld",(long)timeStamp];
   return [BaseNetManager method:HttpMethodGet serializer:HttpSerializeDefault urlString:path params:params timeOut:2 success:success failure:failure];
}
@end
