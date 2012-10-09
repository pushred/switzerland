require 'nokogiri'
require 'json'

ROOT = FileUtils.pwd
PUBLISH_SCRIPT = File.join ROOT, 'publish.rb'
CONTENT_PATH = File.join ROOT, 'test'

destination = 'published'

Before do
  FileUtils.mkdir CONTENT_PATH unless File.exists? CONTENT_PATH
  Dir.chdir CONTENT_PATH
end

After do
  FileUtils.rm_rf CONTENT_PATH
end

Given /^a folder containing image files$/ do
  `curl -o test.jpg -s http://farm5.staticflickr.com/4027/4711833381_b444090dcc.jpg`
end

Given /^.*a folder containing Markdown files.*$/ do |example_markdown|
  File.open('example.md', 'w') do |file|
    file.write example_markdown
    file.close
  end
end

Given /^.*a folder containing files with Markdown and YAML content.*$/ do |example_content|
  File.open('example.md', 'w') do |file|
    file.write example_content
    file.close
  end
end

Given /^a tree of folders$/ do
  FileUtils.mkdir_p 'fruits/citrus/tangerines'
  File.open('fruits/citrus/tangerines/test.md', 'w') do |file|
    file.write '# Test'
    file.close
  end
end

When /^I publish content$/ do
  destination = 'published'

  `ruby #{PUBLISH_SCRIPT}`
  raise('Script not found') unless $?.success?
end

When /^I publish content with a specified destination$/ do
  destination = 'somewhere/else'

  `ruby #{PUBLISH_SCRIPT} #{destination}`
  raise('Script not found') unless $?.success?
end

Then /^the destination will be created if it does not exist$/ do
  File.exists?( File.join destination ).should === true
end

And /^any contents will be emptied$/ do
  (Dir['#{destination}/**/**'].empty?).should === true
end

Then /^the images will be included$/ do
  File.exists?( File.join destination, 'test.jpg' ).should === true
end

Then /^.*that tree will be.*$/ do
  File.exists?( File.join destination, 'fruits', 'citrus', 'tangerines', 'test.html' ).should === true
end

Then /^the Markdown will be converted into HTML$/ do
  example_markdown = File.join destination, 'example.html'

  File.exists?(example_markdown).should === true

  File.open(example_markdown, 'r') do |content|
    Nokogiri::HTML.parse(content).css('h1').length.should > 0
  end
end

Then /^the content will be published as JSON$/ do
  example_json = File.join destination, 'example.json'

  File.open(example_json, 'r') do |content|
    JSON.parse(content.read)
  end
end

And /^the destination will match the specified destination$/ do
  File.exists?( File.join destination, 'fruits', 'citrus', 'tangerines', 'test.html' ).should === true
end