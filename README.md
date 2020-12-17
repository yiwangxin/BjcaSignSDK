#版本更新说明
##V3.6.1
2020年12月17日(iOS)
 -3.6.1
1.固定签章图片的大小400x160
2.限制clientId为空
——————————————————————————————————————————————
##V3.6.0
2020年10月15日(iOS)
 -3.6.0
1.优化扫描二维码功能(增加对最新二维码的支持同时支持授权开启自动签、扫码认领并签名待签数据)
2.解决之前一些需要证书操作的接口没有验证本地是否存在证书
——————————————————————————————————————————————
##V3.5.2
2020年9月15日(iOS)
 -3.5.2
1.修复未注册用户下证崩溃问题
——————————————————————————————————————————————
##V3.5.1
2020年9月9日(iOS)
 -3.5.1
1.增加开启授权签名
2.UI页面国际化
——————————————————————————————————————————————
##V3.5.0
2020年8月18日(iOS)
 -3.5.0
1.优化个人证书、签名策略
2.修复已知bug
——————————————————————————————————————————————
##V3.4.7
2020年6月15日(iOS)
 -3.4.7
1.信步云键盘组件更新
——————————————————————————————————————————————
##V3.4.6
2020年6月11日(iOS)
 -3.4.6
1.添加自动签名
——————————————————————————————————————————————
##V3.4.5
2020年6月08日(iOS)
 -3.4.5
1.修改下载证书cookie丢失
2.签名时UI刷新不在主线程奔溃
3.反馈BJCASignetUncaughtExceptionHandle重名问题
4.解决下载证书取消后无法签名
——————————————————————————————————————————————
##V3.4.4
2020年5月27日(iOS)
 -3.4.4
1.修改上一个版本主题无法修改问题
——————————————————————————————————————————————
##V3.4.3
2020年5月26日(iOS)
 -3.4.3
1.替换云签名包(UIWebView更换为WKWebView,更新键盘UI)
——————————————————————————————————————————————
##V3.4.2
2020年5月06日(iOS)
 -3.4.2
1.修改HUD下可能存在的签名崩溃问题
——————————————————————————————————————————————
##V3.4.1
2019年4月16日(iOS)
 -3.4.1
1.修改线程错误调用问题
——————————————————————————————————————————————
##V3.4.0
2019年2月27日(iOS)
 -3.4.0
1.添加SDK自动签功能
——————————————————————————————————————————————
##V3.3.2
2019年1月17日(iOS)
 -3.3.2
1.修改扫码签名报错问题
——————————————————————————————————————————————
##V3.3.1
2019年1月10日(iOS)
 -3.3.1
1.设置签章添加HUD
——————————————————————————————————————————————
##V3.3.0
2019年12月31日(iOS)
 -3.3.0
1.添加签名流水号签名功能
2.修改免密签名时间对比
——————————————————————————————————————————————
##V3.2.2
2019年12月12日(iOS)
 -3.2.2
1.修改回调参数问题（厂商无影响）
——————————————————————————————————————————————
##V3.2.1
2019年11月29日(iOS)
 -3.2.1
1.添加业务自动签功能
——————————————————————————————————————————————
##V3.2.0
2019年10月16日(iOS)
 -3.2.0
1.修改下载证书内部逻辑
——————————————————————————————————————————————
##V3.0.9
2019年10月10日(iOS)
 -3.0.9
1.修改iOS13下模态视图导致签章页面失效问题
——————————————————————————————————————————————
##V3.0.8
2019年8月29日(iOS)
 -3.0.8
1.同步版本号
——————————————————————————————————————————————
##V3.0.7
2019年7月22日(iOS)
 -3.0.7 
1.修改同时开启指纹和免密的优先级
2.修改下证页面获取验证码问题
——————————————————————————————————————————————
##V3.0.6
2019年7月11日(iOS)
 -3.0.6 修复网络问题
——————————————————————————————————————————————
##V3.0.5
2019年6月25日(iOS)
 -3.0.5 修复内部方法调用
——————————————————————————————————————————————
##V3.0.1
2019年1月9日
Sdk3.0.1更新说明：
1.新增获取个人签章图片的接口getStampPic
2.移除判断是否存在个人签章的接口existsStamp（可以通过getStampPic的返回值进行判断）
——————————————————————————————————————————————
##V3.0.0
2019年1月2日
Sdk3.0.0更新说明：
1.修改集成方式（移除证书管理首页，签名回调方式修改为接口回调）
2.支持厂商直接调用证书下载、证书密码重置、证书更新接口
3.支持厂商直接调用开启免密签名接口
4.提供证书详情页面activity
5.支持直接跳转到修改个人签章页面
6.注意：旧版本的api将在3.1版本移除
——————————————————————————————————————————————
##V2.2.1
2018年10月23日
-2.2.1版本  更新内容
1.基于2.2.0版本修复android 9系统下无法正常进行证书下载、签名的兼容性问题
——————————————————————————————————————————————
##V2.2.0
2018年10月12日
-2.2.0版本  更新内容
1.升级证书组件 ——修正证书激活页面输错验证码后会关闭当前页面
2.支持厂商通过配置css的background来进行sdk的网页部分title和主要按钮的背景颜色
3.获取用户证书详细信息接口新增deviceFit属性，表示当前用户证书所在的设备和服务端保持一致
4.支持厂商携带手机号参数跳转到证书下载、证书找回页面
——————————————————————————————————————————————
##V2.1.3
2018年4月19日
-2.1.3版本  更新内容
1.修复第三方调用签名由于Https配置引起网络异常导致无法正常业务的bug
2.修复用户在开启“不保留活动”选项后，无法正常签名的bug
——————————————————————————————————————————————
##V2.1.2
2018年3月5日
-2.1.2版本 更新内容
1.修复签名按键被虚拟键盘覆盖的bug
2.修复网络库对全局配置进行修改导致第三方应用配置丢失的问题
——————————————————————————————————————————————
##V2.1.1
2018年1月31日
-2.1.1版本 更新内容
1.变更获取用户信息接口（变更为服务端异步获取）
2.新增获取openId接口
3.新增判断是否个人签章接口
4.新增判断用户当前是否处于免密签名期间
5.demo中引导第三方提醒用户更新证书
6.修复证书激活页面用户可以输入非数字密码进行证书下载的bug
7.新增错误日志上报功能
——————————————————————————————————————————————
##V2.1.0
2017年12月25日
-2.1.0版本 更新内容
1.二维码签名和二维码OAuth接口合二为一，变更为医网签二维码处理接口（qrDispose）
2.优化签名接口（经过测试验证效率提升至少40%）
3.签名接口将会返回一些厂商关心的错误码
4.支持证书更新
5.支持广澳台护照的证件类型
——————————————————————————————————————————————
##V2.0.0
2017年11月9日
 -2.0.0-定版 更新内容
1.修复签名输错pin码达到上限后依然能够重试的bug
2.解决证书找回返回医网签sdk页面后立即关闭sdk页面导致应用崩溃的bug
——————————————————————————————————————————————
 2017年11月1日
 -2.0.0-修复签名过程中崩溃 更新内容
——————————————————
1.修复签名过程中关闭网络应用崩溃
2.修复签名过程中退出当前签名页面应用崩溃
3.修复2.0.0版本用户在证书找回输入验证码的页面取消操作，依然调用证书绑定接口
—2.0.0版本更新内容：
——————————————————
1.升级签名sdk2.1版本（用户激活页面可修改、修复取消免密签名应用崩溃的bug）
2.签名返回第三方数据新增图章（二维码签名、登录不返）
3.提交签名结果新增p1结果（支持个人pdf签名）
