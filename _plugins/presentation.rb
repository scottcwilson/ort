# coding: utf-8
require 'amazon/ecs'
require 'singleton'
require 'i18n'

module Jekyll
  module Amazon
    class ItemAttribute
      def to_span_html
        str = "<span class=\"jk-amazon-info-#{key}\">"
        str += "#{value}"
        str += '</span><br />'
        str
      end
    end

    class AmazonTag < Liquid::Tag
      def short_detail(item)
        attrs = {
          title: item[:title],
          author: item[:author],
        }.map { |k, v| ItemAttribute.new(k, v).to_span_html }.join("\n")

        str = <<-"EOS"
<div class="jk-amazon-item">
  #{image(item)}
  <span class="jk-amazon-info">
    #{attrs}
  </span>
</div>
<br clear="all" />
        EOS
        str.to_s
      end

    end
  end
end

Liquid::Template.register_tag('amazon', Jekyll::Amazon::AmazonTag)
