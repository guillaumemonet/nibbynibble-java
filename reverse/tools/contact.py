import sys,os
from PIL import Image
d=sys.argv[1]; fs=sorted(f for f in os.listdir(d) if f.endswith('.png'))
cols=3; w,h=320,264
W=Image.new('RGB',(cols*(w+6),((len(fs)+cols-1)//cols)*(h+6)),(60,0,60))
for i,f in enumerate(fs): W.paste(Image.open(os.path.join(d,f)),((i%cols)*(w+6),(i//cols)*(h+6)))
W.save(sys.argv[2])
