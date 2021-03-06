#
# Cookbook Name:: homebrew
# Recipes:: cask
#
# Copyright 2014, Chef Software, Inc <legal@chef.io>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
Chef::Resource.send(:include, Homebrew::Mixin)

homebrew_tap 'caskroom/cask'

package 'brew-cask'

execute 'update homebrew cask from github' do
  user node['homebrew']['owner'] || homebrew_owner
  command '/usr/local/bin/brew upgrade brew-cask && /usr/local/bin/brew cask cleanup || true'
  only_if { node['homebrew']['auto-update'] }
end

directory '/opt/homebrew-cask' do
  owner node['homebrew']['owner'] || homebrew_owner
  mode 00775
end

directory '/opt/homebrew-cask/Caskroom' do
  owner node['homebrew']['owner'] || homebrew_owner
  mode 00775
end
