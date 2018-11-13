# DeeLight
实现各种光照模型

1. Lambert
> 兰伯特实现漫反射

> half lambert(半兰伯特)
> 解决的问题是lambert太暗，提亮漫反射颜色 

![image](https://github.com/OgreDee/DeeLight/blob/master/Pic/Lambert.png)
![image](https://github.com/OgreDee/DeeLight/blob/master/Pic/Half_Lambert.png)

2. Phong光照模型
![image](https://github.com/OgreDee/DeeLight/blob/master/Pic/Phong%20Model.png)

> 需要计算一次反射向量，效率略低，引入Blinn-Phong

3. Blinn-Phong模型
![image](https://github.com/OgreDee/DeeLight/blob/master/Pic/Blinn_Phong%20Model.png)

#油腻腻的效果图
![image](https://github.com/OgreDee/DeeLight/blob/master/Pic/Blinn-Phong.png)
