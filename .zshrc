# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH=$PATH:/usr/local/mysql/bin
eval "$(pyenv init --path)"
eval "$(rbenv init -)"

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# peco
## ls | p cd
p() { peco | while read LINE; do $@ $LINE; done }

## Ctrl + ] => ghq
function peco-src () {
  local selected_dir=$(ghq list -p | peco --prompt "REPOSITORY >" --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

alias g='cd $(ghq list -p | peco)'
alias gh='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'

function tenv() {
    get_terraform_root_dir
    cd "${CUSTOM_TERRAFORM_PATH_PART}/terraform/environment"
}

function rmod() {
    get_terraform_root_dir
    cd "${CUSTOM_TERRAFORM_PATH_PART}/terraform/modules"
}

function ttera() {
    get_terraform_root_dir
    cd "${CUSTOM_TERRAFORM_PATH_PART}/terraform"
}

function ttera() {
    get_terraform_root_dir
    cd "${CUSTOM_TERRAFORM_PATH_PART}/terraform"
}

function tmain() {
    local env=$1
    get_terraform_root_dir
    cd "${CUSTOM_TERRAFORM_PATH_PART}/terraform/configuration_env/${env}/main.tf"
}

function ttera() {
    get_terraform_root_dir
    cd "${CUSTOM_TERRAFORM_PATH_PART}/terraform"
}

function get_terraform_root_dir() {
    # 現在のディレクトリを取得
    local full_path=$(pwd)

    # '/'を区切りとして、6つ目までのパスを抽出
    local extracted_path=$(echo "$full_path" | cut -d'/' -f1-7)

    # 変数に保存（グローバルスコープで使用する場合）
    CUSTOM_TERRAFORM_PATH_PART=$extracted_path
}

function rmod() {
    get_rails_root_dir
    cd "${CUSTOM_RAILS_PATH_PART}/app/models"
}

function rcon() {
    get_rails_root_dir
    cd "${CUSTOM_RAILS_PATH_PART}/app/controllers"
}

function rapp() {
    get_rails_root_dir
    cd "${CUSTOM_RAILS_PATH_PART}/app"
}

function rser() {
    get_rails_root_dir
    cd "${CUSTOM_RAILS_PATH_PART}/app/services"
}

function rconf() {
    get_rails_root_dir
    cd "${CUSTOM_RAILS_PATH_PART}/config"
}

function rroot() {
    get_rails_root_dir
    cd "${CUSTOM_RAILS_PATH_PART}"
}

function get_rails_root_dir() {
    # 現在のディレクトリを取得
    local full_path=$(pwd)

    # '/'を区切りとして、6つ目までのパスを抽出
    local extracted_path=$(echo "$full_path" | cut -d'/' -f1-7)

    # 変数に保存（グローバルスコープで使用する場合）
    CUSTOM_RAILS_PATH_PART=$extracted_path
}

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection


function _dssh() {
  local profile=$1
  local key_name=$2
  local jump=$3
  local hosts=$(
    aws-vault exec "$profile" -- aws ec2 describe-instances \
        --filters "Name=instance-state-name,Values=running" "Name=key-name,Values=$key_name" \
      | jq -r '.Reservations[].Instances[] | {InstanceName: (.Tags[] | select(.Key=="Name").Value), PrivateIpAddress, PublicIpAddress, InstanceId} | "\(.InstanceName) \(.PrivateIpAddress) \(.PublicIpAddress) \(.InstanceId)"' \
      | sort | peco | awk '{print $2}'
  )
    ssh -i "$HOME/.ssh/$key_name.pem" -o ProxyCommand="ssh -W %h:%p '"$jump"'" -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "ec2-user@$hosts"
}

function _dsm() {
  local profile=$1
  local environment=$2
  local environment_short=$3
  local instance_id=$(
    aws-vault exec "$profile" -- aws ec2 describe-instances \
        --filters "Name=instance-state-name,Values=running" "Name=tag:environment,Values=[$environment, $environment_short]" \
      | jq -r '.Reservations[].Instances[] | {InstanceName: (.Tags[] | select(.Key=="Name").Value), PrivateIpAddress, PublicIpAddress, InstanceId} | "\(.InstanceName) \(.PrivateIpAddress) \(.PublicIpAddress) \(.InstanceId)"' \
      | sort | peco | awk '{print $4}'
  )
    aws-vault exec "$key_name" -- aws ssm start-session --target "$instance_id"
}

function _ecs_exec() {
   local profile=$1
   local cluster_name=$2
   local service_name=$3
   local container_name=$4
   local task_arn=$(aws-vault exec $profile -- aws ecs list-tasks --cluster ${cluster_name} --service-name ${service_name} | jq -r '.taskArns[0]')
   local task_id=`echo ${task_arn} | sed -E 's/.+task\/.+\///g' `
   local container_name="${container_name}"
   local exec_command=$5

   echo $profile
   echo $cluster_name
   echo $task_arn
   echo $task_id
   echo $container_name
   echo $exec_command

   aws-vault exec "$profile" -- aws ecs execute-command \
       --cluster $cluster_name \
       --task $task_id \
       --container $container_name \
       --interactive \
       --command "$exec_command"
}

function _connect_to_db() {
   local profile=$1
   local cluster_name=$2
   local service_name=$3
   local task_arn=$(aws-vault exec $profile -- aws ecs list-tasks --cluster ${cluster_name} --service-name ${service_name} | jq -r '.taskArns[0]')
   local task_id=`echo ${task_arn} | sed -E 's/.+task\/.+\///g' `
   local runtime_name=$(aws-vault exec $profile -- aws ecs describe-tasks --cluster ${cluster_name} --tasks ${task_id} | jq -r ".tasks[].containers[] | select(.name == ${container_name}) | .runtimeId")
   local container_name=$4
   local db_endpoint=$5

   echo $profile
   echo $cluster_name
   echo $task_arn
   echo $task_id
   echo $runtime_name
   echo $db_endpoint

   aws-vault exec "$profile" -- aws ssm start-session \
           --target ecs:"$cluster_name"_"$task_id"_"$runtime_name" \
           --document-name AWS-StartPortForwardingSessionToRemoteHost \
           --parameters "{\"host\":[\"$db_endpoint\"],\"portNumber\":[\"3306\"], \"localPortNumber\":[\"33061\"]}"
}
