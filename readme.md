# 简介
猫盘刷了Debian后，实现自动的LED风扇控制脚本，注意不是刷了群晖系统下的脚本。
需先执行
> apt-get install lm-sensors

## 脚本效果
CPU温度升至预设高值时，风扇启动
CPU温度降至预设低值时，风扇停转
CPU温度达到危险温度时，立即关机
红色LED：表示风扇转动
蓝色LED：表示工作状态
绿色LED：表示待机状态（硬盘休眠）