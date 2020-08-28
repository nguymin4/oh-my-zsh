source $ZSH_CUSTOM/plugins/zsh-async/async.plugin.zsh
async_init

run_async() {
  async_start_worker $1 -n
  async_register_callback $1 $2
  async_job $1 sleep 0.1
}
