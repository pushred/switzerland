#!/usr/bin/ruby

require 'redcarpet'
require 'fileutils'
require 'active_support/core_ext'
require 'yaml'
require 'nokogiri'

def publish_content(source_path, destination_path)

  image_filetypes = ['.jpg','.png','.gif','.svg']
  markdown_filetypes = ['.md','.markdown']

  if image_filetypes.include? File.extname(source_path)

    destination_path = File.join destination_path, File.dirname(source_path)
    FileUtils.cp source_path, destination_path

  elsif markdown_filetypes.include? File.extname(source_path)

    destination_path = File.join destination_path, File.dirname(source_path)

    markdown_filename = File.basename( source_path, File.extname(source_path) )
    markdown_file = ''

    File.open(source_path, 'r').each { |line| markdown_file << line }

    renderer = Redcarpet::Render::XHTML.new(:with_toc_data => true)
    markdown = Redcarpet::Markdown.new(renderer, :fenced_code_blocks => true, :tables => true, :autolink => true)

    yaml_content = YAML.load( markdown_file.match(/\A(---\s*\n.*?\n?)^(---\s*$\n?)/m).to_s ) # RegEx by Derek Worthen (Middleman implementation)
    html_content = markdown.render markdown_file.lines.to_a[0..-1].join

    anchors = []

    Nokogiri::HTML.parse(html_content).css('h1, h2, h3, h4, h5, h6').each do |heading|
      next unless heading.attribute('id')
      anchors.push({ 'tag' => heading.name, 'text' => heading.text, 'anchor' => heading.attribute('id').value })
    end

    json_content = {
      :body => html_content,
      :slug => markdown_filename,
      :anchors => anchors
    }

    json_content.merge( yaml_content ) if yaml_content

    File.open(destination_path + '/' + markdown_filename + '.html', 'w') do |file|
      file.write html_content
      file.close
    end

    File.open(destination_path + '/' + markdown_filename + '.json', 'w') do |file|
      file.write Hash[json_content.to_a.reverse].to_json
      file.close
    end

  end
end

# Traverse content, generate published version

base_path = Dir.pwd
destination_path = ARGV.last || 'published'
destination_path = File.expand_path destination_path

if ARGV.length > 1
  source_paths = ARGV[0..-2]
else
  source_paths = [base_path]
end

if File.exists? destination_path
  FileUtils.chdir destination_path
  FileUtils.rm_rf Dir['**/**']
  FileUtils.chdir base_path
else
  FileUtils.mkdir_p destination_path
end

source_paths.each do |source_path|
  next if source_path === destination_path

  if File.exists?(source_path) && File.directory?(source_path)
    FileUtils.chdir source_path

    Dir['**/**'].sort.each do |source_path|
      if File.directory?(source_path)
        FileUtils.mkdir_p File.join( destination_path, source_path )
      elsif File.size(source_path) > 0
        FileUtils.mkdir_p File.dirname( File.join( destination_path, source_path ) )
        publish_content(source_path, destination_path)
      end
    end

  elsif File.exists?(source_path) && File.size(source_path) > 0
    FileUtils.chdir base_path
    FileUtils.mkdir_p File.dirname( File.join(destination_path, source_path) )

    publish_content(source_path, destination_path)
  end

end