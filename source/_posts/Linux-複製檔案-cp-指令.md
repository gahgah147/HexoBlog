---
title: Linux 複製檔案 cp 指令
date: 2023-10-18 18:45:16
tags: 
 - Linux
---

# 複製檔案
若要將 source.txt 檔案複製一份到 dest.txt，可以執行：
```
# 將 source.txt 複製到 dest.txt
cp source.txt dest.txt
```
# 複製目錄
如果要複製整個目錄以及該目錄下的所有子目錄與檔案，可以加上 -r 參數（或是 -R、--recursive 參數亦可），以遞迴的方式進行複製：

```
# 將 myfolder 目錄複製到 /path/to/ 路徑下
cp -r myfolder /path/to/
```
# 強制覆蓋檔案
如果希望 cp 指令在無法寫入目的檔案時，嘗試刪除目的檔案，再重新複製一份新的檔案，可以加上 -f 或 --force 參數：

```
cp -f source.txt dest.txt
```

# 不要覆蓋既有檔案
如果希望 cp 指令遇到目的檔案已經存在的狀況，不要覆蓋既有的檔案，可以加上 -n 或 --no-clobber 參數：
```
cp -n source.txt dest.txt
```

# 自動備份檔案
若希望 cp 指令在覆蓋檔案時，可以將舊檔案自動備份起來，可以加上 -b 或 --backup 參數：
```
cp -b source.txt dest.txt
```

# 保留檔案屬性
若希望 cp 在複製檔案時，可以連同檔案屬性一起複製，可以加上 -p 或 --preserve 參數：
```
cp -p source.txt dest.txt
```
# 連結檔解析

假設我們建立一個連結檔 link.txt 指向 source.txt：

建立連結檔
```
ln -s source.txt link.txt
```
如果希望 cp 指令在複製連結檔案時，能夠解析連結檔所指向的實際檔案，複製那一個實際的目標檔案，可以加上 -L 或 --dereference 參數：

```
cp -L link.txt dest.txt
```
由於 link.txt 是指向 source.txt 的連結檔，所以這裡的 dest.txt 實際上就是從 source.txt 所複製出來了。

若希望 cp 指令在複製連結檔案時，不要進行連結的解析，僅將連結檔直接複製，則可改用 -P 或 --no-dereference 參數：
```
cp -P link.txt link2.txt
```


# 參考資料
[Linux 複製檔案 cp 指令用法教學與範例](https://blog.gtwang.org/linux/linux-cp-command-copy-files-and-directories-tutorial/)

[HowtoForge：Linux cp command tutorial for beginners (8 examples)](https://www.howtoforge.com/linux-cp-command/)
[GeeksforGeeks：cp command in Linux with examples](https://www.geeksforgeeks.org/cp-command-linux-examples/)