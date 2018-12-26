//
//  BjcaPublicConst.h
//  BjcaSignSDK
//
//  Created by 吴兴 on 2018/11/20.
//  Copyright © 2018 szyx. All rights reserved.
//

#ifndef BjcaPublicConst_h
#define BjcaPublicConst_h

//SDK地址
typedef NS_ENUM(NSInteger,BjcaServerType) {
    //    正式环境
    BjcaPublic,
    //    集成环境
    BjcaIntegrate,
    //    开发环境
    BjcaDev,
    //    测试环境
    BjcaTest,
};

//用户希望执行的业务
typedef NS_ENUM(NSInteger,BjcaBusinessType) {
//    证书下载
    BjcaBusinessCertDown,
//    证书更新
    BjcaBusinessCertUpdate,
//    证书密码重置
    BjcaBusinessCertReset,
//    修改签章
    BjcaBusinessStamp,
//    批量签名
    BjcaBusinessSignList,
//    二维码业务
    BjcaBusinessQrCode,
//    免密开启
    BjcaBusinessFreePin,
//    用户信息
    BjcaBusinessUserInfo,
//    查看证书详情
    BjcaBusinessCertDetail,
};
#endif /* BjcaPublicConst_h */
