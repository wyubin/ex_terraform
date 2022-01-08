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
```shell
# get resource，有設定的 private key
cat terraform.tfstate.backup | jq '.resources[0]'
# get first instance
cat terraform.tfstate.backup | jq '.resources[0].instances[0].attributes'
```
# 從簡單的 tf 學怎麼寫
- 在資料夾中全部的 tf 都會在 plan 時載入，override 後綴的檔案會在最後才merge 進去
- 以azure/_poc/user 做範例，先基於 provider.tf 定義 "provider"
- 再從 ad_user.tf 去經由外來的 provider 跟 基本 module 去產生 resource，利用 "azuread_user" 建立 authenticated 功能，並利用 "random_password" 產生隨機密碼給指定 user
- 最後的 output 是指 expose 出來的變數，並說明 password 是 sensitive

## 載入
```shell
# 載入需要的套件
terraform init
# apply
terraform plan
terraform apply
```
- 確認資料
```shell
# 雖然 output 還是會隱蔽密碼
Outputs:

password = <sensitive>
user_principal_name = "yubin@wyubinhotmail.onmicrosoft.com"
# 但還是可以從 tfstate 查
cat terraform.tfstate | jq '.outputs'
```
