從遠端載入模組
[Ref](https://ithelp.ithome.com.tw/articles/10260669)
- 除了從 local 資料夾導入 module 外，比較實用的方式是從 remote 導入，而最常用的就是 Git
- 只要把 source 的地方改成從 Git 導入的寫法就可以[git_remote](https://www.terraform.io/language/modules/sources#generic-git-repository)
- terraform init 後，會先下載所指定 module 再檢查 backend
```shell
# 發現在不同 module 都會 git clone 各一次
tree -L 3 .terraform
```
![](2022-01-09-16-31-25.png)
