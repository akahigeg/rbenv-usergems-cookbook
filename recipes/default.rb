#
# Cookbook Name:: rbenv_usergems
# Recipe:: default
#

include_recipe "rbenv::default"
include_recipe "git"

node.set[:rbenv_usergems][:prefix] = "#{node[:rbenv][:root]}/plugins/ruby_usergems"

git node[:rbenv_usergems][:prefix] do
  repository node[:rbenv_usergems][:git_repository]
  reference node[:rbenv_usergems][:git_revision]
  user node[:rbenv][:user]
  group node[:rbenv][:group]
  action :sync
end

execute "usergems-init" do
  command %q{echo 'eval "$(rbenv usergems-init -)"' >> /etc/profile.d/rbenv.sh}
  not_if "cat /etc/profile.d/rbenv.sh | grep -q 'usergems-init'"
end
