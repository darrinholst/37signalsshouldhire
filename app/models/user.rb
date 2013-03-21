require 'html/pipeline'

class User < ActiveRecord::Base
  def formatted_bio
    filters = [HTML::Pipeline::MarkdownFilter]
    pipeline = HTML::Pipeline.new(filters)
    pipeline.call(bio)[:output].to_s
  end
end
