# History，本步骤主要用于记录所有远程登陆服务器的用户在服务器上的操作记录；

#########################################################################
# 操作步骤：
# 1.把下面的命令追加到 /etc/profile 文件的末尾；
# 2.运行 source /etc/profile；重新加载文件使之生效；然后在命令行运行 chmod 777 /tmp/.log/user.log；
# 3.如果没有生效就退出当前SHELL；然后重新登陆；
#########################################################################

# 定义个方法/函数
function log2file
{
# 设置history文件的格式
export HISTTIMEFORMAT="[%Y-%m-%d %H:%M:%S] [`who am i 2>/dev/null| awk '{print $NF}'|sed -e 's/[()]//g'`] "
# 设置后的history文件
# 1027  [2020-01-08 15:48:12] [10.10.10.3] cat /etc/profile
# 第几行 时间 来源ip 命令

export PROMPT_COMMAND='\
  #  if [ -z "$OLD_PWD" ]
  # 判断字符串$OLD_PWD长度是否为零
  if [ -z "$OLD_PWD" ];then
        export OLD_PWD=$(pwd);
  fi;
  logdir="/tmp/.log"
  [ ! -d $logdir ] && mkdir -pv $logdir && chmod 777 $logdir
  if [ ! -z "$LAST_CMD" ] && [ "$(history 1)" != "$LAST_CMD" ]; then
        # 写入到指定路径的文件中
        # >> 追加到文件中
        echo  `whoami` "[$OLD_PWD]$(history 1)" >> $logdir/user.log
  fi ;
  # 设置指代变量
  export LAST_CMD="$(history 1)";
  export OLD_PWD=$(pwd);'
}
# trap command [EXIT，ERR，DEBUG]
# 简单来说就是调用方法/函数
# 调试所用，具体可以看看trap用法
log2file
