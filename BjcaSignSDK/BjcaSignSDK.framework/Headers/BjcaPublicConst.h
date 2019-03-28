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
    //    测试环境
    BjcaTest,
    //    开发环境
    BjcaDev,
};

//证书类型，分医师类型和公众类型(APP)
typedef NS_ENUM(NSInteger,BjcaCertType) {
//    医生类型
    CertDoctor,
//    患者类型
    CertMass,
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
//    开启指纹
    BjcaBusinessFingerPin,
//    关闭指纹
    BjcaBusinessFingerPinClose,
};
#endif /* BjcaPublicConst_h */
