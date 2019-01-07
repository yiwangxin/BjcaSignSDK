# BjcaSignSDK
北京数字医信SDK

发布步骤：

1、打tag版本
git tag 名字 –m "注释"
2、push到远端
git push origin
3、修改podspec中的版本号
4、pod spec lint BjcaSignSDK.podspec --verbose --use-libraries
5、pod trunk push  BjcaSignSDK.podspec --allow-warnings --use-libraries
