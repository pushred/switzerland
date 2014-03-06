# ✚ Switzerland

 - home to the Swiss Alps
 - a great place to stash some cash
 - eponymous graphic design: grids and Helvetica!
 - the frickin’ birthplace of the world wide web
 - famously ~ neutral ~

![Mexican beetle](//Mexican%20Beetle.jpg)

It’s also a static content generator written in Ruby. It’s like [Jekyll][jekyll] and [Middleman][middleman] in that it offers:

 - Git-friendly file & folder-based content management
 - [Markdown][markdown] formatting via [Kramdown][kramdown]
 - [Fenced code blocks][code-blocks] with optional syntax highlighting
 - YAML front matter

Missing is anything involving templates, pages, or assets. Switzerland’s output is primarily JSON, intended for consumption client or server-side. Any platform capable of making a GET request is `OK 200`. Publish content to GitHub or a Dropbox and access it from your app, website, or even a web browser.


Usage
--------------------------------------------------------------------------------

~~~
✚ gem install switzerland
✚ switz
~~~

If no arguments are provided Switzerland will inspect the local directory recursively and:

 - Duplicate your content’s folder structure wherever the published content will live
 - Pass any files ending in `.md` or `.markdown` through Kramdown
 - Generate and save “published” HTML and JSON versions of each Markdown file
 - Copy any image files alongside generated JSON/HTML

### Specify a Source

One or more source files and folders can be specified just like [cp][man-cp]. If source content is specified a publishing destination must also be provided.

~~~
✚ switz cheese overview.md published
~~~

The above command would create:

~~~
published/overview.html
published/overview.json
published/cheese/emmentaler.html
published/cheese/emmentaler.json
published/cheese/forked/jarlsberg.html
published/cheese/forked/jarlsberg.json
published/cheese/forked/leerdammer.html
published/cheese/forked/leerdammer.json
published/cheese/forked/maasdam.html
published/cheese/forked/maasdam.json
~~~

### Specify a Publishing Destination

If no arguments are provided then published content will be automatically saved into a relative directory named `published`. This may be overridden with an argument that either appears after specified source paths or by itself as the only argument.

~~~
✚ switz cheese.md public
~~~

···

~~~
public/cheese.html
public/cheese.json
~~~


Demo
--------------------------------------------------------------------------------

~~~
✚ echo "# Hallo" >> hallo.md
✚ switz hallo.md published
✚ ls -1 published
hallo.html
hallo.json
~~~

#### hallo.html

~~~ html
<h1>Hallo</h1>
~~~

#### hallo.json

~~~ javascript
{
    "anchors": [{
        "tag": "h1",
        "text": "Hallo",
        "anchor": "toc-hallo"
    }],
    "slug": "hallo",
    "body": "<h1 id=\"toc-hallo\">Hallo</h1>"
}
~~~


Syntax Highlighting
--------------------------------------------------------------------------------

Use [fenced code blocks][code-blocks] to easily reference example code. The following format is also conveniently recognized by [GitHub Flavored Markdown][gfm]:

	~~~ javascript
	alert('hallo!');
	~~~

Kramdown generates the following markup from the example above.

~~~~~~~ html
<pre>
    <code class="language-javascript">
        alert('hallo!');
    </code>
</pre>
~~~~~~~

If a language is specified in the opening fence it is used to generate a class [as recommended][code-class]. This is useful when using client-slide libraries such as [google-code-prettify][prettify] and [Prism.js][prism].

#### Go automatic with CodeRay

If the [CodeRay][coderay] gem is installed the above example would be automatically converted into this markup, with classes to select & style:

~~~~~~~ html
<div>
    alert(<span class="string"><span class="delimiter">'</span><span class="content">hallo!</span><span class="delimiter">'</span></span>);
</div>
~~~~~~~


YAML Front Matter
--------------------------------------------------------------------------------

Provide key/value pairs in front of your Markdown content like so and they will be mixed into the published JSON:

```
---
layout: three-column
title: Switzerland Ain’t a Static Site Generator
---

# SAASSG
```

···

~~~ javascript
{
	"layout": "three-column",
	"title": "Switzerland Ain’t a Static Site Generator"
    "slug": "switzerland-aint-a-static-site-generator",
    "body": "<h1 id=\"toc-saassg\">SAASSG</h1>"
}
~~~

#### The following keys are reserved:

 - `anchors`
 - `body`
 - `slug`


[man-cp]: http://ss64.com/osx/cp.html
[kramdown]: http://kramdown.rubyforge.org
[coderay]: http://coderay.rubychan.de
[markdown]: http://daringfireball.net/projects/markdown
[jekyll]: http://jekyllrb.com
[middleman]: http://middlemanapp.com
[phpmarkdownextra]: http://michelf.ca/projects/php-markdown/extra
[gfm]: http://github.github.com/github-flavored-markdown
[code-blocks]: http://kramdown.rubyforge.org/syntax.html#code-blocks
[code-class]: http://www.whatwg.org/specs/web-apps/current-work/multipage/text-level-semantics.html#the-code-element
[prism]: http://prismjs.com
[prettify]: http://code.google.com/p/google-code-prettify
