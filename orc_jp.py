# import paddleclas
from paddleocr import PaddleOCR
from PIL import Image

# 替换为你的图片路径
image_path = '/tmp/screenshot_orc.png'

# # 语言检测
# lang_model = paddleclas.PaddleClas(model_name="language_classification")
# result = lang_model.predict(input_data=image_path)
# result = list(result)
# lang_type = result[0][0]['label_names'][0]
# print('语言类型为：',lang_type)

# 使用对应语言模型重新识别
ocr_final = PaddleOCR(use_angle_cls=True, lang="japan", show_log=False)
result = ocr_final.ocr(image_path, cls=True)

# 输出最终结果
output_text = ""
for line in result:
    for _, text in line:
        output_text += text[0] + "\n"

print(output_text.strip())
