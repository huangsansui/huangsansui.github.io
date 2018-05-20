#!/bin/sh
echo "该脚本用于部署个人博客"
cd deploy/huangsansui.github.io
echo "成功切换至代码目录"
git add .
git commit -m “update”
echo "提交成功"
git push origin master
echo "push成功"
