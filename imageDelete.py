# -*- coding: utf-8 -*-  

import os,re;

'''
    当前文件所在项目路径
'''
projectBase = os.path.dirname(__file__)

"""
    简单判断是否为React-native 项目
"""

def isRnProject():
    node = os.path.join(projectBase,"node_modules");
    app = os.path.join(projectBase,"app.json");
    ios = os.path.join(projectBase,"ios");
    android = os.path.join(projectBase,"android");
    return os.path.isfile(app) and os.path.isdir(node) and (os.path.exists(ios) or os.path.exists(android))



class Image(object):

    _name = ""
    _path = ""

    def __init__(self,path,name):
        self._path = path;
        self._name = name;

    def delete(self):
        print "------------========"
        path  = os.path.join(self._path,self._name)
        paths = []
        path0  = path + ".png"
        if os.path.exists(path0):
            paths.append(path0)
            # print path0
        else:
            path1 = path + "@1x.png"
            path2 = path + "@2x.png"
            path3 = path + "@3x.png"
            path4 = path + "@1.5x.png"
            paths.append(path1)
            paths.append(path2)
            paths.append(path3)
            paths.append(path4)
            # print path1,path2,path3,path4

        for _path in paths:
            if os.path.exists(_path):
                print "删除:",_path
                os.remove(_path)
            

"""
    扫描文件夹下所有图片资源
"""
def scanImages(path):
    Sources = []
    for root,_,files in os.walk(path):
        _files = [one.split(".")[0].split("@")[0] for one in files]
        _files = list(set(_files))
        for onef in _files:
            image = Image(root,onef)
            Sources.append(image)
    return Sources

"""
    扫描用到的图片
"""
def scanUseImage(path):
    _path = os.path.dirname(path)
    UseImage = []
    with open(path) as file:
        while 1:
            Line = file.readline()
            if not Line:
                break
            image = re.search('(?<=require).+(?<=\\))',Line)
            if not (image is None):
                image =image.group();
                image = image[4:][:-2]
                UseImage.append(os.path.join(_path,image))
    return UseImage


"""
    放在RN 主目录下
"""

if __name__ == "__main__" and isRnProject():
    
    """
        所有相片
    """
    Images = scanImages(os.path.join(projectBase,"src","sources","images"))
    """
        使用的相片
    """    
    useImages = scanUseImage(os.path.join(projectBase,"src","sources","images.js"))
    _useImages = [one.split(".")[0] for one in useImages]

    
    for UImage in Images:
        Image = os.path.join(UImage._path,UImage._name)
        if Image not in _useImages:
            UImage.delete()
    
    