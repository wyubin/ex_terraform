[Ref](https://ithelp.ithome.com.tw/articles/10259586)
# 確認 .tfstate
```shell
cat terraform.tfstate.backup
# 確認主要 items
cat terraform.tfstate.backup | jq keys
[
  "lineage",
  "outputs",
  "resources",
  "serial",
  "terraform_version",
  "version"
]
```
- resources 主要是資源設定，對應 main.tf 的相關設定所產生在 azure 上的狀態
- tfstate 需要存在才能正確地連結，如果沒有則需要 apply，而且需要重新 create remote instance ，tfstate 在 access cloud 時會 sync metadata
- 如果在協作狀況下，tfstate 也需要進到版本控制，才能保證修改 resource 後，能夠讓他人也能夠在之後進行操作
