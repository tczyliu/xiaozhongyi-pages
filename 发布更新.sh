#!/bin/bash
# 小中医成长记 · 一键发布更新
# 用法：./发布更新.sh "这次改了什么"

cd "$(dirname "$0")" || exit 1

MSG="${1:-更新内容 $(date '+%Y-%m-%d %H:%M')}"

echo "==> 检查改动"
git add -A
if git diff --cached --quiet; then
  echo "没有任何改动，无需发布。"
  exit 0
fi
git status --short

echo ""
echo "==> 提交：$MSG"
git commit -m "$MSG" || exit 1

echo ""
echo "==> 推送到 GitHub"
git push origin main || exit 1

echo ""
echo "==> 等待 GitHub Pages 重新构建（约 30-90 秒）"
sleep 30
for i in $(seq 1 12); do
  CODE=$(curl -s -o /dev/null -w "%{http_code}" https://tczyliu.github.io/xiaozhongyi-pages/)
  echo "  [$i] HTTP $CODE"
  [ "$CODE" = "200" ] && break
  sleep 10
done

echo ""
echo "✅ 发布完成"
echo "   网址：https://tczyliu.github.io/xiaozhongyi-pages/"
echo "   （浏览器可能有缓存，看不到新内容就 Cmd+Shift+R 强制刷新）"
