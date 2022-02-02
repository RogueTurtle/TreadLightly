from ctypes.wintypes import RGB
import cv2 as cv
import numpy as np

path = "testMap.jpg"
img = cv.imread(path)

f = open(r"Map.txt", 'w')

black = RGB(0, 0, 0)

for i in range(100):
    for j in range(100):
        b,g,r = img[i,j]
        colour = RGB(r, g, b)
        if colour == black:
          f.write("1,")  
        else:
            f.write("0,")
        if j == 99:
            f.write(":")

f.seek(19999)
f.truncate()