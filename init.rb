
require 'redmine'

Redmine::Plugin.register :redmine_custom_tabs do
  name 'Custom Tabs'
  author 'Ben Walker'
  description 'Add custom tabs to each project, configurable by yaml'
  version '0.1'

  settings :default => {
    'tab_yml' => '',
  }, :partial => 'settings/redmine_custom_tab_settings'

  project_module :tab do
    permission :view_tab, {:tab => :show}
  end
end

Rails.application.config.after_initialize do
  yamltext = Setting.plugin_redmine_custom_tabs['tab_yml']
  if !yamltext.empty?
    tabs = YAML.load(yamltext)
    tabs.each do | tabid, tabdata |
      Redmine::MenuManager.map(:project_menu).push(tabid, { :controller => 'tab', :action => 'show', :tab => tabid }, { :caption => tabdata['name']})
    end
  end
end
