# FoundationExtension

## AttributedExtension
对创建 NSAttributedString 进行一层包装
主要涉及:
1. GMLRichTextBuilder NSAttributedString 的构建器，主要负责处理 NSAttributedString 的创建/修改/拼接
2. GMLAttributesBuilder 富文本属性([NSAttributedString.Key : Any]) 构建器，为 NSAttributedString.Key 各个属性提供快捷设置方法

