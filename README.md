✚ Switzerland is ...

 - home to the Swiss Alps
 - a great place to stash some cash
 - credited for graphic design characterized by grids & sans-serif type
 - the frickin’ birthplace of the world wide web
 - famously ~ neutral ~

It’s also a static content generator written in Ruby that offers common functionality for the genre:

 - File and folder-based
 - [Markdown][1] (using [Kramdown][2] means we get [PHP Markdown Extra][3] hotness)
 - YAML front matter

Unlike static site generators, Switzerland’s output is exclusively JSON. Content is accessed from paths that mirror the file structure, which could have RESTful tendencies — or not. Present it however you’d like, using any JSON-capable platform. That could even mean GitHub or Dropbox. If it’s `OK 200`, you’re good!


Getting Started
--------------------------------------------------------------------------------

In the folder containing the content you’d like to publish, simply run Switzerland’s publish script:

```
$ publish
```


--------------------------------------------------------------------------------

Example image is a photo taken by Patrick S on Flickr (CC BY-NC-SA 2.0):
http://www.flickr.com/photos/undercrimson/6133891067

[1]: http://daringfireball.net/projects/markdown
[2]: http://kramdown.rubyforge.org
[3]: http://michelf.ca/projects/php-markdown/extra