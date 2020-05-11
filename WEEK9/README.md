{%hackmd BJrTq20hE %}

###### tags: `Blockchain課程`

# 新增ssh key至github

## 步驟1 Generating a new SSH key

```bash
$ ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```
RSA(是一種加密方法)
> RSA加密演算法是一種非對稱加密演算法，是利用質數來加密，因為暴力比較不容易算，在公開金鑰加密和電子商業中被廣泛使用。
> 

![](https://i.imgur.com/ZDZKBg9.png)

## 步驟2 進入~/.ssh 
找出一個叫```id_rsa.pub```的檔案然後複製裡面內容，```.pub```結尾的就是public key

### passphrase
>passphrase 跟 Github 密碼毫無關係，這只是讓 private key 多一層保障。在建立 SSH key 時如果有指定 passphrase，以後就算有人拿到你的 private key 檔案也沒辦法用他。缺點是會導致每次 push 都要輸入 passphrase。
>

## 步驟3 加入至agent中

```bash
 # persistently add default keys to Keychain 
 ssh-add -K ~/.ssh/id_rsa
```
Add your SSH private key to the ssh-agent and store your passphrase in the keychain. If you created your key with a different name, or if you are adding an existing key that has a different name, replace id_rsa in the command with the name of your private key file.



### agent 
>溝通 伺服器 就是你得告訴他你目前的私鑰是誰 

![](https://i.imgur.com/Mk07pA1.png)




## 步驟4  複製出來貼上至Github
貼在key 裡面 
然後要在記得底下打勾(因為沒打勾，就會只能拉pull，不能push)
![](https://i.imgur.com/0OSKB69.png)


[多重 SSH Keys 與 Github 帳號](https://kuanyui.github.io/2016/08/01/git-multiple-ssh-key/)

[Generating a new SSH key and adding it to the ssh-agent](https://help.github.com/en/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)



