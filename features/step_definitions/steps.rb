require 'nokogiri'
require 'json'

ROOT = FileUtils.pwd
PUBLISH_SCRIPT = File.join ROOT, 'publish.rb'
TMP_TEST_PATH = File.join ROOT, 'test'

destination = 'published'

Before do
  FileUtils.mkdir TMP_TEST_PATH unless File.exists? TMP_TEST_PATH
  Dir.chdir TMP_TEST_PATH
end

After do
  FileUtils.rm_rf TMP_TEST_PATH
end

Given /^a folder containing empty stub files$/ do
  `touch test.md`
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

Given /^.*Markdown containing headings.*$/ do |example_markdown|
  File.open('example.md', 'w') do |file|
    file.write example_markdown
    file.close
  end
end

Given /^.*Markdown containing fenced code blocks.*$/ do |example_markdown|
  File.open('example.md', 'w') do |file|
    file.write example_markdown
    file.close
  end
end

Given /^a tree of folders$/ do
  FileUtils.mkdir_p 'cheese/cows/swiss'
  File.open('cows.md', 'w') do |file|
    file.write '# Cow Milk'
    file.close
  end
  File.open('cheese/cows/swiss/emmentaler.md', 'w') do |file|
    file.write '# The Real Swiss Cheese'
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
  File.exists?( File.join destination, 'cheese', 'cows', 'swiss', 'emmentaler.html' ).should === true
end

When /^I specify one or more sources of content and a destination$/ do
  sources = 'cows.md cheese/cows'
  destination = 'somewhere/else'

  `ruby #{PUBLISH_SCRIPT} #{sources} #{destination}`
  raise('Script not found') unless $?.success?
end

Then /^only those sources will be published into the destination$/ do
  File.exists?( File.join destination, 'cows.html' ).should === true
  File.exists?( File.join destination, 'swiss', 'emmentaler.html' ).should === true
end

Then /^the Markdown will be converted into HTML$/ do
  example_markdown = File.join destination, 'example.html'

  File.exists?(example_markdown).should === true

  File.open(example_markdown, 'r') do |content|
    Nokogiri::HTML.parse(content).css('h1').length.should > 0
  end
end

Then /^the code block will be converted into HTML$/ do
  example_markdown = File.join destination, 'example.html'

  File.exists?(example_markdown).should === true

  File.open(example_markdown, 'r') do |content|
    Nokogiri::HTML.parse(content).css('code.ruby').length.should > 0
  end
end


Then /^the syntax will be highlighted using Pygments\.rb$/ do
  example_markdown = File.join destination, 'example.html'

  File.exists?(example_markdown).should === true

  File.open(example_markdown, 'r') do |content|
    Nokogiri::HTML.parse(content).css('span[class]').length.should === 5
  end
end

And /^each heading will be assigned a unique anchor$/ do
  example_markdown = File.join destination, 'example.html'

  File.open(example_markdown, 'r') do |content|
    Nokogiri::HTML.parse(content).css('h1[id], h2[id], h3[id]').length.should === 3
  end
end

Then /^.*content will be published as JSON.*$/ do
  example_json = File.join destination, 'example.json'

  File.open(example_json, 'r') do |content|
    JSON.parse(content.read)
  end
end

And /^the anchors will be published as JSON$/ do
  example_json = File.join destination, 'example.json'

  File.open(example_json, 'r') do |content|
    anchors = JSON.parse(content.read)['anchors']
    anchors[0]['tag'].should === 'h1'
    anchors[1]['tag'].should === 'h2'
    anchors[2]['tag'].should === 'h3'
  end
end

And /^the destination will match the specified destination$/ do
  File.exists?( File.join destination, 'cheese', 'cows', 'swiss', 'emmentaler.html' ).should === true
end