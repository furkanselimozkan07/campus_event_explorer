
from pathlib import Path
import math
from PIL import Image, ImageDraw, ImageFont

OUT = Path(__file__).resolve().parent.parent / 'assets' / 'images'
OUT.mkdir(parents=True, exist_ok=True)
W, H = 1200, 620
font_path = '/usr/share/fonts/truetype/lato/Lato-Bold.ttf'  # change if regenerating elsewhere
font = ImageFont.truetype(font_path, 112) if Path(font_path).exists() else ImageFont.load_default()


def gradient(top, bottom):
    im = Image.new('RGB', (W, H))
    draw = ImageDraw.Draw(im)
    for y in range(H):
        a = y / (H - 1)
        draw.line((0, y, W, y), fill=tuple(round(top[i]*(1-a)+bottom[i]*a) for i in range(3)))
    return im


def base_decor(draw, white=(255, 255, 255)):
    for x, y, r in [(75, 65, 110), (1140, 50, 160), (1070, 540, 210), (300, 670, 190)]:
        draw.ellipse((x-r, y-r, x+r, y+r), outline=(*white, 45), width=3)


def text_with_shadow(draw, label):
    draw.text((81, 420), label, font=font, fill=(14, 23, 44, 100), stroke_width=0)
    draw.text((76, 412), label, font=font, fill='#ffffff', stroke_width=0)

# Technology: monitor + laptop keyboard + circuit traces
im = gradient((20, 66, 143), (65, 163, 224)).convert('RGBA')
d = ImageDraw.Draw(im, 'RGBA')
base_decor(d)
for step in range(5):
    yy = 120 + step*56
    d.line((580, yy, 660, yy, 710, yy+25), fill=(255,255,255,90), width=6)
    d.ellipse((701, yy+16, 720, yy+35), fill=(244,247,255,190))
d.rounded_rectangle((746, 109, 1113, 367), radius=22, fill=(9,40,105,235), outline=(255,255,255,200), width=6)
d.rounded_rectangle((773, 133, 1085, 331), radius=10, fill=(103,203,233,235))
for i in range(4):
    d.rounded_rectangle((796, 165+i*34, 855+(i%2)*76, 176+i*34), radius=6, fill=(240,249,255,200))
d.polygon([(731,369),(1131,369),(1180,398),(686,398)], fill=(243,248,255,224))
d.rounded_rectangle((900, 207, 975, 261), radius=9, outline=(255,255,255,245), width=6)
text_with_shadow(d, 'TECHNOLOGY')
im.convert('RGB').save(OUT/'technology.png', optimize=True)

# Arts: canvas, bold brush strokes, stars
im = gradient((119, 52, 145), (237, 123, 138)).convert('RGBA')
d=ImageDraw.Draw(im,'RGBA')
base_decor(d)
d.rounded_rectangle((742, 91, 1084, 367), radius=20, fill=(247,228,223,245), outline=(255,255,255,220), width=7)
for color, curve in [
    ((92,81,194,235), [(790,304),(817,208),(930,174),(1044,155)]),
    ((246,106,90,235), [(790,286),(864,276),(945,230),(1056,265)]),
    ((238,181,79,235), [(819,126),(871,146),(927,200),(991,225)]),
]:
    d.line(curve, fill=color, width=35, joint='curve')
d.ellipse((928,132,983,187), fill=(255,235,150,255))
d.line([(735,395),(1107,395)], fill=(255,255,255,155), width=9)
for x,y in [(684,102),(1100,470),(650,327),(1154,226)]:
    d.line((x-13,y,x+13,y), fill=(255,243,237,200), width=4)
    d.line((x,y-13,x,y+13), fill=(255,243,237,200), width=4)
text_with_shadow(d,'ARTS')
im.convert('RGB').save(OUT/'arts.png',optimize=True)

# Sports: basketball and game court
im=gradient((10,104,98),(57,188,128)).convert('RGBA')
d=ImageDraw.Draw(im,'RGBA')
base_decor(d)
d.rounded_rectangle((695,120,1110,445),radius=30, outline=(234,251,236,120),width=7)
d.line((901,122,901,442), fill=(235,255,240,110),width=7)
d.ellipse((835,221,968,344), outline=(235,255,240,110),width=7)
d.ellipse((769,106,1058,395),fill=(236,141,64,255),outline=(255,228,178,255),width=10)
d.arc((772,106,1055,394),44,138,fill=(111,61,44,255),width=13)
d.arc((772,106,1055,394),224,318,fill=(111,61,44,255),width=13)
d.line((914,114,914,388),fill=(111,61,44,255),width=12)
d.line((776,252,1053,252),fill=(111,61,44,255),width=12)
text_with_shadow(d,'SPORTS')
im.convert('RGB').save(OUT/'sports.png',optimize=True)

for p in OUT.iterdir():
    print(p.name, f'{p.stat().st_size/1024:.1f} KiB')
