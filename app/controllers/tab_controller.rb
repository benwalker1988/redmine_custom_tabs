
class TabController < ApplicationController
  unloadable
  
  layout 'base'
  
  before_action :find_project, :authorize, :only => [:show]
  
  def show
    tabs = YAML.load(Setting.plugin_redmine_custom_tabs['tab_yml'])
    @tab_text = tabs[params[:tab]]['framesrc']
    @tab = params[:tab]
  end

  private
  
  def find_project
    @project = Project.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end
end
