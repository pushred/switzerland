#!/usr/bin/ruby

require 'redcarpet'
require 'fileutils'
require 'active_support/core_ext'
require 'yaml'

content_path = Dir.pwd

markdown_filetypes = ['.md','.markdown']
image_filetypes = ['.jpg','.png','.gif','.svg']
destination = ARGV[0] || 'published'

if File.exists? destination
  FileUtils.chdir destination
  FileUtils.rm_rf Dir['**/**']
  FileUtils.chdir content_path
else
  FileUtils.mkdir_p(destination)
end

Dir['**/**'].sort.each do |path|

  next if path === destination

  if File.directory? path

    FileUtils.mkdir_p File.join destination, path

  elsif image_filetypes.include? File.extname(path)

    published_path = File.join destination, File.dirname(path)
    FileUtils.cp path, published_path

  elsif markdown_filetypes.include? File.extname(path)

    published_path = File.join destination, File.dirname(path)

    markdown_filename = File.basename( path, File.extname(path) )
    markdown_file = ''

    File.open(path, 'r').each { |line| markdown_file << line }

    next if markdown_file.length === 0

    renderer = Redcarpet::Render::XHTML.new
    markdown = Redcarpet::Markdown.new(renderer, :fenced_code_blocks => true, :tables => true, :autolink => true)

    yaml_content = YAML.load( markdown_file.match(/\A(---\s*\n.*?\n?)^(---\s*$\n?)/m).to_s ) # RegEx by Derek Worthen (Middleman implementation)
    html_content = markdown.render markdown_file.lines.to_a[0..-1].join

    json_content = {
      :body => html_content,
      :slug => markdown_filename
    }

    json_content.merge( yaml_content ) if yaml_content

    File.open(published_path + '/' + markdown_filename + '.html', 'w') do |file|
      file.write html_content
      file.close
    end

    File.open(published_path + '/' + markdown_filename + '.json', 'w') do |file|
      file.write Hash[json_content.to_a.reverse].to_json
      file.close
    end

  end

end