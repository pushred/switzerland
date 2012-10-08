#!/usr/bin/ruby

require 'redcarpet'
require 'fileutils'

content_path = Dir.pwd

markdown_filetypes = ['.md','.markdown']
image_filetypes = ['.jpg','.png','.gif','.svg']

if File.exists? 'published'
  FileUtils.chdir 'published'
  FileUtils.rm_rf Dir['**/**']
  FileUtils.chdir content_path
else
  FileUtils.mkdir_p('published')
end

Dir['**/**'].sort.each do |path|

  next if path === 'published'

  if File.directory? path

    FileUtils.mkdir_p File.join 'published', path

  elsif image_filetypes.include? File.extname(path)

    published_path = File.join 'published', File.dirname(path)
    FileUtils.cp path, published_path

  elsif markdown_filetypes.include? File.extname(path)

    published_path = File.join 'published', File.dirname(path)
    markdown_filename = File.basename( path, File.extname(path) )
    markdown_file = ''

    renderer = Redcarpet::Render::XHTML.new
    markdown = Redcarpet::Markdown.new(renderer, :fenced_code_blocks => true, :tables => true, :autolink => true)

    File.open(path, 'r').each {|line| markdown_file << line}

    File.open(published_path + '/' + markdown_filename + '.html', 'w') do |file|
      file.write markdown.render markdown_file.lines.to_a[1..-1].join
      file.close
    end
  end

end