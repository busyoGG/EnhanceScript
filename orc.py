# orc.py
from paddleocr import PaddleOCR

ocr = PaddleOCR(use_angle_cls=True, lang='ch')  # 中英文都支持

result = ocr.ocr('/tmp/screenshot_orc.png', cls=True)

# 收集识别结果
output_text = ""
for line in result:
    for box, text in line:
        output_text += text[0] + "\n"

# 打印到标准输出
print(output_text.strip())
