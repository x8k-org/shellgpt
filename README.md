# shellgpt
Query chatgpt from your shell

## Installation

Copy script to a path dir and make it executable

```bash
git clone https://github.com/kpatronas/shellgpt.git
cd shellgpt
sudo cp ./chatgpt.sh /usr/bin/chatgpt
sudo chmod +x /usr/bin/chatgpt
```

Create path for the chatgpt config file and copy it in

```bash
mkdir ~/.chatgpt/
cp ./chatgpt ~/.chatgpt/
```

Then edit file to match your config

BEARER expects your API Token that you can create at https://beta.openai.com/account/api-keys

```bash
MODEL="text-davinci-003"
TEMPERATURE="0"
MAX_TOKEN=4000
BEARER="sk-GgaCYH4z_THIS_IS_A_FAKE_Jk2g9BJNkrOp5s"
```

## How to use shellgpt

Example: simple output

```bash
$ chatgpt -p "print the 3 most used linux commands, new-line separated"
ls
cd
mv
```

Example: pipe output

```bash
$ chatgpt -p "print the 3 most used linux commands, new-line separated" | xargs -I {} bash -c 'echo "" && chatgpt -p "Create an example about the {} command
" && sleep 10'
The ls command is a command line utility used to list the contents of a directory. To use the ls command, open a terminal window and type \"ls\" followed by the directory you want to list. For example, to list the contents of the current directory, type \"ls\" and press enter. The output will be a list of all the files and folders in the directory.

The cd command is used to change the current working directory in a command line interface. For example, if you are in the directory /home/user/Documents and you want to change to the directory /home/user/Pictures, you can use the command cd /home/user/Pictures. This will change the current working directory to /home/user/Pictures.

The mv command is used to move or rename files and directories. For example, if you wanted to move a file named \"example.txt\" from the current directory to a directory named \"Documents\", you would use the following command:
mv example.txt Documents/
```

Example: generate command and execute it

```bash
chatgpt -p "Create a bash command that will print current date minus one month"
date --date=\"1 month ago\"
$ chatgpt -p "Create a bash command that will print current date minus one month" | xargs -I {} bash -c '{}'
Tue Dec 20 20:09:42 EET 2022
```
