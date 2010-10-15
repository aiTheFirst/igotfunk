require "#{File.dirname(__FILE__)}/lib/helpers/slider_helper"

ActionView::Helpers::AssetTagHelper::register_javascript_include_default "slider"
ActionView::Base.send :include, ActionView::Helpers::SliderHelper