from PIL import Image as im
import numpy as np
from matplotlib.image import imread
import os


picture = imread("./Selected Photo.jpg")
changed = np.resize(picture, (128,128))
file1 = open('my_image.txt', 'w')
for i in range(128):
    a_str = ','.join(str(float(x)) for x in changed[i])
    a_str = "(" + a_str + "),"
    file1.writelines(a_str)
    file1.write("\n")
file1.close()