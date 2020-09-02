# 简介
猫盘刷了Debian后，实现自动的LED风扇控制脚本，注意不是刷了群晖系统下的脚本。  
当前只是猫盘Plus的版本。 

## 脚本说明
使用前需先执行  
> apt-get install lm-sensors  
请自行设置为开机运行脚本  
检测间隔时间15秒  
温度高于65°关机  
温度高于40°风扇转，红灯呼吸  
温度低于38°风扇停，红灯关，显示蓝灯  
温度低于40°风扇停，蓝灯常亮  
硬盘待机或休眠，蓝灯呼吸  
硬盘工作，蓝灯常亮  

## 参数说明
DISK：硬盘设备符，如有不同请自行修改  
T_SHUTDOWN：关机温度  
T_HIGH：风扇启动温度  
T_LOW：风扇关闭温度。应该比风扇启动温度低几度，否则风扇可能会频繁启动/关闭  
LOOP_TIME：检测间隔时间，默认是30秒  

## 脚本效果
CPU温度升至预设高值时，风扇启动  
CPU温度降至预设低值时，风扇停转  
CPU温度达到危险温度时，立即关机  
红色LED：表示风扇转动  
蓝色LED：表示工作状态  
蓝色呼吸：表示待机状态（硬盘休眠）  

#### 脚本来至于简书（https://www.jianshu.com/p/d2316ae1a0e5）并自行修改  