module ScreenshotsHelper
  
#  def pagination_links_remote(paginator)
#    page_options = {:windows_size => 1}
#    pagination_links_each(paginator, page_options) do |n|
#      options = {
#        :url => {:action => 'index', :params => @params.merge({:page => n})},
#        :update => 'table',
#        :before => "Element.show('ajax-loader)",
#        :success => "Element.hide('ajax-loader')"
#      }
#      html_options = {:href => url_for(:action => 'list',
#                      :params => @params.merge({:page => n}))}
#      link_to_remote(n.to_s, options, html_options)
#    end
#  end
  
end